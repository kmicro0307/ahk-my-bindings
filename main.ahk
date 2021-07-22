﻿;#SingleInstance, Force
; memo
; upのあとに他のキーバインドが書いてあると動作が意図したとおりにならない
; コード修正してとりあえず一つのコードで動くようになった
;#Include, %A_ScriptDir%\henkan_ctrl_main.ahk
#InstallKeybdHook
#UseHook
coordmode, mouse, screen
;SendMode Input
SetWorkingDir, %A_ScriptDir%
; SetMouseDelay, 1
; #HotkeyModifierTimeout 100

; -----------------------------------------
; 汎用コード
; -----------------------------------------

#Include, %A_ScriptDir%\Command.ahk

; -----------------------------------------
; ウィンドウ，カーソル移動のバインディング
; -----------------------------------------

; ■ カーソルの位置移動をする
#Include, %A_ScriptDir%\CursorPosManager.ahk

; ■ ウィンドウの位置移動をする
#include, %A_ScriptDir%\MoveActiveWindow.ahk 

; -----------------------------------------
; キーの単純な置き換え
; -----------------------------------------

; ■ かなローマ字，capslockの置き換え(現状使う予定はない)
; *vkF2:: Send, {Enter}
; *vkF0:: Send, {BackSpace}

; -----------------------------------------
; One Shot Modifierの実装
; -----------------------------------------

; ■ SpaceのOne Shot Modifier実装 (Shift and Space)
; #Include, %A_ScriptDir%\sands_keymap.ahk
#Include, %A_ScriptDir%\ShiftSpaceOneshot.ahk

; ■ CtrlのOne Shot Modifier実装 (Ctrl and Muhenkan)
#Include, %A_ScriptDir%\CtrlImeOneshot.ahk
; #Include, %A_ScriptDir%\henkan_ctrl_main_v2.ahk
; TODO セミコロンと変換はOSMと実装のタイプが実際には異なるので区分を明確に分ける

; ■ セミコロンのOne Shot Modifier実装 (ModForSymbol and Semicolon)
#Include, %A_ScriptDir%\SemiColonMain.ahk

; ■ @のOne Shot Modifier実装 (ModForNumber and @)
; #Include, %A_ScriptDir%\at_main.ahk
#IfWinNotActive ahk_class UnityWndClass

; ■ セミコロン + キー -> 記号キーを入力
#Include, %A_ScriptDir%\Alphabets.ahk

; ■ 変換キーのOne Shot Modifier実装 (ModForText and Henkan)
#Include, %A_ScriptDir%\HenkanEnterOneshot.ahk

; -----------------------------------------
; 大文字記号文字の自動半角化コード
; -----------------------------------------

#Include, %A_ScriptDir%\Symbols.ahk

; -----------------------------------------
; ソースコードのリロード
; -----------------------------------------

vk1C & p:: Reload
return

; -----------------------------------------
; 押しっぱなしへの対策コード
; -----------------------------------------

*F12::
    ReleaseModifiers()
    Send, F12
return

; -----------------------------------------
; 特定アプリケーションでのみ実行するコード
; -----------------------------------------

; ■ VRChat上で一部キー入力を無効にする
#IfWinActive ahk_class UnityWndClass 
#Include, %A_ScriptDir%\wasd_for_vrc.ahk

; ■ タスクビューでのhjklキーバインド 
#IfWinActive ahk_class MultitaskingViewFrame
#Include,  %A_ScriptDir%\key_binding_alttab.ahk
