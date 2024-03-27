#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%


global colonPressedStartTime = 0

^SC028:: Return

+SC028:: 
  Send, {Blind}{SC028} 
  Return

SC028::
  if GetKeyState("Shift"){
    Send, {Blind}{SC028}
  }
  if ( colonPressedStartTime = 0 ){
      colonPressedStartTime := A_TickCount
  }
Return

SC028 Up:: 
  if (A_PriorHotkey = "SC028"){
    If ((A_TickCount - colonPressedStartTime) < 100)
    {
      Send, {Blind}{SC028}
      colonPressedStartTime := 0
      return
    }
    colonPressedStartTime := 0
    return 
  } else{
    colonPressedStartTime := 0
  }
Return
