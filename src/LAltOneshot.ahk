#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

; ~*LAlt::
;     if (LAltKeyPressedStartTime = ""){
;         LAltKeyPressedStartTime := 0
;     }
;     if ( LAltKeyPressedStartTime = 0 ){
;         LAltKeyPressedStartTime := A_TickCount
;     }
; Return

*LAlt Up::
    Send, {F24}
    Send, {LAlt Up}
    global AltPriorHotkey := A_PriorHotkey
    global AltPriorkey := A_Priorkey
    LAltKeyPressedUpFFFFTime := A_TickCount
    OutputDebug, %LAltKeyPressedStartTime%`n
    OutputDebug, %LAltKeyPressedUpTime%`n
    ; OutputDebug, %A_TimeIdle%`n
    ; OutputDebug, %A_TimeIdleKeyboard%`n
    ; OutputDebug, %A_TimeIdlePhysical%`n
    ; OutputDebug, %A_TimeSincePriorHotkey%`n
    ; OutputDebug, %A_TimeSinceThisHotkey%`n
    LAltPressedTime := LAltKeyPressedUpTime-LAltKeyPressedStartTime
    ; ToolTip, 
    ;     (
    ;         %KeyPressedUpTime%
    ;         %PressedTime%
    ;     )
    If (LAltPressedTime  < 200 and A_PriorHotKey = "*F14")
    { 
        IME_SET(1)
        ; Send {Alt Down}{Tab}{Alt Up}
        ; ; ToolTip, %A_TimeSincePriorHotkey% 
        ; Sleep, 50
        ; FlashWindow()
        ; Sleep, 200
        ; move_corsor_to_active_centor()
    }
    ; if (A_TimeSincePriorHotkey < 300 and A_PriorKey = "RAlt"){
        LAltKeyPressedStartTime = 0
Return

*F14::
    if (LAltKeyPressedStartTime = ""){
        LAltKeyPressedStartTime := 0
    }
    if ( LAltKeyPressedStartTime = 0 ){
        Send, {LAlt Down}
        LAltKeyPressedStartTime := A_TickCount
    }
Return

*F14 Up::
    Send, {F24}
    Send, {LAlt Up}
    global AltPriorHotkey := A_PriorHotkey
    global AltPriorkey := A_Priorkey
    LAltKeyPressedUpTime := A_TickCount
    OutputDebug, %LAltKeyPressedStartTime%`n
    OutputDebug, %LAltKeyPressedUpTime%`n
    ; OutputDebug, %A_TimeIdle%`n
    ; OutputDebug, %A_TimeIdleKeyboard%`n
    ; OutputDebug, %A_TimeIdlePhysical%`n
    ; OutputDebug, %A_TimeSincePriorHotkey%`n
    ; OutputDebug, %A_TimeSinceThisHotkey%`n
    LAltPressedTime := LAltKeyPressedUpTime-LAltKeyPressedStartTime
    ; ToolTip, 
    ;     (
    ;         %KeyPressedUpTime%
    ;         %PressedTime%
    ;     )
    If (LAltPressedTime  < 200 and A_PriorKey = "F14")
    { 
        IME_SET(1)
        ; Send {Alt Down}{Tab}{Alt Up}
        ; ; ToolTip, %A_TimeSincePriorHotkey% 
        ; Sleep, 50
        ; FlashWindow()
        ; Sleep, 200
        ; move_corsor_to_active_centor()
    }
    ; if (A_TimeSincePriorHotkey < 300 and A_PriorKey = "RAlt"){
        LAltKeyPressedStartTime = 0
Return
