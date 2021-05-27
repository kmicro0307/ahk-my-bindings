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

; $q::
; a := GetKeyState(";", "P")
 ; ToolTip,  %a%
; Return 

SemicoPressedStartTime = 0
*;::
    if ( KeyPressedStartTime = 0 ){
        SpacePressedStartTime := A_TickCount
    }
Return 

*; Up:: 
  ; ToolTip, %A_PriorKey% 
  ; ToolTip, %A_PriorHotKey% 
  SpacePressedStartTime = 0
  if (A_PriorHotkey = "*;"){
    return
  }
  if isSecondColon(){
    return
  }
  If ((A_TickCount - SandS_SpaceDownTime) < 200 and A_PriorKey = ";")
  {
    SendInput {Blind};
  }
Return
