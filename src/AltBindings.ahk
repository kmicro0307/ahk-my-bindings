#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%


RAlt & j::Return
RAlt & k::Return

RAlt & l::
    ; if (GetKeyState("Shift")){
    ;     if (isPressedKeyWithSemicolon()) {
    ;     } else if (isActiveProcess("firefox")) {
    ;         Send, {RAlt}{Shift}
    ;     } else {    
    ;         Send, {Blind}{RAlt}{Shift}h
    ;     }
    ; }
    if (isPressedKeyWithSemicolon()) {

    } else if (isActiveProcess("firefox")) {
        Send, {Blind}{Alt}2
    } else if (isActiveProcess("tablacus")) {
        Send, {Blind}{Lalt}{.}
    } else {    
        Send, {Blind}{RAlt}l
    }
Return

RAlt & h::
    ; if (GetKeyState("Shift")){
    ;     if (isPressedKeyWithSemicolon()) {
    ;     } else if (isActiveProcess("firefox")) {
    ;         Send, {RAlt}{Shift}
    ;     } else {    
    ;         Send, {Blind}{RAlt}{Shift}h
    ;     }
    ; }
    if (isPressedKeyWithSemicolon()) {
    } else if (isActiveProcess("firefox")) {
        Send, {Blind}{Alt}1
    } else if (isActiveProcess("tablacus")) {
        Send, {Blind}{Lalt}{,}
    } else {    
        Send, {Blind}{RAlt}h
   }
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

~RAlt & e::
        move_corsor_to_active_centor()
Return

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

; !u:: Send,^+{Tab}
; !+o:: Send, !^ 
RAlt & o::
    if (GetKeyState("Shift")){
        Send, !^o
    } else {
        Send,^{Tab}
    }
Return

RAlt & u::
    if (GetKeyState("Shift")){
        Send, !^u
        Return
    } else {
        Send,^+{Tab}
    }
Return

; RAlt & u::Send,^+{Tab}

; zoom in セミコロンは２キーバインドのため使えないので
; RAlt & q:: Send, ^;
; RAlt & h:: Send, +!{Left}
; RAlt & l:: Send, +!{Right}
; RAlt & .:: Send, !+l
; RAlt & ,:: Send, !+h

#k::
Send, {Blind}{LWin}{Up}
Return

#j::
Send, {Blind}{LWin}{Down}
Return

#h::
Send, {Blind}{LWin}{Left}
Return

#l::
;DllCall("LockWorkStation") 
Send, {Blind}{Left}
Return

; isSecondKey(){
;     return (A_PriorHotKey = "$")
; }

;~Alt::
;p = %A_PriorHotkey%
; MsgBox, %p%
; Input, h, L1, V,{RAlt}{Alt}{RAlt}

; if (isSecondKey()){
;     send, {alt down}{tab}
;     send, {alt up}{tab}
; }
;send, {alt down}{tab}
;send, {alt up}{tab}
;Return 

isDoubleKey() {
    return (A_PriorHotKey = A_ThisHotKey and A_TimeSincePriorHotkey < 400)
}


; ~RAlt::
;     tooltip, %A_PriorHotKey%
;     Return


~RAlt & w:: 
    Send {RAlt Down}{Tab}
Return
; RAlt & w:: 
;     ; SetKeyDelay -1   ; 置換先がマウスの場合は SetMouseDelayになる
;     ; tooltip, test
;     Send {Blind}{AltTab DownTemp}  ; "DownTemp"は"Down"に似ているが押下中はキーリピートを送る
; return

; RAlt & w up:: 
; SetKeyDelay -1  ; PressDurationパラメタを指定しない理由は後述
; Send {Blind}{AltTab Up}
; return
; $Altよりも~Altの方が動作安定する ?
;p = %A_PriorHotkey%
;MsgBox, %p%
; Input, h, L1, V,{RAlt}{Alt}{RAlt}
;    Send, {AltTabAtestndMenu} 
; if (isDoubleKey()){
;      send, {AltTabMenu}
;     ; send, {AltTab}
;     ; send, {alt down}{tab}
;     Sleep, 100 
;     send, {Enter} 
;     ; send, {alt up}{tab}
;     Sleep, 100 
;     WinGetPos, X, Y, width,height, A
;     ; MsgBox, %X%, %Y%, %width%, %height%
;     cursor_pos_X := X + width/2
;     cursor_pos_Y := Y + height/2
;     activatefunc(cursor_pos_X, cursor_pos_Y)
;     move_corsor_to_active_centor()
; }
;send, {alt down}{tab}
;send, {alt up{tab}
; Return 

