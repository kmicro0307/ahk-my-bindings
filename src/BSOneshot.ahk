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


; =========================
; 【概要】
;  変換 + キーで，テキスト操作用のキーバインドの実装 
; =========================

; -----------------------------------------
; 変換を修飾キーとして扱うための準備
; -----------------------------------------

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
  ; 直前のキーが変換であるかを判定する
  ; 前回のキーが変換だった場合，PriorKeyは""になる
  ; tooltip, %A_PriorHotkey%/n%A_PriorKey%
  If (KeyPresseUpTime- KeyPressedStartTime  < 200 and A_PriorHotkey="$BackSpace"and A_PriorKey== "Backspace")
  {  
    Send, {Blind}{BackSpace}
  }
  KeyPressedStartTime := 0
  return

