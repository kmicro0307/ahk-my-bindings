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

isSecondKeyAfterCtrlJ() {
    ; ToolTip, %ab% 
    ; Ctrl を同一コードで書くとpriorがupになるため，globalから取ってきている
    return ("$^j" = CtrlPriorHotkey)
    ; return (A_PriorHotKey = "$^j")
}

isPressedKeyWithSemicolon() {
    return (GetKeyState(";", "P"))
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
        ifinstring, processname , vrchat.exe
                {
                send, {alt down}{tab}
                send, {alt up}{tab}
                }
         ifinstring, processname , umamusume.exe
                {
                send, {alt down}{tab}
                send, {alt up}{tab}
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
        ; activatepopup()
        ; flashwindow()
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
		modifiers = %modifiers%{RCtrl Down}
    Return %modifiers%
}