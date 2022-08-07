; 【概要】
; 
; 【One Shot】 
; IME OFF
; 【Combination】
; Ctrl + キー
; 【Memo】
; ① Ctrlキーとのバインディングを作成しなければ独立しているコード
; Ctrl が何も押されず離されたらIMEをONにする
; 【Future】
; 全てのキー(Ctrl & aなど含む)が網羅的に定義されている場合，Ctrl Up内でprioritykeyが拾える
;->コードのCtrl j用の部分が消せるようになるため，他コードへの依存が減る

#Include, %A_ScriptDir%\Command.ahk
#InstallKeybdHook
#UseHook
KeyPressedStartTime = 0

; $にするとSandSとの順序問題がでてくる
~Ctrl::
  if ( KeyPressedStartTime = 0 ){
    KeyPressedStartTime := A_TickCount
    ; 不具合ある場合はDownTempも検討する
  }
Return

~Ctrl Up:: 
  ; Ctrl J->キー用の変数，Commandの方で使用しない場合，~Ctrl Upになる。
  global CtrlPriorHotkey := A_PriorHotkey
  global CtrlPriorkey := A_Priorkey

  KeyPressedUpTime := A_TickCount
  PressedTime := KeyPressedUpTime-KeyPressedStartTime
  If (KeyPressedUpTime- KeyPressedStartTime < 300 and A_PriorKey = "LControl")
  { 
    IME_SET(0) 
    ;  Send, {Enter}
    ; おしっぱなし対策のためのおまじない
    ReleaseModifiers()
    Send, {Ctrl Up}
  }
  KeyPressedStartTime := 0
Return 
