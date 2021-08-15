#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%



; Tab & w::
;     ActivateWindowByProcess("Obsidian")
;     return

; Tab & c::
;     ActivateWindowByProcess("Chrome")
;     return

; Tab & t::
;     ActivateWindowByProcess("terminal")
;    return

; Tab & e::
;     ActivateWindowByProcess("Obsidian")
;    return

; Tab & s::
;     ActivateWindowByProcess("intellij")
;     return

; Tab & v::
;     ActivateWindowByProcess("vscode")
;     return

; Tab & f::
;     ActivateWindowByProcess("firefox")
;     return

^Tab::
+Tab::
    Send, {Blind}{Tab}
    return

^+Tab::
    Send, {Blind}{Tab}
    return



Tab & q::
Tab & w::
Tab & e::
Tab & r::
Tab & t::
Tab & z::
Tab & x::
Tab & c::
Tab & v::
Tab & d::
Tab & f::
Tab & g::
{

global keymap_value_dict_a := {"tab & e":{x:1355, y:653}
    ,"tab & w":{x:355, y:653}
    ,"tab & r":{x:2444, y:588}
    ,"tab & v":{x:2530, y:1200}
    ,"tab & x":{x:389, y:1530}
    ,"tab & c":{x:1530, y:1500}
    ,"tab & q":{x:-540, y:394}
    ,"tab & t":{x:3200, y:500}
    ,"tab & d":{x:1355, y:653}
    ,"tab & g":{x:3200, y:500}
    ,"tab & f":{x:2444, y:588}}
    ; ToolTie, %A_PriorHotKey% 
    sleep, 10
        a_hotkey := A_ThisHotkey 
        x := keymap_value_dict_a[a_hotkey]["x"]
        y := keymap_value_dict_a[a_hotkey]["y"]
        ; hwnd := getWindowHandlerAtPosition(x, y)
        ; wingettitle, title, ahk_id %hwnd%
        ; winactivate, ahk_id %hwnd%
        ; FlashWindow()
        activatefunc(x, y)
        ; move_corsor_to_active_centor()
    Return
}

