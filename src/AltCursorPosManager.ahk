;coordmode, mouse, screen
;maxhotkeysperinterval 1 sd
;thread, interrupt, -1
; create hot keyはキーバインドより先に最初に読み込まないと実行されない
; ->create_hotkeyの削除 うごくようになったか

#usehook

;#singleinstance, force

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
; for hotkey, value in keymap_value_dict 
;     create_hotkey(hotkey,value)

; ~での実装，支配度が高い
; Alt Ctrl dなどの実行の際にもこのキーは発火する，条件分岐で除外すれば問題ないと思うが

; firefox -> alt w (Cycle Last Used Tabs)
; normal -> lalt h

~RAlt & s::
~RAlt & d::
~RAlt & f::
~RAlt & g::
~RAlt & z::
~RAlt & x::
~RAlt & c::
~RAlt & v::
{
    ; sleep, 10
    if (GetKeyState("Shift")) 
    {
            windowpositionmovefunc() 
            move_corsor_to_active_centor()
    }
    else
    {
        ToolTip, %A_PriorHotKey% 
        a_hotkey := A_ThisHotkey 
        x := keymap_value_dict[a_hotkey]["x"]
        y := keymap_value_dict[a_hotkey]["y"]
        ; hwnd := getWindowHandlerAtPosition(x, y)
        ; wingettitle, title, ahk_id %hwnd%
        ; winactivate, ahk_id %hwnd%
        ; FlashWindow()
        ; tooltip, %A_PriorHotkey%
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

        ; MouseGetPos, xx,yy, ow, ovc, alm
        ; getWindowHandlerAtPosition()
        ; ToolTip, %out%
        ; MouseGetPos, xx,yy, ow, ovc, alm
        ; tooltip, %ow%
        ; tooltip, %A_PriorKey%kkku
        if (A_PriorHotkey != A_ThisHotkey){
            move_corsor_to_active_centor()
        }
        ; if (A_PriorHotkey = A_ThisHotkey){
        ;     window_array_under_cursor := GetWindowListAtPosition(x, y)
        ;     win_title := window_array_under_cursor[2]
        ;     OutputDebug, %win_title%`n 
        ;     WinActivate, %win_title%
        ; }
    }
    Return
}

~RAlt & a::
    window_array_under_cursor := GetWindowListAtPosition(x, y)
    win_title := window_array_under_cursor[2]
    OutputDebug, %win_title%`n 
    WinActivate, %win_title%
Return


; ~RAlt & a::
;     sleep, 10
;     if (GetKeyState("Shift")) 
;     {
;             windowpositionmovefunc() 
;             move_corsor_to_active_centor()
;     }
;     else
;     {
;         ; windowのサイズの取得
;         a_hotkey := A_ThisHotkey 
;         x := getSettingsValue([QuickMoveCursor, LeftUpLocX
;         y := keymap_value_dict[a_hotkey]["y"]
;         activatefunc(x, y)
;         ; move_corsor_to_active_centor()
;     }
;     Return
; }


; MoveCursorToXY(X, Y)
    ; MouseMove, cursor_pos_X, cursor_pos_Y,

; vk1d up::
; {
                ; send, {vkf3}
                ; return
; }

; create_hotkey(hotkey, value)
; {
;         hotkey, %hotkey%, mykey
;         return 
;         mykey:
;                 getkeystate var, shift 
;                 if (var = "d") ;ここわかりづらいから リファクタリングできるか
;                 {
;                         windowpositionmovefunc() 
;                         move_corsor_to_active_centor()
;                 }
;                 else
;                         movecursorfunc()
;         return
; }


; !l::
; !+l::
; wingetpos, x, y, width, height,a
; hotkey = %a_thishotkey%
; if cs_mode = on
; {
; x :=  x ;-  keymap_value_dict[hotkey]["x"]
; width := width + keymap_move_len[hotkey]["x"]
; height := height + keymap_move_len[hotkey]["y"]
; winmove, a,,x,y, width, height
; }
; if cs_mode = off
; {
;         send, %hotkey%
; }
; return 

; !j::
; !+j::
; wingetpos, x, y, width, height,a
; hotkey = %a_thishotkey%
; if cs_mode = on
; {
; x :=  x ;-  keymap_value_dict[hotkey]["x"]
; width := width + keymap_move_len[hotkey]["x"]
; height := height + keymap_move_len[hotkey]["y"]
; winmove, a,,x,y, width, height
; }
; if cs_mode = off
; {
;         send, %hotkey%
; }   
; return 

; ^!h::
; ^!j::
; ^!k::
; ^!l::
; global keymap_move_window_len := {"^!h":{x:-100, y:0}
; ,"^!j":{x:0, y:100}
; ,"^!k":{x:0, y:-100}
; ,"^!l":{x:100, y:0}}
; hotkey = %a_thishotkey%
; wingetpos, x, y, ,
; X := X + keymap_move_window_len[hotkey]["X"]
; Y := Y + keymap_move_window_len

; ctrl+tab

; RAlt Shift o or u :
; firefox: tree style tab 親タブ感の移動?
; RAltの上に実装している関係で，3キーバインドが難しい
; !o:: Send,^{Tab}
; !+u:: Send, !^u 

