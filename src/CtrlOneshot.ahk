; 【概要】
; 
; 【One Shot】 
; IME OFF
; 【Combination】
; Ctrl + キー
; 【memo】
; ① Ctrlキーとのバインディングを作成しなければ独立しているコード
; Ctrl が何も押されず離されたらIMEをONにする
; ② a prior キーだと 修飾キーが取れない->priorを受け取った時点で文字列を作成すれば良い?
; ->それだと結局結合度一緒か
;->これは関係ないか
;->Ctrl Upが定義されている時点で結合はどうしようもないか
; 【future】
; 全てのキー(Ctrl & aなど含む)が網羅的に定義されている場合，Ctrl Up内でprioritykeyが拾える
;->コードのCtrl j用の部分が消せるようになるため，結合度が下がる

#Include, %A_ScriptDir%\Command.ahk
#InstallKeybdHook
#UseHook
KeyPressedStartTime = 0

; $にするとsandsとの順序問題がでてくる
~Ctrl::
  if ( KeyPressedStartTime = 0 ){
  KeyPressedStartTime := A_TickCount
  ; 不具合あったらDownTempも検討する
  ;~で定義されているため，sendは要らない
  ;Send {Blind}{Ctrl Down}
    ; ToolTip, c1
  }
  Return
; ~でCtrlは押していれば送られる.キーバインドによって上書きされない

~Ctrl Up:: 
    ; Ctrl J->キー用の変数，commandの方で使用しないと~Ctrl Upになってしまう
   global CtrlPriorHotkey := A_PriorHotkey
   global CtrlPriorkey := A_Priorkey
  ; ToolTip, %CtrlPriorHotkey% 
   KeyPressedUpTime := A_TickCount
   PressedTime := KeyPressedUpTime-KeyPressedStartTime
    If (KeyPressedUpTime- KeyPressedStartTime  < 300 and A_PriorKey = "LControl")
    { 
      ;ctrlだとプロパティが設定できないためバグがでる or カスタマイズ性が低いため，IME_SETは使わない
     IME_SET(0) 
    ;  Send, {Enter}
     ; 以下意味有るか不明 おまじない
    ReleaseModifiers()
    Send, {Ctrl Up}
    }
    KeyPressedStartTime := 0
    Return  

; #InputLevel, 0
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

; - KeyPressedStartTimeをこのような形で管理しないとリセットされる
; 	- Ctrlは押している時随時じっこうされるため

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