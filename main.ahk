﻿;#SingleInstance, Force
;#Include, %A_ScriptDir%\henkan_ctrl_main.ahk
#InstallKeybdHook
#UseHook
coordmode, mouse, screen
;SendMode Input
SetWorkingDir, %A_ScriptDir%
; SetMouseDelay, 1
; #HotkeyModifierTimeout 100

; -----------------------------------------
; 汎用コマンドのスクリプト
; -----------------------------------------

#Include, %A_ScriptDir%\Command.ahk

; -----------------------------------------
; ウィンドウ，カーソル移動のバインディング
; -----------------------------------------

; ■ カーソルの位置移動をする
#Include, %A_ScriptDir%\src\AltBinds.ahk
#Include, %A_ScriptDir%\src\BSBinds.ahk
#Include, %A_ScriptDir%\src\WindowBinds.ahk
; #Include, %A_ScriptDir%\src\RShiftBindings.ahk

; -----------------------------------------
; キーの単純な置き換え
; -----------------------------------------

; ■ かなローマ字，capslockの置き換え
; *vkF2:: Send, {Enter}
; *vkF0:: Send, {BackSpace}

; -----------------------------------------
; One Shot Modifierの実装
; -----------------------------------------

; ■ SpaceのOne Shot Modifier実装 (Shift and Space)
#Include, %A_ScriptDir%\src\SpaceOneshot.ahk

; ■ CtrlのOne Shot Modifier実装 (Ctrl and Muhenkan)
#Include, %A_ScriptDir%\src\CtrlOneshot.ahk
; #Include, %A_ScriptDir%\henkan_ctrl_main_v2.ahk
#Include, %A_ScriptDir%\src\ColonOneshot.ahk

; ■ セミコロンのOne Shot Modifier実装 (ModForSymbol and Semicolon)
#Include, %A_ScriptDir%\src\SemiColonOneshot.ahk

; ■ AltのOne Shot Modifier実装(Alt and Esc)
#Include, %A_ScriptDir%\src\LAltOneshot.ahk
#Include, %A_ScriptDir%\src\AltOneshot.ahk

#Include, %A_ScriptDir%\src\BSOneshot.ahk

#Include, %A_ScriptDir%\src\TabOneshot.ahk
#Include, %A_ScriptDir%\src\TabBinds.ahk

; ■ @のOne Shot Modifier実装 (ModForNumber and @)
; #Include, %A_ScriptDir%\at_main.ahk
#IfWinNotActive ahk_class UnityWndClass

    ; ■ 変換 + キー -> テキスト操作のバインド
    #Include, %A_ScriptDir%\src\HenkanBinds.ahk

    #Include, %A_ScriptDir%\src\ColonBinds.ahk

    ; ■ セミコロン + キー -> 記号キーを入力
    ; #If IME_GetConverting()!=2
    #Include, %A_ScriptDir%\src\MainBinds.ahk

    ; ■ 変換キーのOne Shot Modifier実装 (ModForText and Henkan)
    #Include, %A_ScriptDir%\src\HenkanOneshot.ahk

    ; -----------------------------------------
    ; 全角文字の自動半角化スクリプト
    ; ----------------------------------------

    #Include, %A_ScriptDir%\src\SymbolBinds.ahk

    ; -----------------------------------------
    ; ソースコードのリロード
    ; -----------------------------------------

    vk1C & p:: Reload
    return

    ; -----------------------------------------
    ; 押しっぱなしへの対策スクリプト
    ; -----------------------------------------

    ^+-:: Send, ^;
    *F12::
        ReleaseModifiers()
        Send, F12
    return

    ; -----------------------------------------
    ; 特定アプリケーションでのみ実行するスクリプト
    ; -----------------------------------------

    ; ■ タスクビューでのhjklキーバインド 
    #IfWinActive ahk_class MultitaskingViewFrame
        #Include, %A_ScriptDir%\src\AltTabMover.ahk

        ; ■ VRChat上で一部キー入力を無効にする
        #IfWinActive ahk_class UnityWndClass 
            #Include, %A_ScriptDir%\src\WASDForVRC.ahk

