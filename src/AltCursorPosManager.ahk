
#usehook

global keymap_move_len := {"!h":{x:100, y:0, f:"w"}
,"!+h":{x:-100, y:0, f:"w"}
,"!j":{x:0, y:100,f:"x"}
,"!+j":{x:0, y:-100,f:"w"}
,"!k":{x:0, y:100,f:"w"}
,"!+k":{x:0, y:-100,f:"w"}
,"!+l":{x:-100, y:0,f:"x"}
,"vk1d & z":"l"}

global keymap_value_dict := {"~ralt & d":{x:1355, y:653}
,"~ralt & s":{x:355, y:653}
,"~ralt & f":{x:2444, y:588}
,"~ralt & v":{x:2530, y:1200}
,"~ralt & x":{x:389, y:1530}
,"~ralt & c":{x:1530, y:1500}
,"~ralt & a":{x:-540, y:394}
,"~ralt & z":{x:-540, y:1254}
,"~ralt & g":{x:3200, y:500}}

~RAlt & s::
~RAlt & d::
~RAlt & f::
~RAlt & g::
~RAlt & z::
~RAlt & x::
~RAlt & c::
~RAlt & v::
    {
        if (GetKeyState("Shift")) 
        {
            windowpositionmovefunc() 
            move_corsor_to_active_centor()
        }
        else
        {
            ; ToolTip, %A_PriorHotKey% 
            a_hotkey := A_ThisHotkey 
            x := keymap_value_dict[a_hotkey]["x"]
            y := keymap_value_dict[a_hotkey]["y"]
            ; hwnd := getWindowHandlerAtPosition(x, y)
            ; wingettitle, title, ahk_id %hwnd%
            ; winactivate, ahk_id %hwnd%
            ; FlashWindow()
            VarSetCapacity(POINT, 8, 0x00)
            NumPut(x, POINT, 0x00, "int")
            NumPut(y, POINT, 0x04, "int")
            HWND := DllCall("WindowFromPoint", "Int64", NumGet(POINT, 0x00, "int64"))
            ANCESTOR_HWND := DllCall("GetAncestor", "UInt", HWND, "UInt", GA_ROOT := 2)

            ; ToolTip, %ANCESTOR_HWND%
            WinGetTitle, win_title, ahk_id %ANCESTOR_HWND%
            WinActivate, %win_title%

            ; tooltip, %hwnd%
            ; ANCESTOR_HWND := DllCall("GetAncestor", "UInt", NEXT_HWND, "UInt", GA_ROOT:= 2)
            ; tooltip, %ANCESTOR_HWND%

            MouseMove, x, y
        }
        Return
    }

~RAlt & a::
    mousegetpos,x,y,hwnd,ctrl,3
    window_array_under_cursor := GetWindowListAtPosition(x, y)
    win_title := window_array_under_cursor[2]
    ; OutputDebug, %win_title%`n 
    WinActivate, %win_title%
    mousegetpos,x,y,hwnd,ctrl,3
Return
