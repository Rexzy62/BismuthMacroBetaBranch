#Requires AutoHotkey v2.0
#SingleInstance force

WinActivate("Roblox")
Sleep(333)

ScriptDir := A_ScriptDir
IniDir := StrReplace(ScriptDir, "\assets\macros", "\config.ini")

AuraEnable := IniRead(IniDir , "Main", "AuraEnable", "NotFound")
Aura := IniRead(IniDir , "Main", "Aura", "Common")

if AuraEnable = 1 {
    Sleep(333)
    MouseMove(32, 424)
    Sleep(100)
    MouseMove(33, 425)
    Sleep(100)
    MouseClick("Left")
    Sleep(700)
    MouseMove(858, 369)
    MouseMove(859, 368)
    Sleep(500)
    MouseClick("Left")
    Sleep(700)
    Send(Aura)
    Sleep(100)
    MouseMove(820 ,429)
    MouseMove(820, 430)
    Loop 10 {
        Send("{WheelUp}")
        Sleep(10)
    }
    Sleep(400)
    MouseClick("Left")
    Sleep(400)
    MouseMove(200, 100)

x := 748
y := 624

color := PixelGetColor(x, y, "RGB")

targetColor := 0x9FF992

if (color = targetColor) {
    MouseMove(615, 640)
    MouseMove(615, 638)
    MouseClick("Left")
    Sleep(1000)
    MouseMove(1414, 298)
    MouseMove(1413, 298)
    MouseClick("Left")
    ExitApp()
} else {
    MouseMove(1414, 298)
    MouseMove(1413, 298)
    MouseClick("Left")
    ExitApp()
}


} else {
    ExitApp()
}
