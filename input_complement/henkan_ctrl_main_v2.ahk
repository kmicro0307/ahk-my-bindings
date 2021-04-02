
; Ctrl が何も押されず離されたらIMEをONにする
; future: 全てのキーが網羅的に定義されている場合，Ctrl up内でprioritykeyが拾える
;->コードのCtrl j用の部分が消せるため，結合度が下がる

; a prior キーだと 修飾キーが取れない->priorを受け取った時点で文字列を作成すれば良い?
; ->それだと結局結合度一緒か
;->これは関係ないか
;->Ctrl Upが定義されている時点で結合はどうしようもないか

#Include, %A_ScriptDir%\Command.ahk
#InstallKeybdHook
#UseHook 
KeyPressedStartTime = 0
; $にするとsandsとの順序問題がでてくる
; *付けておくとctrl  space keyによるショートカットが動く

; この実装の場合，vk1Dと他のキーを併用することはできない
; 記述した場合，*vk1Dの動作はUpの後に行われる?

*vk1D::
  ;  ToolTip, c1
  Send {RCtrl Down}
  if ( KeyPressedStartTime = 0 ){
  KeyPressedStartTime := A_TickCount

  ; 不具合あったらDownTempも検討する
  ;~で定義されているため，sendは要らない
  ;Send {Blind}{Ctrl Down}
  }
  Return
; ~でCtrlは押していれば送られる.キーバインドによって上書きされない

vk1D Up:: 
    Send, {RCtrl Up}
    ; ToolTip, c2
    ; Ctrl J->キー用の変数，commandの方で使用しないと~Ctrl Upになってしまう
   global CtrlPriorHotkey := A_PriorHotkey
  ;  tooltip, CtrlPriorHotkey
   global CtrlPriorkey := A_Priorkey
  ; ToolTip, %CtrlPriorHotkey% 
  ;  ToolTip, %CtrlPriorkey% 
   KeyPressedUpTime := A_TickCount
   PressedTime := KeyPressedUpTime-KeyPressedStartTime
  ;  tooltip, =%PressedTime%
  ;  ToolTip, %A_PriorKey% 
    ;  Send, {vkF3}
    ; Send, {RCtrl Up}
    ; vk1dがpriorkeyとれない?っぽいので甘い実装都合
    If (KeyPressedUpTime- KeyPressedStartTime  < 200 )
    { 
      ;IME_SETだとプロパティが設定できないためバグがでる or カスタマイズ性が低い
     IME_SET(0) 
    ;  Send, {vkF3}
     ; 以下意味有るか不明 おまじない
      ReleaseModifiers()
    ; Send, {Ctrl Up}
    }
    KeyPressedStartTime := 0
    Return  

;以下のように記述すると，追加で書ける
; ~vk1D & d::
;   tooltip, test

; vk1D & d::
;   tooltip, test