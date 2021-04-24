; 【概要】
;   変換キー+他キーのバインディング
;   スクリプトのリロード
; 【One Shot】 
; -> IME ON
; 【Combination】 
; -> 自作モディファイア
; 【memo】
;   変換のホットキー，shiftと一緒に動作してほしいキーとそうでないキーが有る
;   してほしくない場合は内部で明示的にUpにする

#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force
#InstallKeybdHook
#UseHook

; =========================
; 【概要】
;  変換 + キーで，テキスト操作用のキーバインドの実装 
; =========================

; -----------------------------------------
; 変換を修飾キーとして扱うための準備
; -----------------------------------------

KeyPressedStartTime := 0
*vk1C::
  ; tooltip, %KeyPressedStartTime%
  if ( KeyPressedStartTime = 0 ){
    KeyPressedStartTime := A_TickCount
  }
Return

vk1C up::                       
  ; Send, % (A_TimeSincePriorHotkey < 1000 ? "{vk1C}":"")
  KeyPresseUpTime := A_TickCount
  PressedTime := KeyPressedUpTime-KeyPressedStartTime
  If (KeyPresseUpTime- KeyPressedStartTime  < 300 and A_PriorHotkey="*vk1C" )
  { 
    Send, {vk1C}
  }
  ; Send,{vk1C}                
  KeyPressedStartTime := 0
  return

; -----------------------------------------
; vimライクキーバインドを実装する
; 主にテキスト操作に使用するキーバインドを設定する
; -----------------------------------------

; ■ hjklでvimバインドっぽく移動する
~vk1C & h::Send, {Blind}{Left}
~vk1C & j::Send, {Blind}{Down}
~vk1C & k::Send, {Blind}{Up}
~vk1C & l::Send, {Blind}{Right}

; ■ vimバインドっぽくスクロールする
~vk1C & u::Send,{Blind}{NumpadPgUp}
;~vk1C & d::Send,{Blind}{NumpadpgDn}

; ■ vimバインドっぽく行頭，行末移動(ほぼ使用しないのでコメントアウト)
; ~vk1C & 0::Send,{Blind}{NumpadHome}
; ~vk1C & 4::Send,{Blind}{NumpadEnd}

; ■ vimバインド`o`っぽく次の行，前の行へ移動
~vk1C & o::
 If  GetKeyState("Shift") {
    ; Send, {RShift Up}{NumpadEnd}{Enter}{RShift Down}{NumpadHome}{Space}{BackSpace}{RShift Down}
      SendInput, {LShift Up}{RShift Up}{NumpadHome}{Enter}{Up}{Blind}
    ; SendInput, {RShift Up}{NumpadEnd}{Enter}{End}+{Home}{Space}{BackSpace}+{Home}{Space}{BackSpace}{RShift Down}
    Return
  }
  Send,{Blind}{NumpadEnd}{Enter}
  Return

; -----------------------------------------
; "無変換 + zxcv" -> "Ctrl + zxcv
;   Ctrl zxcvよりも押しやすいときがあるので
; -----------------------------------------

~vk1C & z::Send,{Blind}^z
~vk1C & x:: Send,{Blind}^x
~vk1C & c::
  If (IME_GET() == 1){
    ;  IME_SET(0)                     ; ATOKだとよくわからない動作をするので、動作を安定させるためにも、明示的にIME OFFのキーを送るようする
    Send, {vkF3}
  }
  Send,{Blind}^c
  Return
~vk1C & v::Send,{Blind}^v

; -----------------------------------------
; 行に関するキーバインド
;   行の選択，削除等のキーバインドを記述
; -----------------------------------------

~vk1C & d::Send,{Blind}{End}+{Home}{BS}
;~vk1C & d:: Send,{Blind}{BackSpace}
; ~vk1C & w::Send,{Blind}^+{NumpadLeft}{Delete}     ; "vk1C & w"-> emacsの"Ctrl w" は消える範囲が想像しづらいので没かなー
~vk1C & r::Send,{Blind}{End}+{Home}^c
~vk1C & e::Send,{Blind}{End}+{Home}^x
~vk1C & s::Send,{Blind}{home}+{End}
~vk1C & b::Send,{End}

; -----------------------------------------
; その他
; -----------------------------------------

; アンダーバー、ドット、ピリオド
~vk1C & n:: Send,{Blind}{_}
~vk1C & m:: Send,{Blind}{~}

; aとfを使用して行頭，行末移動する(使用頻度高い )
~vk1C & a::Send, {NumpadHome}
~vk1C & f::Send,{NumpadEnd}

; 無変換での実装
;vkf3 & h::send, {blind}{left}
;vkF3 & j::Send, {Blind}{Down}
;vkF3 & k::Send, {Blind}{Up}
;vkF3 & l::Send, {Blind}{Right}
;vkF3 & a::Send, !{Esc}
;vkF3 & s::Send, ^!{Esc}

;vkF3 & e::Send, {Enter}

;vkF3 & u::Send,{Blind}{NumpadPgUp}
;vkF3 & d::Send,{Blind}{NumpadpgDn}
;vkF3 & 0::Send,{Blind}{NumpadHome}
;vkF3 & 4::Send,{Blind}{NumpadEnd}

;~vkF3 & w::Send,{Blind}^{Right}
;~vkF3 & b::Send,{Blind}^{Left}


;無変換+スペース＝エンター
;vkF3 & Space::Send,{Blind}{Enter}
;
;コピー&ペースト
;vkF3 & c::Send,{Blind}^c
;vkF3 & v::Send,{Blind}^v

;文字削除
;vkF3 & x:: Send,{Blind}{BackSpace}











