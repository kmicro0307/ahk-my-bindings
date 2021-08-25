#SingleInstance, Force

SetWorkingDir, %A_ScriptDir%

isSecondKeyAfterAltJ() {
    ; tooltip, %A_PriorHotkey%
    ; return (A_PriorHotKey = "$!j")
    Flag := AltPriorHotKey = "$!j"
     AltPriorHotKey := ""
    ; return (AltPriorHotKey = "$!j")
    return Flag 
}
isSecondColon() {
    ; ToolTip, %ab% 
    ; Ctrl を同一コードで書くとpriorがupになるため，globalから取ってきている
    ; tooltip, %A_PriorHotkey%
    ; tooltip, test
    ; tooltip, %SemicolonPressedStartTime%
    ; tooltip, %A_TickCount%
    ; tooltip, %A_PriorHotkey%
    ; flag := SemicolonPriorHotkey = "*; Up" and A_TickCount - SemicolonPressedStartTime < 400 and A_PriorHotkey="~Ctrl"
    ; if ( SemicolonPriorHotkey = "*; Up" and A_TickCount - SemicolonPressedStartTime < 400 and A_PriorHotkey="~Ctrl"){
    if ( SemicolonPriorHotkey = "*; Up" and A_TickCount - SemicolonPressedStartTime < 400 and A_PriorHotkey="~Ctrl"){
        SemicolonPressedStartTime := 0
        return True
    }
    if ( SemicolonPriorHotkey = "*; Up" and A_TickCount - SemicolonPressedStartTime < 400 and A_PriorHotkey="SC027 Up"){
        return True
    }
    ; SemicolonPriorHotkey = ""
    return False
    ; tooltip,
    ; return (A_PriorHotKey = "$^j")
}

isSecondKeyAfterCtrlJ() {
    ; ToolTip, %ab% 
    ; Ctrl を同一コードで書くとpriorがupになるため，globalから取ってきている
    return ("$^j" = CtrlPriorHotkey)
    ; return (A_PriorHotKey = "$^j")
}

isPressedKeyWithSemicolon() {
    return (GetKeyState(";", "P"))
}

isPressedKeyWithAt() {
    return (GetKeyState("@", "P"))
}

isActiveProcess(name) {
    pName := getSettingsValue("ProcessName", name)
    WinGet, ahk_process, ProcessName, A
    ; tooltip, %ahk_process%
    if (pName == ahk_process) {
        return true
    } else {
        return false
    }
}

getSettingsValue(section, key) {
    IniRead value, %A_ScriptDir%\settings\settings.ini, %section%, %key%
    return value
}

ActivateWindowByProcess(process) {
    pName := getSettingsValue("ProcessName", process)
    WinGet, hwnd, ID, ahk_exe %pName%
    WinActivate, ahk_id %hwnd%
}

ActivateWindowByTool(tool){
    clsname := getSettingsValue("WindowClassName", tool)
    WinGet, hwnd, ID, ahk_class %clsname%
    WinActivate, ahk_id %hwnd%
}

move_corsor_to_active_centor(){
    ;アクティブウィンドウのサイズを取得
    WinGetPos, X, Y, width,height, A
    ; MsgBox, %X%, %Y%, %width%, %height%
    cursor_pos_X := X + width/2
    cursor_pos_Y := Y + height/2
    ; MsgBox, %cursor_pos_X%, %cursor_pos_Y%
    MouseMove, cursor_pos_X, cursor_pos_Y,
}

optionfunc(){
        winget, processname, processname, a
                {
                    ; WinActivate, ahk_class WorkerW
                ; send, {ralt down}{tab}
                ; send, {ralt up}{tab}
                }
        }

movecursorfunc()
{
    hotkey = %a_thishotkey%
    x := keymap_value_dict[hotkey]["x"]
    y := keymap_value_dict[hotkey]["y"]
    activatefunc(x, y)
}

activatefunc(x, y)
{
        optionfunc() 
        mousemove, %x%, %y%, 
        mousegetpos,x,y,hwnd,ctrl,3
        wingettitle, title, ahk_id %hwnd%
        winactivate, ahk_id %hwnd%
        ReleaseModifiers()
        ; activatepopup()
        ; flashwindow()
}

;【概要】アクティブウィンドウをフラッシュします
;【引数】なし
;【戻値】なし
FlashWindow() {
    WinSet, Transparent, 128, A
    Sleep, 50
    WinSet, Transparent, OFF, A
}

;【概要】指定位置のウィンドウハンドラを取得する
;【引数】px: x座標, py: y座標
;【戻値】Window handler
getWindowHandlerAtPosition(px, py) {
    VarSetCapacity(POINT, 8, 0x00)
    NumPut(px, POINT, 0x00, "int")
    NumPut(py, POINT, 0x04, "int")
    HWND := DllCall("WindowFromPoint", "Int64", NumGet(POINT, 0x00, "int64"))
    ANCESTOR_HWND := DllCall("GetAncestor", "UInt", HWND, "UInt", GA_ROOT := 2)
    WinExist("ahk_id" . ANCESTOR_HWND)
    return %ANCESTOR_HWND%
}

; キー押しっぱなしを解除する
; これを入れると，変換の実行時間がのびて，PriorKeyに影響が出る
; -> CtrlPriorkeyの出力が j -> $^jになるなど(ちゃんと確認してはいないが)
; TODO: if文でいい感じにできるか
; 処理が重いのはSendだと思うので，その実行前に入力状態とかで場合分けしてSendするものを決めれば，軽くなるのではないか
ReleaseModifiers()
{
    ; send {Ctrl down} 
    send {Ctrl up}
    Send {LShift Up}
    Send {RShift Up}
    Send {LAlt Up}
    Send {RAlt Up}
    Send {LControl Up}  
    Send {RControl Up}
    ; reload, ; Avoid - Reloading AutoHotkey File causes functions depending on this function to break
    return 
}

SendSnippet(keys) {
    modifiers_up := GetModifiersUp()
    modifiers_down := GetModifiersDown()
    Send, %modifiers_up%%keys%%modifiers_down%
}

GetWindowListAtPosition(x, y){
    window_array_under_cursor := []
    WinGet, id, List,
    Loop, %id%
    {
        this_ID := id%A_Index%
        ; WinGetTitle, Out, ahk_id %this_ID% 
        WinGetPos, px_left, py_left, Width, Height, ahk_id %this_ID%
        px_right := px_left+Width
        py_right := py_left+Height

        If  (px_left<x and x<px_right)  ; Use Window Spy to find the exact position.
        {
            ; OutputDebug, %this_ID%`n
            WinGetTitle, Out, ahk_id %this_ID% 
            if (Out = ""){
                continue
            }
            if (Out = "NVIDIA GeForce Overlay" or Out = "Program Manager"){
                Continue
            }
            window_array_under_cursor.Insert(Out)
        }
    }
    return window_array_under_cursor
}

; SandS実装のためのコマンド
; ﾃｷｽﾄ入力の前後に物理、SandS関わらず修飾ｷｰの状態を取得、復元する
; (本来はBlindなしのSendがやってくれるが、 SandS実装の仮想ｷｰ押しは対応してない様なので} 
GetModifiersUp() {
    modifiers := ""
    If GetKeyState("Ctrl", "P")
        modifiers = %modifiers%{Ctrl Up}
    If GetKeyState("Shift", "P")
        modifiers = %modifiers%{Shift Up}
    If GetKeyState("Alt", "P")
        modifiers = %modifiers%{Alt Up}
    ; ここ副作用~
	if (GetKeyState("Space", "P")){
		modifiers = %modifiers%{RShift Up}
    }
	if GetKeyState("vk1D", "P")
		modifiers = %modifiers%{RCtrl Up}
		modifiers = %modifiers%{LCtrl Up}
    Return %modifiers%
}

GetModifiersDown() {
    modifiers := ""
    If GetKeyState("Ctrl", "P")
        modifiers = %modifiers%{Ctrl Down}
    If GetKeyState("Shift", "P")
        modifiers = %modifiers%{Shift Down}
    If GetKeyState("Alt", "P")
        modifiers = %modifiers%{Alt Down}
	if (GetKeyState("Space", "P")){
		modifiers = %modifiers%{RShift Down}
    }
	if GetKeyState("vk1D", "P")
		modifiers = %modifiers%{LCtrl Down}
    Return %modifiers%
}