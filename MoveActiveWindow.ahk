; 1920✕1080を前提にしている
; #IfWinNotActive ahk_class MultitaskingViewFrame
#IfWinActive 

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
    ,"~ralt & z":"L"}
    hotkey = %A_ThisHotkey%
    pos := keymap_positon_dict[hotkey] 
    mm := New MonitorManager()
    ; キーに対応したモニターの取得
    monitor := mm.MonitorPos[pos]

    keymap_position_XY := {"~RAlt & d":{"X":900,"Y":0}
    ,"~RAlt & s":{"X":0,"Y":0}
    ,"~RAlt & f":{"X":monitor.left,"Y":0}
    ,"~RAlt & v":{"X":monitor.left,"Y":monitor.height/2}
    ,"~RAlt & x":{"X":0,"Y":monitor.bottom}
    ,"~RAlt & c":{"X":monitor.right/2,"Y":monitor.m}
    ,"~RAlt & a":{"X":monitor.left,"Y":monitor.top}
    ,"~RAlt & z":{"X":monitor.left,"Y":monitor.bottom/2}}

        keymap_resize_XY := {"~RAlt & d":{"X":1020,"Y":1080 -40}
    ,"~RAlt & s":{"X":960,"Y": 1080 -40}
    ,"~RAlt & f":{"X":940,"Y":monitor.height}
    ,"~RAlt & v":{"X":monitor.width,"Y":monitor.height/2}
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

    ;TODO 
    ;hjklでモニター移動
    ;モニターをグリッドとして考えて実装
    ;etc 縦2横3のグリッドなら
    ;123
    ;456 というふうにモニターを考える

    ; global keymap_positon_dict := {"#d":"U"
    ;     ,"#s":"U"
    ;     ,"#f":"R"
    ;     ,"#v":"R"
    ;     ,"#x":"B"
    ;     ,"#c":"B"
    ;     ,"#a":"L"
    ;     ,"#z":"L"}

    ; mm := New MonitorManager()

    ; #f::
    ; #v::
    ; #s::
    ; #d::
    ; #x::
    ; #c::
    ; #a::
    ; #z::
    ;     hotkey = %A_ThisHotkey%
    ;     pos := keymap_positon_dict[hotkey] 
    ;     monitor := mm.MonitorPos[pos]
    ;     keymap_position_XY := {"#d":{"X":monitor.width/2,"Y":0}
    ;     ,"#s":{"X":0,"Y":0}
    ;     ,"#f":{"X":monitor.left,"Y":0}
    ;     ,"#v":{"X":monitor.left,"Y":monitor.height/2}
    ;     ,"#x":{"X":0,"Y":monitor.bottom}
    ;     ,"#c":{"X":monitor.right/2,"Y":monitor.m}
    ;     ,"#a":{"X":monitor.left,"Y":monitor.top}
    ;     ,"#z":{"X":monitor.left,"Y":monitor.bottom/2}}

    ;     keymap_resize_XY := {"#d":{"X":monitor.width/2,"Y":monitor.height -30}
    ;     ,"#s":{"X":monditor.width/2,"Y":monitor.height -30}
    ;     ,"#f":{"X":monitor.width,"Y":monitor.height/2}
    ;     ,"#v":{"X":monitor.width,"Y":monitor.height/2}
    ;     ,"#x":{"X":monitor.width/2,"Y": monitor.height -30}
    ;     ,"#c":{"X":monitor.width/2,"Y":monitor.height -30}
    ;     ,"#a":{"X":monitor.width,"Y":monitor.height/2}
    ;     ,"#z":{"X":monitor.width,"Y":monitor.height/2}}

    ;     X := keymap_position_XY[hotkey]["X"]
    ;     Y := keymap_position_XY[hotkey]["Y"]
    ;     resize_x := keymap_resize_XY[hotkey]["X"]
    ;     resize_y := keymap_resize_XY[hotkey]["Y"]
    ;     WinGetTitle, Title, A
    ;     ;MsgBox %Title%, %X%, %Y%
    ;     WinMove %Title%, , %X%, %Y%, %resize_x%, %resize_y%
    ; return 