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
  ; 直前のキーが変換であるかを判定する
  ; 前回のキーが変換だった場合，PriorKeyは""になる
  ; tooltip, %A_PriorHotkey%/n%A_PriorKey%
  If (KeyPresseUpTime- KeyPressedStartTime  < 200 and A_PriorHotkey="*Space Up"and A_PriorKey== "")
  {  
    ; Send, {vk1C}
    ; Send, {Blind}{vkF3}
    Send, {Blind}{Enter}
  }
  If (KeyPresseUpTime- KeyPressedStartTime  < 200 and A_PriorHotkey="*vk1C"and A_PriorKey== "")
  {  
    ; Send, {vk1C}
    ; Send, {Blind}{vkF3}
    Send, {Blind}{Enter}
  }
  ; Send,{vk1C}                
  KeyPressedStartTime := 0
  return