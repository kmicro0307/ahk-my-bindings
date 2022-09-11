#SingleInstance, Force
; 画面変異の際のカーソル制御のためOFF
; SendMode Input
SetWorkingDir, %A_ScriptDir%

RAlt & j::Return
RAlt & k::Return
RAlt & l::
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

; 1920✕1080を前提にしている
; #IfWinNotActive ahk_class MultitaskingViewFrame
class MonitorProperty{
    __New(monitor_name, left, bottom, top, right){
        this.monitor_name := monitor_name
        this.left := Left
        this.bottom := bottom
        this.top := top
        this.right := right
        this.width := this.right - this.left
        this.height := this.bottom - this.top
        mod = % Mod(this.height, 1920)
        If (mod = 0)
            monitor_orient = vertical 
        this.monitor_orient := vertical
        mod = % Mod(this.width, 1920)
        If (mod = 0)
            monitor_orient = horizontal 
        this.monitor_orient := horizontal
    }

    ;TODO 縦か横かで、それぞれモニターごとに位置と隣のモニターの番号の対応付を格納する
    ;etc モニター1, 横の場合、{L:{left:None,down:3,top:None,right:1},R:{left:1.L,down:3.R,top:None,right:2.T}}
}

class MonitorManager{

    __New(){
        SysGet, MonitorCount, MonitorCount
        this.MonitorCount := MonitorCount
        this.Array := Object()
        this.Array[j] := A_LoopField
        ;his.MonitorPosList[j] := A_LoopField

        ;各モニターの情報をhashmapに取得
        ; 2021-02-24 わざわざ自動で取得させるより，手動で入力したほうが早い，モニターのサイズに比例した画面サイズにするわけでもないので
        this.MonitorPos := {B:0, U:0, R:0, L:0} ;B:左上の座標が(0,0)となるベースモニタ
        SysGet, MonitorPrimary, MonitorPrimary
        SysGet, Monitor, Monitor, %MonitorPrimary%
        SysGet, MonitorName, MonitorName, %A_Index%
        New MonitorProperty(MonitorName, MonitorLeft, MonitorBottom, MonitorTop, MonitorRight)
        m_base_p := New MonitorProperty(MonitorName, MonitorLeft, MonitorBottom, MonitorTop, MonitorRight)
        this.MonitorPos["B"] := m_base_p
        this.Array[base] := m_base_p 
        Loop, %MonitorCount%
        {
            if MonitorPrimary = %A_Index%
                continue
            SysGet, MonitorName, MonitorName, %A_Index%
            SysGet, Monitor, Monitor, %A_Index%
            m_p := New MonitorProperty(MonitorName, MonitorLeft, MonitorBottom, MonitorTop, MonitorRight)
            this.Array[A_Index] := m_p

            if (m_p.top >= 1070)
                this.MonitorPos["U"] := m_p
            if (m_p.left >= 1920)
                this.MonitorPos["R"] := m_p
            if (m_p.right <=0)
                this.MonitorPos["L"] := m_p
            ; this.MonitorPos[m_p.monitor_pos]
        }
    }

}

WindowPositionMoveFunc()
{
    ;このあたりinitで定義できるか
    keymap_positon_dict := {"~ralt & d":"U"
        ,"~ralt & s":"U"
        ,"~ralt & f":"R"
        ,"~ralt & v":"R"
        ,"~ralt & x":"B"
        ,"~ralt & c":"B"
        ,"~ralt & a":"L"
        ,"~ralt & g":"R"
    ,"~ralt & z":"L"}
    hotkey = %A_ThisHotkey%
    pos := keymap_positon_dict[hotkey] 
    mm := New MonitorManager()
    ; キーに対応したモニターの取得
    monitor := mm.MonitorPos[pos]

    keymap_position_XY := {"~RAlt & d":{"X":900,"Y":0}
,"~RAlt & s":{"X":0,"Y":0}
,"~RAlt & f":{"X":monitor.left,"Y":10000}
,"~RAlt & g":{"X":monitor.left+940,"Y":0}
,"~RAlt & v":{"X":monitor.left,"Y":monitor.height/2}
,"~RAlt & x":{"X":0,"Y":monitor.bottom}
,"~RAlt & c":{"X":monitor.right/2,"Y":monitor.m}
,"~RAlt & a":{"X":monitor.left,"Y":monitor.top}
,"~RAlt & z":{"X":monitor.left,"Y":monitor.bottom/2}}

    keymap_resize_XY := {"~RAlt & d":{"X":1020,"Y":1080 -40}
,"~RAlt & s":{"X":960,"Y": 1080 -40}
,"~RAlt & f":{"X":monitor.width/2,"Y":monitor.height/2}
,"~RAlt & g":{"X":940,"Y": 1080 - 40}
,"~RAlt & v":{"X":monitor.width/2,"Y":monitor.height/2}
,"~RAlt & x":{"X":monitor.width/2,"Y": monitor.height -30}
,"~RAlt & c":{"X":monitor.width/2,"Y":monitor.height -30}
,"~RAlt & a":{"X":monitor.width,"Y":monitor.height/2}
,"~RAlt & z":{"X":monitor.width,"Y":monitor.height/2}}

    X := keymap_position_XY[hotkey]["X"]
    Y := keymap_position_XY[hotkey]["Y"]
    resize_x := keymap_resize_XY[hotkey]["X"]
    resize_y := keymap_resize_XY[hotkey]["Y"]
    WinGetTitle, Title, A
    ; MsgBox %X%, %Y%
    WinMove %Title%, , %X%, %Y%, %resize_x%, %resize_y% 
}

~RAlt & s::
~RAlt & d::
~RAlt & f::
~RAlt & g::
~RAlt & z::
~RAlt & x::
~RAlt & c::
~RAlt & v::
~RAlt & b::
    {
        global keymap_move_len := {"!h":{x:100, y:0, f:"w"}
        ,"!+h":{x:-100, y:0, f:"w"}
        ,"!j":{x:0, y:100,f:"x"}
        ,"!+j":{x:0, y:-100,f:"w"}
        ,"!k":{x:0, y:100,f:"w"}
        ,"!+k":{x:0, y:-100,f:"w"}
        ,"!+l":{x:-100, y:0,f:"x"}
        ,"vk1d & z":"l"}

        global keymap_value_dict := {"~ralt & d":{x:1500, y:490}
        ,"~ralt & s":{x:455, y:490}
        ,"~ralt & f":{x:2400, y:480}
        ,"~ralt & v":{x:2400, y:1380}
        ,"~ralt & x":{x:389, y:1530}
        ,"~ralt & c":{x:1530, y:1500}
        ,"~ralt & a":{x:-540, y:394}
        ,"~ralt & z":{x:-540, y:600}
        ,"~ralt & b":{x:3360, y:1440}
        ,"~ralt & g":{x:3360, y:480}}

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

                ; move_corsor_to_active_centor()
                if not isActiveProcess("vrchat"){
                    MouseMove, x, y
                }
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
