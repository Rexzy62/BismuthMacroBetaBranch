#Requires AutoHotkey v2.0
#SingleInstance Force

loop {
    x := 100
    y := 1000
    color := PixelGetColor(x, y, "RGB")
    targetColor := 0x000000

    if (color = targetColor) {
        x := 1800
        y := 1000
        color := PixelGetColor(x, y, "RGB")

        if (color = targetColor) {
            SendWebhook()
            Sleep(5000) ; wait to avoid spamming
        }
    }
    Sleep(100)
}

SendWebhook() {
    webhookURL := "https://discord.com/api/webhooks/1371897234832232458/YU9MkQueajwYanQmHGx_4VVILUy4v2zyJmWhhywAouUWiigDXuYP4SYtp4cNb0oAfSYh"
MsgBox "Sending webhook to: " webhookURL
    embed := Map(
        "title", "✅ AHK v2 Test Embed",
        "description", "This is a test embed sent from AutoHotkey v2!",
        "color", 0x00FF00
    )

    payload := Map(
        "username", "AHK Bot",
        "embeds", [embed]
    )

    json := Jxon_Dump(payload)

    http := ComObject("WinHttp.WinHttpRequest.5.1")
    http.Open("POST", webhookURL, false)
    http.SetRequestHeader("Content-Type", "application/json")
    http.Send(json)

    MsgBox http.Status " – " http.ResponseText
}

Jxon_Dump(obj) {
    static q := Chr(34)
    if IsObject(obj) {
        isArr := 0
        for k in obj {
            if !IsInteger(k) or k != ++isArr {
                isArr := 0
                break
            }
        }
        s := isArr ? "[" : "{"
        for k, v in obj {
            if !isArr
                s .= q k q ":"
            s .= Jxon_Dump(v) ","
        }
        return SubStr(s, 1, -1) . (isArr ? "]" : "}")
    } else if Type(obj) = "String"
        return q . StrReplace(StrReplace(obj, "\", "\\"), q, "\" q) . q
    else if Type(obj) = "Number"
        return obj
    else
        return "null"
}
