; 【概要】
; BackSpaceの入力をSandS風に扱うためのスクリプト
; 【One Shot】 
; -> BackSpace
; 【Combination】 
; -> 自作モディファイア

KeyPressedStartTime := 0
~Backspace::
  if ( KeyPressedStartTime = 0 ){
    KeyPressedStartTime := A_TickCount
  }
Return

Backspace up:: 
  ; Send, % (A_TimeSincePriorHotkey < 1000 ? "{vk1C}":"")
  KeyPresseUpTime := A_TickCount
  PressedTime := KeyPressedUpTime-KeyPressedStartTime
  If (KeyPresseUpTime- KeyPressedStartTime < 200 and A_PriorHotkey="$BackSpace"and A_PriorKey== "Backspace")
  { 
    Send, {Blind}{BackSpace}
  }
  KeyPressedStartTime := 0
return

