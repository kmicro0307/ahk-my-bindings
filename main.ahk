;#SingleInstance, Force
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
#Include, %A_ScriptDir%\src\AltCursorPosManager.ahk
#Include, %A_ScriptDir%\src\AltBindings.ahk
#include, %A_ScriptDir%\src\AltMoveActiveWindow.ahk 
#Include, %A_ScriptDir%\src\BSBindings.ahk
; #Include, %A_ScriptDir%\src\RShiftBindings.ahk

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
#Include, %A_ScriptDir%\src\SpaceOneshot.ahk
; ■ CtrlのOne Shot Modifier実装 (Ctrl and Muhenkan)
#Include, %A_ScriptDir%\src\CtrlOneshot.ahk
; #Include, %A_ScriptDir%\henkan_ctrl_main_v2.ahk

; ■ セミコロンのOne Shot Modifier実装 (ModForSymbol and Semicolon)
#Include, %A_ScriptDir%\src\SemiColonOneshot.ahk

; ■ AltのOne Shot Modifier実装(Alt and Esc)
#Include, %A_ScriptDir%\src\LAltOneshot.ahk
#Include, %A_ScriptDir%\src\AltOneshot.ahk
#Include, %A_ScriptDir%\src\BSOneshot.ahk

#Include, %A_ScriptDir%\src\TabOneshot.ahk
#Include, %A_ScriptDir%\src\TabBindings.ahk

; ■ @のOne Shot Modifier実装 (ModForNumber and @)
; #Include, %A_ScriptDir%\at_main.ahk
#IfWinNotActive ahk_class UnityWndClass

; ■ 変換 + キー -> テキスト操作のホットキー
#Include, %A_ScriptDir%\src\Henkan.ahk

; ■ セミコロン + キー -> 記号キーを入力
; #If IME_GetConverting()!=2
#Include, %A_ScriptDir%\src\Alphabets.ahk

; ■ 変換キーのOne Shot Modifier実装 (ModForText and Henkan)
#Include, %A_ScriptDir%\src\HenkanOneshot.ahk

; -----------------------------------------
; 大文字記号文字の自動半角化コード
; ----------------------------------------

#Include, %A_ScriptDir%\src\Symbols.ahk

; -----------------------------------------
; ソースコードのリロード
; -----------------------------------------

vk1C & p:: Reload
return

; -----------------------------------------
; 押しっぱなしへの対策コード
; -----------------------------------------

^+-:: Send, ^;
*F12::
    ReleaseModifiers()
    Send, F12
return


; -----------------------------------------
; 特定アプリケーションでのみ実行するコード
; -----------------------------------------

; ■ VRChat上で一部キー入力を無効にする
#IfWinActive ahk_class UnityWndClass 
#Include, %A_ScriptDir%\src\WASDForVRC.ahk

; ■ タスクビューでのhjklキーバインド 
#IfWinActive ahk_class MultitaskingViewFrame
#Include,  %A_ScriptDir%\src\AltTabMover.ahk



 