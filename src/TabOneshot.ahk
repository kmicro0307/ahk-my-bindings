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
  ; 直前のキーが変換であるかを判定する
  ; 前回のキーが変換だった場合，PriorKeyは""になる
  ; tooltip, %A_PriorHotkey%/n%A_PriorKey%
  If (KeyPresseUpTime- KeyPressedStartTime  < 200 and A_PriorHotkey="$Tab"and A_PriorKey== "Tab")
  {  
    Send, {Blind}{Tab}
  }
  KeyPressedStartTime := 0
  return
