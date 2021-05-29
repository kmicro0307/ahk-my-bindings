;--------------------------------------------------------
; 【概要】 
; セミコロンを修飾キーとして扱う
; 【One Shot】 
; -> セミコロン
; 【Combination】 
; -> 記号キー入力
;----------------------------------
#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

; セミコロンをSndS風に実装し，記号キーを入力するためのスクリプト

; セミコロンが押されている時は何も入力されない
; セミコロンが押されてから，何も押されずに離さた場合はセミコロンを入力
; セミコロン入力時にキーが入力された場合，対応する記号キーを入力

; TODO: 簡単な実装とテスト
;e   簡単にセミコロンの実装を作る
; 物理的なキー入力を取得できれば，upだけの実装で良い気がする

; $q::{}
; a := GetKeyState(
 ; ToolTip,  %a%

global SemicolonPressedStartTime = 0
*;::
    if GetKeyState("Ctrl", "P"){
      Send, {Blind}{SC027}
    }
    if GetKeyState("Shift"){
               Send, {Blind}{SC027}
    }
    if ( SemicolonPressedStartTime = 0 ){
      SemicolonPressedStartTime := A_TickCount
    }
    global SemicolonPriorHotkey := "*;"
Return 

*; Up:: 
  ; ToolTip, %A_PriorKey% 
  ; ToolTip, %A_PriorHotKey% 
  ; if (A_PriorHotkey = "*;"){
  ;   return
  ; }
  ; if isSecondColon(){
  ;   return
  
  global SemicolonPriorHotkey := "*; Up"
  ; global SemicolonPriorkey := A_Priorkey
  ; If ((A_TickCount - SemicolonPressedStartTime) < 2000 and A_PriorHotKey = "*; Up")
  ; {
  ;   ; SpacePressedStartTime = 0
  ;   SendInput {Blind}{SC028}{Space}
  ;   return
  ; }
Return
