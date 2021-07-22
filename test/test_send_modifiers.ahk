#SingleInstance, Force
SendMode Input

SendBlind(keys) {
    modifiers := GetModifiers()
    ; ToolTip, %keys%
    Send, %modifiers%%keys%
}
 
GetModifiers() {
    modifiers := ""
    If GetKeyState("Ctrl", "P")
        modifiers = %modifiers%^
    If GetKeyState("Shift", "P")
        modifiers = %modifiers%+
    If GetKeyState("Alt", "P")
        modifiers = %modifiers%!
    If GetKeyState("Win", "P")
        modifiers = %modifiers%`#
	if (GetKeyState("Space", "P")){
        ToolTip, test
		modifiers = %modifiers%{RShift Up}
    }
	if GetKeyState("vk1D", "P")
		modifiers = %modifiers%{RCtrl Up}

    Return %modifiers%
}

+q:: SendBlind("ab")
