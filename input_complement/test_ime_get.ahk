#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%
F1::
    ; test := IME_GET()
    test := IME_GetConvMode()
    ; test := IME_GetConverting()
    tooltip, %test%
    return
    ; if (IME_GET() = 1){
    ;     ; カタカナモードにする
    ; }
; =======================================
; IME.ahkの動作検証
; [alt-ime-ahk/IME.ahk at master · karakaram/alt-ime-ahk](https://github.com/karakaram/alt-ime-ahk/blob/master/IME.ahk)
; IME_GetConvModeなどの動作を調べる
; 
; 
; 結果
;   あ -> 9
;   _ｱ  -> 19
; 直感と一致する結果
; ! google日本語入力は入力モードを取れないっぽい

; 検証 
;   環境:   
;     Google日本語入力
;     ひらがな
; 動作:   
;   IME_SetConvMode(27) (全カタカナ)
; 取得: 
;     test := IME_GetConvMode()
;     tooltip, %test% 
; 結果
;     Get  -> 27
;     入力モード -> ひらがな
;     Getの結果から，値は変更されているが，実際の入力モードは変わらなかった 
;     対して，同様の設定をMS-IMEで行った場合はちゃんとカタカナになった
;     google日本語入力だと結果が反映されない?

F2::
    test := IME_GetConvMode()
    tooltip, %test% 
    IME_SetConvMode(25)
