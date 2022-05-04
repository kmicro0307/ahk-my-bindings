#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

; BS & a::
; BS & s::
; BS & d::
; BS & f::
; BS & g::
; BS & z::
; BS & x::
; BS & c::
; BS & v::
; {
;     global keymap_value_dict_a := {"bs & d":{x:1355, y:653}
;         ,"bs & s":{x:355, y:653}
;         ,"bs & f":{x:2444, y:588}
;         ,"bs & v":{x:2530, y:1200}
;         ,"bs & x":{x:389, y:1530}
;         ,"bs & c":{x:1530, y:1500}
;         ,"bs & a":{x:-540, y:394}
;         ,"bs & z":{x:-540, y:1254}
;         ,"bs & g":{x:3200, y:500}}

;     ; ToolTip, %A_PriorHotKey% 
;     sleep, 10
;     if (GetKeyState("Shift")) 
;     {
;             windowpositionmovefunc() 
;             move_corsor_to_active_centor()
;     }
;     else
;     {
;         a_hotkey := A_ThisHotkey 
;         x := keymap_value_dict_a[a_hotkey]["x"]
;         y := keymap_value_dict_a[a_hotkey]["y"]
;         ; hwnd := getWindowHandlerAtPosition(x, y)
;         ; wingettitle, title, ahk_id %hwnd%
;         ; winactivate, ahk_id %hwnd%
;         ; FlashWindow()
;         activatefunc(x, y)
;         ; move_corsor_to_active_centor()
;     }
;     Return
; }

BS & a::
BS & s::
BS & d::
BS & f::
BS & g::
BS & z::
BS & x::
BS & c::
BS & v::
BS & e::
BS & r::
BS & w::
    key_process_dict := {"bs & d":"chrome"
        ,"bs & s":"intellij"
        ,"bs & e":"obsidian"
        ,"bs & f":"firefox"
        ,"bs & v":"vscode"
        ,"bs & a":""
        ,"bs & c":"chrome"
        ,"bs & z": ""
        ,"bs & g": "vscode"
        ,"bs & w": "terminal"}
    a_hotkey := A_ThisHotkey 
    ActivateWindowByProcess(key_process_dict[a_hotkey]) 
    move_corsor_to_active_centor()
Return

^BS::
    Send, {BackSpace}
     return

+BS::
    Send, {Blind}{BS}
     return
 
!BS::
    Send, {Blind}{BS}
     return
