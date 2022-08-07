; 【概要】 
; セミコロンを修飾キーとして扱う
; 【One Shot】 
; -> セミコロン
; 【Combination】 
; -> 記号キー入力
; 【Memo】 
; セミコロンをSandS風に実装し，記号キーを入力するためのスクリプト
; セミコロンが押されている時は何も入力されない
; セミコロンが押されてから，何も押されずに離された場合はセミコロンを入力
; セミコロン入力時にキーが入力された場合，対応する記号キーのためのフラグを発火

#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

; $q::{}
; a := GetKeyState(
; ToolTip,  %a%

global SemicolonPressedStartTime = 0

; ^が無限に押されてしまうので，別のキーで代替
^SC027:: Return

; +が無限に押されてしまうので，別のキーで代替
+SC027:: Return

SC027::
  ; if GetKeyState("Ctrl", "P"){
  ;   Send, {Blind}{SC027}
  ; }
  ; if GetKeyState("Shift"){
  ;   Send, {Blind}{SC027}
  ; }
  if ( SemicolonPressedStartTime = 0 or SemicolonPriorHotkey = "*; Up"){
      SemicolonPressedStartTime := A_TickCount
  }
  global SemicolonPriorHotkey := "*;"
Return

SC027 Up:: 
  ; ToolTip, %A_PriorHotKey% 
  ; if (A_PriorHotkey = "^;"){
  ;   Send, {Blind}{SC027}
  ;   return
  ; }
  ; if (A_PriorHotkey = "+;"){
  ;   Send, {Blind}{SC027}
  ;   return
  if (A_PriorHotkey = "SC027"){
    global SemicolonPriorHotkey := "*; Up"
    return 
  } else{
    global SemicolonPriorHotkey := ""
    SemicolonPressedStartTime := 0
  }
  ; global SemicolonPriorkey := A_Priorkey
  ; If ((A_TickCount - SemicolonPressedStartTime) < 2000 and A_PriorHotKey = "*; Up")
  ; {
  ;   ; SpacePressedStartTime = 0
  ;   SendInput {Blind}{SC028}{Space}
  ;   return
  ; }
  ; SemicolonPressedStartTime = 0
Return
