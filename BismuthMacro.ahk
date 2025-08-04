#Requires Autohotkey v2
#SingleInstance Force
;AutoGUI creator: Alguimist autohotkey.com/boards/viewtopic.php?f=64&t=89901
;AHKv2converter creator: github.com/mmikeww/AHK-v2-script-converter
;EasyAutoGUI-AHKv2 github.com/samfisherirl/Easy-Auto-GUI-for-AHK-v2

    CPath := A_ScriptDir "\config.ini"

    myGui := Gui()
    myGui.Opt("-MinimizeBox -MaximizeBox -Theme")
    Tab := myGui.Add("Tab3", "x0 y0 w510 h255", ["Main", "Crafting", "Detection", "Webhook", "Other", "Credits"])
    myGui.Title := "BismuthMacro"
    Tab.UseTab(1)
    myGui.Add("GroupBox", "x16 y32 w164 h84", "Main Settings")
    myGui.Add("GroupBox", "x360 y32 w120 h109", "Use Items")
    myGui.Add("GroupBox", "x184 y32 w166 h109", "Aura Equip")
    myGui.Add("Text", "x240 y48 w61 h23 +0x200", "Aura Name")
    myGui.Add("GroupBox", "x16 y120 w163 h80", "Pathing")
    myGui.Add("Text", "x32 y172 w16 h16 +0x200", "↪")
    myGui.Add("GroupBox", "x184 y144 w165 h56", "Daily Shop")
    myGui.Add("GroupBox", "x16 y200 w280 h44", "Export and Import")

    ;ObbyDo := myGui.Add("CheckBox", "x32 y56 w76 h23", "Do Obby")
    ;ObbyDo.OnEvent("Click", (*) => IniWrite(ObbyDo.Value, CPath, "Main", "ObbyDo"))

    QuestEnable := myGui.Add("CheckBox", "x32 y80 w120 h23", "Claim Quests")
    QuestEnable.OnEvent("Click", (*) => IniWrite(QuestEnable.Value, CPath, "Main", "QuestEnable"))

    AuraEnable := myGui.Add("CheckBox", "x208 y104 w128 h23", "Enable Auto Equip")
    AuraEnable.OnEvent("Click", (*) => IniWrite(AuraEnable.Value, CPath, "Main", "AuraEnable"))

    ;ROE := myGui.Add("CheckBox", "x32 y144 w81 h23", "Collect ROE")
    ;ROE.OnEvent("Click", (*) => IniWrite(ROE.Value, CPath, "Main", "ROE"))

    ;ItemEnable := myGui.Add("CheckBox", "x48 y168 w120 h23", "Collect Items")
    ;ItemEnable.OnEvent("Click", (*) => IniWrite(ItemEnable.Value, CPath, "Main", "ItemEnable"))
    
    ;DailyEnable := myGui.Add("CheckBox", "x192 y165 w55 h23", "Enable")
    ;DailyEnable.OnEvent("Click", (*) => IniWrite(DailyEnable.Value, CPath, "Main", "DailyEnable"))
    
    ;ItemUse := myGui.Add("CheckBox", "x392 y56 w56 h23", "Enable")
    ;ItemUse.OnEvent("Click", (*) => IniWrite(ItemUse.Value, CPath, "Main", "ItemUse"))

    Aura := myGui.Add("Edit", "x200 y72 w133 h21")
    Aura.OnEvent("Change", (*) => IniWrite(Aura.Value, CPath, "Main", "Aura"))

    Export := myGui.Add("Button", "x24 y216 w120 h23", "Export to Clipboard")
    Export.OnEvent("Click", (*) => ExportSettings())


    PH := myGui.Add("Button", "x128 y144 w23 h21", "?")
    AH := myGui.Add("Button", "x318 y44 w25 h23", "!")
    ;DailyConfig := myGui.Add("Button", "x256 y165 w80 h23", "Config")
    ;DailyConfig.OnEvent("Click", (*) => Run(A_ScriptDir "\Shop.ahk"))
    Import := myGui.Add("Button", "x168 y215 w120 h23", "Import from Clipboard")
    Import.OnEvent("Click", (*) => ImportSettings())

    ;ItemConfig := myGui.Add("Button", "x380 y80 w80 h23", "Edit Config")
    ;ItemConfig.OnEvent("Click", (*) => Run(A_ScriptDir "\UseItem.ahk"))

    Start := myGui.Add("Button", "x408 y216 w80 h23", "Start (F1)")
    Stop := myGui.Add("Button", "x320 y217 w80 h23", "Stop (F2)")

    PH.OnEvent("Click", (*) => MsgBox(" ROE = Resonance of Elements `n Collet Items Will Collet Items On the Way.", "Pathing Help" , 0x40))
    AH.OnEvent("Click", (*) => MsgBox("Please Use A Ground Aura where the Player is not floating.", "Aura Eqiup Help" , 0x40))

    Tab.UseTab(2)
    myGui.Add("GroupBox", "x16 y32 w176 h155", "Gauntlet Crafting")
    myGui.Add("Text", "x331 y152 w36 h23 +0x200", "Slot 3")
    myGui.Add("Text", "x330 y119 w39 h23 +0x200", "Slot 2")
    myGui.Add("Text", "x330 y86 w33 h23 +0x200", "Slot 1")
    myGui.Add("Text", "x64 y136 w55 h16 +0x200", "Craft every")
    myGui.Add("GroupBox", "x312 y32 w176 h155", "Potion Crafting")

    GauntletEnable := myGui.Add("CheckBox", "x32 y56 w95 h23", "Enable Crafting")
    GauntletEnable.OnEvent("Click", (*) => IniWrite(GauntletEnable.Value, CPath, "Crafting", "GauntletEnable"))

    EquipAfter := myGui.Add("CheckBox", "x32 y80 w74 h23", "Equip after")
    EquipAfter.OnEvent("Click", (*) => IniWrite(EquipAfter.Value, CPath, "Crafting", "EquipAfter"))
    
    PotionEnable := myGui.Add("CheckBox", "x328 y56 w99 h22", "Enable Crafting")
    PotionEnable.OnEvent("Click", (*) => IniWrite(PotionEnable.Value, CPath, "Crafting", "PotionEnable"))

    Device := myGui.Add("DropDownList", "x32 y112 w120", ["Exoflex Device", "Hologrammer", "Ragnaröker", "Starshaper", "Neuralyzer", "Darkshader"])
    Device.OnEvent("Change", (*) => IniWrite(Device.Value, CPath, "Crafting", "Device"))

    S1 := myGui.Add("DropDownList", "x376 y88 w99", ["fortune 1", "fortune 2", "fortune 3", "haste 1", "haste 2", "haste 3", "potion of bound", "heavenly potion", "rage potion", "diver potion", "jewelry potion", "zombie potion", "Godly potion (zeus)", "Godly potion (hades)", "godly potion (posidon)", "godlike potion", "warp potion", "", ""])
    S1.OnEvent("Change", (*) => IniWrite(S1.Value, CPath, "Crafting", "S1"))

    S2 := myGui.Add("DropDownList", "x376 y120 w99", ["fortune 1", "fortune 2", "fortune 3", "haste 1", "haste 2", "haste 3", "potion of bound", "heavenly potion", "rage potion", "diver potion", "jewelry potion", "zombie potion", "Godly potion (zeus)", "Godly potion (hades)", "godly potion (posidon)", "godlike potion", "warp potion", "", ""])
    S2.OnEvent("Change", (*) => IniWrite(S2.Value, CPath, "Crafting", "S2"))

    S3 := myGui.Add("DropDownList", "x376 y152 w98", ["fortune 1", "fortune 2", "fortune 3", "haste 1", "haste 2", "haste 3", "potion of bound", "heavenly potion", "rage potion", "diver potion", "jewelry potion", "zombie potion", "Godly potion (zeus)", "Godly potion (hades)", "godly potion (posidon)", "godlike potion", "warp potion", "", ""])
    S3.OnEvent("Change", (*) => IniWrite(S3.Value, CPath, "Crafting", "S3"))

    GCooldown := myGui.Add("Edit", "x32 y152 w120 h21")
    GCooldown.OnEvent("Change", (*) => GCooldown.Value := RegExReplace(GCooldown.Value, "[^\d]"))
    GCooldown.OnEvent("Change", (*) => IniWrite(GCooldown.Value, CPath, "Crafting", "GCooldown"))

    GH := myGui.Add("Button", "x160 y48 w24 h23", "!")
    GH.OnEvent("Click", (*) => MsgBox("The Cooldown Time has to be listed in Minutes.", "Gauntlet Crafting Help" , 0x40))

    PH := myGui.Add("Button", "x448 y48 w27 h25", "!")
    PH.OnEvent("Click", (*) => MsgBox("One Potion cannot be used in 2 Slots.", "Potion Crafting Help" , 0x40))

    Tab.UseTab(3)
    myGui.Add("GroupBox", "x8 y24 w483 h58", "Information")
    myGui.Add("Text", "x16 y40 w437 h20 +0x200", "This section is WIP any may Change at any time removing some features if you have")
    myGui.Add("Text", "x16 y56 w174 h20 +0x200", "changes you would like to suggest")
    myGui.Add("Link", "x184 y59 w120 h16", "<a href=`"https://discord.gg/aKsZnR2Spj`">Checkout the Discord</a>")
    myGui.Add("GroupBox", "x8 y96 w133 h95", "Star Config")
    myGui.Add("GroupBox", "x192 y96 w120 h95", "Mechant Detection")
    myGui.Add("GroupBox", "x360 y96 w123 h95", "Biome Config")

    SConfig := myGui.Add("CheckBox", "x24 y112 w88 h23", "Enable Pings")
    SConfig.OnEvent("Click", (*) => IniWrite(SConfig.Value, CPath, "Detection", "SConfig"))

    MConfig := myGui.Add("CheckBox", "x208 y114 w83 h23", "Enable Pings")
    MConfig.OnEvent("Click", (*) => IniWrite(MConfig.Value, CPath, "Detection", "MConfig"))

    BConfig := myGui.Add("CheckBox", "x376 y112 w86 h23", "Enable Pings")
    BConfig.OnEvent("Click", (*) => IniWrite(BConfig.Value, CPath, "Detection", "BConfig"))

    BSConfig := myGui.Add("Button", "x32 y144 w80 h23", "Config")
    BSConfig.OnEvent("Click", (*) => Run(A_ScriptDir "\StarConfig.ahk"))
    BBConfig := myGui.Add("Text", "x384 y144 w80 h23", "Config Soon!")

    Tab.UseTab(4)
    myGui.Add("GroupBox", "x8 y24 w480 h89", "Webhook Config")
    myGui.Add("GroupBox", "x8 y120 w293 h121", "Webhook settings")
    myGui.Add("GroupBox", "x360 y120 w129 h121", "Test Webhook")

    WL := myGui.Add("Edit", "x16 y43 w461 h21", "Webhook id Ex. https://discord.com/api/webhooks/...")
    WL.OnEvent("Change", (*) => IniWrite(WL.Value, CPath, "Webhook", "WebhookLink"))

    DID := myGui.Add("Edit", "x16 y80 w120 h21", "Discord Id")
    DID.OnEvent("Change", (*) => DID.Value := RegExReplace(DID.Value, "[^\d]"))
    DID.OnEvent("Change", (*) => IniWrite(DID.Value, CPath, "Webhook", "DID"))
    
    OtherWebhook := myGui.Add("CheckBox", "x24 y136 w97 h23", "Send Misc. Info")
    OtherWebhook.OnEvent("Click", (*) => IniWrite(OtherWebhook.Value, CPath, "Webhook", "Other"))
    
    BiomeWebhook := myGui.Add("CheckBox", "x24 y160 w106 h23", "Biome Detection")
    BiomeWebhook.OnEvent("Click", (*) => IniWrite(BiomeWebhook.Value, CPath, "Webhook", "Biome"))
    
    ;StarWebhook := myGui.Add("Checkbox", "x24 y185 w93 h23", "Star Detection")
    ;StarWebhook.OnEvent("Click", (*) => IniWrite(StarWebhook.Value, CPath, "Webhook", "Star"))
    
    ;MerchantWebhook := myGui.Add("CheckBox", "x24 y208 w114 h23", "Merchant Detection")
    ;MerchantWebhook.OnEvent("Click", (*) => IniWrite(MerchantWebhook.Value, CPath, "Webhook", "Merchant"))
    
    InvScreen := myGui.Add("CheckBox", "x160 y136 w137 h23", "Inventory Screenshots")
    InvScreen.OnEvent("Click", (*) => IniWrite(InvScreen.Value, CPath, "Webhook", "InvScreen"))
    
    QuestScreen := myGui.Add("CheckBox", "x136 y160 w158 h23", "Quest Progress Screenshots")
    QuestScreen.OnEvent("Click", (*) => IniWrite(QuestScreen.Value, CPath, "Webhook", "QuestScreen"))
    
    PotionScreen := myGui.Add("CheckBox", "x168 y184 w120 h23", "Send Potion Storage")
    PotionScreen.OnEvent("Click", (*) => IniWrite(PotionScreen.Value, CPath, "Webhook", "PotionScreen"))
    
    BNormalMessage := myGui.Add("Button", "x368 y136 w114 h26", "Test default")
    BEmbedMessage := myGui.Add("Button", "x368 y176 w114 h23", "Test Ping")
    AllMessage := myGui.Add("Button", "x368 y213 w114 h23", "All in One Test")
    BNormalMessage.OnEvent("Click", (*) => Run(A_ScriptDir "\assets\1.pyw"))
    BEmbedMessage.OnEvent("Click", (*) => Run(A_ScriptDir "\assets\2.pyw"))
    AllMessage.OnEvent("Click", (*) => Run(A_ScriptDir "\assets\3.pyw"))
    
    WH := myGui.Add("Button", "x448 y80 w26 h23", "?")
    ;oh god what is this
    WH.OnEvent("Click", (*) => MsgBox("Webhook ID is the URL you get from a webhook.`nDiscord ID is your Discord User ID.`nFor further help, visit the Credit Tab", "Webhook Help", 0x40))
    
    Tab.UseTab(5)
    myGui.Add("GroupBox", "x8 y32 w185 h112", "Restart Roblox")

    RCooldown := myGui.Add("Edit", "x40 y80 w120 h21", "Restart Every ... Hours")
    RCooldown.OnEvent("Change", (*) => IniWrite(RCooldown.Value, CPath, "Other", "RCooldown"))
    RCooldown.OnEvent("Change", (*) => RCooldown.Value := RegExReplace(RCooldown.Value, "[^\d]"))
    
    RestartEnable := myGui.Add("CheckBox", "x64 y56 w57 h23", "Enable")
    RestartEnable.OnEvent("Click", (*) => IniWrite(RestartEnable.Value, CPath, "Other", "RestartEnable"))
    
    RH := myGui.Add("Button", "x160 y45 w25 h23", "!")
    RH.OnEvent("Click", (*) => MsgBox("The Restart Cooldown is in Hours, if you want to restart every 6 hours, enter 6.", "Restart Help" , 0x40))

    Tab.UseTab(6)
    myGui.Add("GroupBox", "x240 y32 w120 h52", "HM")
    myGui.Add("GroupBox", "x8 y32 w101 h72", "UI")
    myGui.Add("GroupBox", "x8 y214 w120 h33", "Discord Link")
    myGui.Add("Text", "x24 y48 w76 h23 +0x200", "Easy Auto GUI")
    myGui.Add("Text", "x24 y72 w45 h23 +0x200", "Rexzy61")
    myGui.Add("GroupBox", "x112 y32 w120 h46", "1440p Testing")
    myGui.Add("Text", "x144 y48 w53 h23 +0x200", "Ahhexotic")
    myGui.Add("GroupBox", "x112 y80 w120 h68", "Pathing")
    myGui.Add("Text", "x131 y96 w85 h23 +0x200", "CatIsEatingFood")
    myGui.Add("Text", "x147 y120 w48 h23 +0x200", "Rexzy61")
    myGui.Add("Text", "x280 y48 w39 h23 +0x200", "shovel")
    myGui.Add("GroupBox", "x8 y104 w100 h80", "Webhook")
    myGui.Add("Text", "x32 y120 w43 h23 +0x200", "ExaNux")
    myGui.Add("Text", "x40 y144 w25 h23 +0x200", "Edo")
    myGui.Add("Link", "x48 y228 w24 h15", "<a href=`"https://discord.gg/aKsZnR2Spj`">here</a>")
    myGui.Add("Link", "x400 y228 w100 h15", "<a href=`"https://www.youtube.com/watch?v=fKksxz2Gdnc`">Webhook Tutorial</a>")
    myGui.Add("Link", "x400 y213 w100 h15", "<a href=`"https://www.youtube.com/watch?v=mc3cV57m3mM`">Discord ID Tutorial</a>")
    
    
    
    ;load ini shit
    ;ObbyDo.Value := IniRead(CPath, "Main", "ObbyDo", 0)
    QuestEnable.Value := IniRead(CPath, "Main", "QuestEnable", 0)
    AuraEnable.Value := IniRead(CPath, "Main", "AuraEnable", 0)
    ;ROE.Value := IniRead(CPath, "Main", "ROE", 0)
    ;ItemEnable.Value := IniRead(CPath, "Main", "ItemEnable", 0)
    ;DailyEnable.Value := IniRead(CPath, "Main", "DailyEnable", 0)
    ;ItemUse.Value := IniRead(CPath, "Main", "ItemUse", 0)
    Aura.Value := IniRead(CPath, "Main", "Aura", "")
    GauntletEnable.Value := IniRead(CPath, "Crafting", "GauntletEnable", 0)
    EquipAfter.Value := IniRead(CPath, "Crafting", "EquipAfter", 0)
    PotionEnable.Value := IniRead(CPath, "Crafting", "PotionEnable", 0)
    Device.Value := IniRead(CPath, "Crafting", "Device", 1)
    S1.Value := IniRead(CPath, "Crafting", "S1", 1)
    S2.Value := IniRead(CPath, "Crafting", "S2", 1)
    S3.Value := IniRead(CPath, "Crafting", "S3", 1)
    GCooldown.Value := IniRead(CPath, "Crafting", "GCooldown", "")
    SConfig.Value := IniRead(CPath, "Detection", "SConfig", 0)
    MConfig.Value := IniRead(CPath, "Detection", "MConfig", 0)
    BConfig.Value := IniRead(CPath, "Detection", "BConfig", 0)
    WL.Value := IniRead(CPath, "Webhook", "WebhookLink", "")
    DID.Value := IniRead(CPath, "Webhook", "DID", "")
    OtherWebhook.Value := IniRead(CPath, "Webhook", "Other", 0)
    BiomeWebhook.Value := IniRead(CPath, "Webhook", "Biome", 0)
    ;StarWebhook.Value := IniRead(CPath, "Webhook", "Star", 0)
    ;MerchantWebhook.Value := IniRead(CPath, "Webhook", "Merchant", 0)
    InvScreen.Value := IniRead(CPath, "Webhook", "InvScreen", 0)
    QuestScreen.Value := IniRead(CPath, "Webhook", "QuestScreen", 0)
    PotionScreen.Value := IniRead(CPath, "Webhook", "PotionScrren", 0)
    RCooldown.Value := IniRead(CPath, "Other", "RCooldown", "")
    RestartEnable.Value := IniRead(CPath, "Other", "RestartEnable", 0)

        myGui.Show()
    
    ; Copy current settings Into Clipboard
    ExportSettings(*) {
        try {
            content := FileRead(CPath)
            A_Clipboard := content
            MsgBox("Export complete", "Export Settings", 0x40)
        } catch as e {
            MsgBox("Failed to export: " e.Message, "Export Error", 0x10)
        }
    }
    
    ImportSettings(*) {
        try {
            content := A_Clipboard
            FileDelete(CPath)
            FileAppend(content, CPath)
            MsgBox("Import complete", "Import Settings", 0x40)
            Reload()
        } catch as e {
            MsgBox("Failed to import: " e.Message, "Import Error", 0x10)
        }
    }