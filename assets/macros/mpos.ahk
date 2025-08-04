#Requires AutoHotkey v2.0


loop {
    ShowMousePosAndColor()
    Sleep 1
}
ShowMousePosAndColor

ShowMousePosAndColor() {
    MouseGetPos &x, &y
    PixelGetColor &color, x, y
    ToolTip "Mouse X: " x " | Mouse Y: " y " | Color: " color
}
F3::ExitApp
