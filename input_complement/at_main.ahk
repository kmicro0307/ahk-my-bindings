#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

@ Up:: 
  If (A_PriorKey = "@")
  {
    KeyPressedUpTime := A_TickCount
    PressedTime := KeyPressedUpTime-KeyPressedStartTim
    SendInput {Blind}@
  }
Return
