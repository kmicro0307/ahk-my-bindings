#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

global KeyPressedStartTime := 0
RAlt::
    ; ToolTip, %KeyPressedStartTime% 
    if ( KeyPressedStartTime = 0 ){
        KeyPressedStartTime := A_TickCount
        ; 不具合あった場合DownTempも検討する
        ;Send {Blind}{Ctrl Down}
    }
Return
; ; $Altよりも~Altの方が動作安定する ?
; ;p = %A_PriorHotkey%
; ;MsgBox, %p%
; ; Input, h, L1, V,{RAlt}{Alt}{RAlt}
; if (isDoubleKey()){
;       send, {Alt down}{Tab}
;       send, {alt up}{tab}
;      Sleep, 100 
;       move_corsor_to_active_centor()
; }

+RAlt Up::
    ReleaseModifiers()
return

<!RAlt Up::
    ReleaseModifiers()
return

RAlt Up::
    global AltPriorHotkey := A_PriorHotkey
    global AltPriorkey := A_Priorkey
    Send, {AltUp}
    KeyPressedUpTime := A_TickCount
    PressedTime := KeyPressedUpTime-KeyPressedStartTime
    ; ToolTip, %A_PriorHotKey%
    ; ToolTip, 
    ;     (
    ;         %KeyPressedStartTime% 
    ;         %KeyPressedUpTime%
    ;         %PressedTime%
    ;     )
    ; ToolTip, %PressedTime% 
    If (KeyPressedUpTime- KeyPressedStartTime < 200 and A_PriorHotKey == "RAlt" and A_PriorKey == "RAlt")
    { 
        Send, {Escape}
        IME_SET(0)
        ; Send {Alt Down}{Tab}{Alt Up}
        ; ; ToolTip, %A_TimeSincePriorHotkey% 
        ; Sleep, 50
        ; FlashWindow()
        ; Sleep, 200
        ; move_corsor_to_active_centor()
    }
    KeyPressedStartTime := 0
    ; if (A_TimeSincePriorHotkey < 300 and A_PriorKey = "RAlt"){
Return 
