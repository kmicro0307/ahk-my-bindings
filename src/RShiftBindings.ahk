#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%


<+f::
    Send, {RAlt}f
    return

<+d::
    Send, {RAlt}d
    return

<+s::
    Send, {Alt}s
    return

<+c::
    Send, {AltDown}c{AltUp}
    return

<+x::
    Send, {Alt}x
    return

<+v::
    Send, {Alt}v
    return
; MButton::
;     Send, test
;     Return

~LShift & a::
~LShift & s::
~LShift & d::
~LShift & f::
~LShift & g::
~LShift & z::
~LShift & x::
~LShift & c::
~LShift & v::
{
    sleep, 10
    keymap_move_len_bs := {"!h":{x:100, y:0, f:"w"}
        ,"!+h":{x:-100, y:0, f:"w"}
        ,"!j":{x:0, y:100,f:"x"}
        ,"!+j":{x:0, y:-100,f:"w"}
        ,"!k":{x:0, y:100,f:"w"}
        ,"!+k":{x:0, y:-100,f:"w"}
        ,"!+l":{x:-100, y:0,f:"x"}}

    keymap_value_dict_shift := {"~lshift & d":{x:1355, y:653}
        ,"~lshift & s":{x:355, y:653}
        ,"~lshift & f":{x:2444, y:588}
        ,"~lshift & v":{x:2530, y:1200}
        ,"~lshift & x":{x:389, y:1530}
        ,"~lshift & c":{x:1530, y:1500}
        ,"~lshift & a":{x:-540, y:394}
        ,"~lshift & z":{x:-540, y:1254}
        ,"~lshift & g":{x:3200, y:500}}

        a_hotkey := A_ThisHotkey 
        ; ToolTip, %a_hotkey%
        x := keymap_value_dict_shift[a_hotkey]["x"]
        y := keymap_value_dict_shift[a_hotkey]["y"]
        ; hwnd := getWindowHandlerAtPosition(x, y)
        ; wingettitle, title, ahk_id %hwnd%
        ; winactivate, ahk_id %hwnd%
        ; FlashWindow()
        activatefunc(x, y)
        ; move_corsor_to_active_centor()
    Return
}
