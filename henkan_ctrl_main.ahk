

#Include, %A_ScriptDir%\Command.ahk
#InstallKeybdHook
#UseHook
$vk1D::
  SendInput {RCtrl Down}
  If SandS_SpaceDown = 1
  {
    Return
  }
  SandS_SpaceDown := 1
  SandS_SpaceDownTime := A_TickCount ; milliseconds after computer is booted http://www.autohotkey.com/docs/Variables.htm
  SandS_AnyKeyPressed := 0
  ; watch for the next single key, http://www.autohotkey.com/docs/commands/Input.htm
  Input, SandS_AnyKey, L1 V M,{RCtrl}{LCtrl}{LAlt}{RAlt}{LShift}{RShift}{LWin}{RWin}{AppsKey}{F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Left}{Right}{Up}{Down}{Home}{End}{PgUp}{PgDn}{Del}{Ins}{BS}{Capslock}{Numlock}{PrintScreen}{Pause}   SandS_AnyKeyPressed := 1
  ;この方式はInput自体は入力待ちをしているだけ
  ;待っている間にキーを押すことで、同時押しを可能にしている
  ;そのため、変換とスペースの同時押しは条件分岐等が必要か
;   ToolTip Clipboard change to: %SandS_AnyKey%
;   Sleep 5000
;   ToolTip  ;Turn off the tip.
  ;Input, SandS_AnyKey, L1 V M,{RWin}{AppsKey}{F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Left}{Right}{Up}{Down}{Home}{End}{PgUp}{PgDn}{Del}{Ins}{BS}{Capslock}{Numlock}{PrintScreen}{Pause}   SandS_AnyKeyPressed := 1
  ; ctrlは画面出力を行なわない
  ; そのためShiftとは動作が異なる
  SandS_AnyKeyPressed := 1
  Return

$vk1D Up:: 
  SendInput {RCtrl Up}
  SandS_SpaceDown := 0
  If SandS_AnyKeyPressed = 0
  {
    If A_TickCount - SandS_SpaceDownTime < 200
    {
      SendInput {vkF3}
    }
    ; Send EndKey of the "Input" command above
    ; You must use Send here since SendInput is ignored by "Input
    ; 単体入力のときはInputを終わらせるためのコマンドを打つ必要がある
    ; vkF3はコマンドにならないため
    Send {RCtrl}
  }
  Return  

  


; Tips Ctrl j -> f とかやりたい場合， 以下のような記述を同じコード内で書くと意図した動作にならないので注意
; $f::
; a := isSecondKeyAfterCtrlJ()
; b := isActiveProcess("Obsidian") 
; if (isActiveProcess("Obsidian") && isSecondKeyAfterCtrlJ()){
;     Send, ^+e
;     Return
; }else {
; Send, f
; }
; Return

; *1::
;   SendInput {RCtrl Down}
;   If SandS_SpaceDown = 1
;   {
;     Return
;   }
;   SandS_SpaceDown := 1
;   SandS_SpaceDownTime := A_TickCount ; milliseconds after computer is booted http://www.autohotkey.com/docs/Variables.htm
;   SandS_AnyKeyPressed := 0
;   ; watch for the next single key, http://www.autohotkey.com/docs/commands/Input.htm
;   Input, SandS_AnyKey, L1 V,{LCtrl}{RCtrl}{Ctrl}{LAlt}{RAlt}{LShift}{RShift}{LWin}{RWin}{AppsKey}{F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Left}{Right}{Up}{Down}{Home}{End}{PgUp}{PgDn}{Del}{Ins}{BS}{Capslock}{Numlock}{PrintScreen}{Pause} 
;   SandS_AnyKeyPressed := 1  
;   Return

 
; *1 Up:: 
;   SendInput {RCtrl Up}
;   SandS_SpaceDown := 0
;   If SandS_AnyKeyPressed = 0
;   {
;     If A_TickCount - SandS_SpaceDownTime < 200
;     {
;       SendInput {vkF3}
;     }
;     ; Send EndKey of the "Input" command above
;     ; You must use Send here since SendInput is ignored by "Input"
;     ;なぜここでCtrlをおくっている?
;     ;
;     Send {RCtrl}
;   }
;   Return  