;#SingleInstance, Force

; memo
; -> upのあとに他のキーバインドが書いてあると動作が意図したとおりにならない
; ->コード修正してとりあえず一つのコードで動くようになった
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
; カーソルの位置移動をする
#Include, %A_ScriptDir%\cursor_pos_manager.ahk
; ウィンドウの位置移動をする
#include, %A_ScriptDir%\move_active_window.ahk 

; -----------------------------------------
; キーの単純な置き換え
; -----------------------------------------
; かなローマ字，capslockの置き換え(現状使う予定はない)
; *vkF2:: Send, {Enter}
; *vkF0:: Send, {BackSpace}
; -----------------------------------------
; One Shot Modifierの実装
; -----------------------------------------
; SpaceのOne Shot Modifier実装 (Shift and Space)
; #Include, %A_ScriptDir%\sands_keymap.ahk
#Include, %A_ScriptDir%\sands_main_refine.ahk

; CtrlのOne Shot Modifier実装 (Ctrl and Muhenkan)
#Include, %A_ScriptDir%\ctrlup_ime.ahk
; #Include, %A_ScriptDir%\henkan_ctrl_main_v2.ahk
; TODO セミコロンと変換はOSMと実装のタイプが実際には異なるので区分を明確に分ける
; セミコロンのOne Shot Modifier実装 (ModForSymbol and Semicolon)
#Include, %A_ScriptDir%\semicolon_main.ahk
#Include, %A_ScriptDir%\at_main.ahk
;vk1C & p:: Reload

#IfWinNotActive ahk_class UnityWndClass
; セミコロン + キー -> 記号キーを入力
#Include, %A_ScriptDir%\key_combinetion.ahk

; 変換キーのOne Shot Modifier実装 (ModForText and Henkan)
#Include, %A_ScriptDir%\keymap_auto_eisuu.ahk
; -----------------------------------------
; 大文字記号文字の自動半角化コード
; -----------------------------------------
#Include, %A_ScriptDir%\auto_confirm.ahk

; -----------------------------------------
; 特定アプリケーションでのみ実行するコード
; -----------------------------------------
;VRChat上でキーを無効にする
#IfWinActive ahk_class UnityWndClass 
#Include, %A_ScriptDir%\wasd_for_vrc.ahk

; タスクビューでのhjklキーバインド 
#IfWinActive ahk_class MultitaskingViewFrame
#Include,  %A_ScriptDir%\key_binding_alttab.ahk

; -----------------------------------------
; 押しっぱなしへの対策コード
; -----------------------------------------
*F12::
    ReleaseModifiers()
    Send, F12
return
