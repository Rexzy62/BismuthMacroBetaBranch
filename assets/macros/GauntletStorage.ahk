WinActivate("Roblox")
Sleep 333
Sleep 300

Click 29, 508, 0
Sleep 10
Sleep 100
Click "Left", 1
Sleep 10
Sleep 300
Click 940, 333, 0
Sleep 100
Click "Left", 1

Send("{LWin down}{LShift down}{s down}")
Sleep 50
Send("{LWin up}{LShift up}{s up}")
Sleep 1000

Click 475, 271, "Down"
Click 1443, 805, "Up"
Sleep 1000
WinActivate("Roblox")
Sleep 333

    
Send("{LShift}")
MouseClick "Left"
Sleep 100
    

Sleep 333
Click 1415, 295, 0
Sleep 100
Click 1414, 295, 0
Sleep 100
Click "Left", 1

; === Get the user's "Pictures\Screenshots" folder ===
picturesPath := ComObject("Shell.Application").NameSpace(0x27).Self.Path
screenshotDir := picturesPath "\Screenshots"

; === Target directory inside the script's folder ===
targetDir := A_ScriptDir "\screens"
targetFile := targetDir "\GauntletStorage.png"

; === Create the target folder if it doesn't exist ===
if !DirExist(targetDir)
    DirCreate(targetDir)

; === Find the most recent .png file in the screenshot folder ===
latestFile := ""
latestTime := 0

Loop Files screenshotDir "\*.png", "F" {
    if A_LoopFileTimeModified > latestTime {
        latestTime := A_LoopFileTimeModified
        latestFile := A_LoopFilePath
    }
}

; === M ove and rename the file if found ===
if latestFile {
    FileMove(latestFile, targetFile, true) ; true = overwrite if exists
     
} else {
     
} 
 
