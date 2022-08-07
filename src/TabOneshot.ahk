#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

KeyPressedStartTime := 0
$Tab::
  if ( KeyPressedStartTime = 0 ){
    KeyPressedStartTime := A_TickCount
  }
Return

Tab up:: 
  ; Send, % (A_TimeSincePriorHotkey < 1000 ? "{vk1C}":"")
  KeyPresseUpTime := A_TickCount
  PressedTime := KeyPressedUpTime-KeyPressedStartTime
  If (KeyPresseUpTime- KeyPressedStartTime < 200 and A_PriorHotkey="$Tab"and A_PriorKey== "Tab")
  { 
    Send, {Blind}{Tab}
  }
  KeyPressedStartTime := 0
return
