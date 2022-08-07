; 【概要】
;   変換キー+他キーのバインディング
;   スクリプトのリロード
; 【One Shot】 
; -> IME ON
; 【Combination】 
; -> 自作モディファイア
; 【Memo】
;   変換のホットキー，shiftと一緒に動作してほしいキーとそうでないキーが有る
;   してほしくない場合は内部で明示的にUpにする

#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%
#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.
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

Vk1CKeyPressedStartTime := 0

*vk1C::
  ; Send, {F21}
  conv_mode := IME_GetConverting()
  if (conv_mode == 2){
    Send, {Enter}
    global enterSended := True
    return
  }
  ; tooltip, %Vk1CKeyPressedStartTime%
  if ( Vk1CKeyPressedStartTime = 0 ){
    Vk1CKeyPressedStartTime := A_TickCount
  }
Return

vk1C up:: 
  ; Send, % (A_TimeSincePriorHotkey < 1000 ? "{vk1C}":"")
  Vk1CKeyPresseUpTime := A_TickCount
  PressedTime := KeyPressedUpTime-Vk1CKeyPressedStartTime
  ; 直前のキーが変換であるかを判定する
  ; 前回のキーが変換だった場合，PriorKeyは""になる
  ; tooltip, %A_PriorHotkey%/n%A_PriorKey%
  ; OutputDebug, PriorHotkey %A_PriorHotkey%`n
  ; OutputDebug, Prior %A_Priorkey%`n
  ; OutputDebug, Start %Vk1CKeyPressedStartTime%`n
  ; OutputDebug, Uptime %KeyPressedUpTime%`n
  If (Vk1CKeyPresseUpTime- Vk1CKeyPressedStartTime < 200 and A_PriorHotkey="*Space Up"and A_PriorKey== "")
  { 
    ; Send, {vk1C}
    ; Send, {Blind}{vkF3}
    Send, {Blind}{Enter}
  }
  If (Vk1CKeyPresseUpTime- Vk1CKeyPressedStartTime < 200 and A_PriorHotkey="~Ctrl"and A_PriorKey== "")
  { 
    Send, {Blind}{Enter}
  }
  If (Vk1CKeyPresseUpTime- Vk1CKeyPressedStartTime < 200 and A_PriorHotkey="~Ctrl Up"and A_PriorKey== "")
  { 
    ; OutputDebug, fire
    ; sleep, 10
    Send, {Ctrl Down}{Enter}{CtrlUp}
  }
  If (Vk1CKeyPresseUpTime- Vk1CKeyPressedStartTime < 200 and A_PriorHotkey="*vk1C"and A_PriorKey== "" and not enterSended)
  { 
    ; Send, {vk1C}
    ; Send, {Blind}{vkF3}
    Send, {Blind}{Enter}
  }
  ; OutputDebug, %enterSended%`n

  ; Send,{vk1C}                
  Vk1CKeyPressedStartTime := 0
  global enterSended = False
return
