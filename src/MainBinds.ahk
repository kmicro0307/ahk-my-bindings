﻿; アルファベット+数字キーの実装
#InstallKeybdHook

$a::
    if isSecondColon(){
        ActivateWindowByProcess("terminal") 
        move_corsor_to_active_centor()
        SemicolonPriorHotkey := "a"
        SemicolonPressedStartTime := 0
    } else if (isPressedKeyWithSemicolon()) {
        Send, =
    } else if (isPressedKeyWithAt()) {
        Send, 4
    } else {
        Send, {Blind}a
    }
Return 

$b::
    if (isPressedKeyWithSemicolon()) {
        Send, =
    } else if (isPressedKeyWithAt()) {
        Return 
    }
    else {
        Send, {Blind}b
    }
Return 

$c::
    ;if (isSecondKeyAfterAltJ()){
    if (isSecondColon()){
        ; ActivateWindowByProcess("chrome")
        ActivateWindowByProcess("vivaldi")
        move_corsor_to_active_centor()
        SemicolonPriorHotkey := "c"
        SemicolonPressedStartTime := 0
    } else if (isPressedKeyWithSemicolon()) {
        Send, [
    } else if (isPressedKeyWithAt()) {
        Send, 8
    } else {
        Send, {Blind}c
    }
Return 

$^c::
    if (isPressedKeyWithSemicolon()) {
        Send, ●
    } else {
        Send, {Blind}^c
    }
Return 

$+c::
    ;if (isSecondKeyAfterAltJ()){
    if (isSecondColon()){
        ; ActivateWindowByProcess("chrome")
        ActivateWindowByProcess("chrome")
        move_corsor_to_active_centor()
        SemicolonPriorHotkey := "+c"
        SemicolonPressedStartTime := 0
    }else if (isPressedKeyWithSemicolon()) {
        Send, =
    } else {
        Send, {Blind}c
    }
Return 

$*d::
    if (isPressedKeyWithSemicolon()) {
        Send, +[
    } else if (isPressedKeyWithAt()) {
        Send, 5
    } else {
        Send, {Blind}d
    }
Return 

; tablacus explorer →  履歴を表示する
$e::
    if (isActiveProcess("tablacus") && isSecondKeyAfterCtrlJ() && CtrlPriorHotkey = "$^j"){
        ; ToolTip, %CtrlPriorHotkey%
        ; ToolTip, %A_PriorKey%
        ; 以下書かないとctrl j が CtrlPriorHotkeyのままになってキー入力がされない
        Send, ^r
        CtrlPriorHotkey := "^r"
        Return
        ;} else if (isSecondKeyAfterAltJ()){
    } else if (isSecondColon()){
        ActivateWindowByProcess("obsidian") 
        move_corsor_to_active_centor()
        SemicolonPriorHotkey := "e"
        SemicolonPressedStartTime := 0
        Return
    }
    if (isActiveProcess("Obsidian") && isSecondKeyAfterCtrlJ() && CtrlPriorHotkey= "$^j"){
        Send, !^+e 
        Send, !^+e
        CtrlPriorHotkey := "!^+e"
    } else if (isPressedKeyWithSemicolon()) {
        Send, " 
    } else if (isPressedKeyWithAt()) {
        Send, 2
    } else {
        Send, {Blind}e
    }
Return 

$^e::
    if (isPressedKeyWithSemicolon()) {
        SendSnippet("{""}{""}{Left}")
    } else {
        Send, {Blind}^e
    }
Return 
; tablacus explorer → 検索
#MaxHotkeysPerInterval 200
$f::
    ; Tooltip, %CtrlPriorHotkey%
    if (isActiveProcess("tablacus") && isSecondKeyAfterCtrlJ() && CtrlPriorHotkey = "$^j"){
        ; ToolTip, %CtrlPriorHotkey%
        ; ToolTip, %A_PriorKey%
        ; 以下書かないとctrl j が CtrlPriorHotkeyのままになってキー入力がされない
        Send, !^+f
        CtrlPriorHotkey := "^+f"
        Return
    }

    ;if (isSecondKeyAfterAltJ()){
    ; tooltip,%A_PriorHotkey%
    if (isSecondColon()){
        ; ActivateWindowByProcess("chrome")
        ActivateWindowByProcess("firefox")
        move_corsor_to_active_centor()
        SemicolonPriorHotkey := "f"
        SemicolonPressedStartTime := 0
    } else if (isActiveProcess("Obsidian") && isSecondKeyAfterCtrlJ() && CtrlPriorHotkey = "$^j"){
        ; ToolTip, %CtrlPriorHotkey%
        ; ToolTip, %A_PriorKey%
        Send, !^+f
        CtrlPriorHotkey := "!^+f"
        Return
    } else if (isPressedKeyWithAt()) {
        Send, 6
    }else if(isPressedKeyWithSemicolon()) {
        Send, +]
    } else {
        Send, {Blind}f
    }
Return 

$^f::
    ; Tooltip, %CtrlPriorHotkey%
    if (isActiveProcess("Obsidian") && isSecondKeyAfterCtrlJ() && CtrlPriorHotkey = "$^j"){
        ; ToolTip, %CtrlPriorHotkey%
        ; ToolTip, %A_PriorHotKey%
        ; 以下書かないとctrl j が CtrlPriorHotkeyのままになってキー入力がされない
        Send, ^+e
        CtrlPriorHotkey := "^+e"
        Return
    }else if(isPressedKeyWithSemicolon()) {
        Send, +]
    } else {
        Send, {Blind}f
    }
Return

$g::
    if (isActiveProcess("Obsidian") && isSecondKeyAfterCtrlJ() && CtrlPriorHotkey= "$^j"){
        Send, ^g
        ; 以下書かないとctrl j が CtrlPriorHotkeyのままになってキー入力がされない
        CtrlPriorHotkey := "^g"
        Return
    } else if (isSecondColon()) {
        ActivateWindowByProcess("Chrome")
        move_corsor_to_active_centor()
        SemicolonPriorHotkey := "g"
        SemicolonPressedStartTime := 0
    } else if (isPressedKeyWithSemicolon()) {
        ; Send, {asc 0037}
        Send, `%
    } else {
        Send, {Blind}g
    }
Return 

$h::
    if (isActiveProcess("Obsidian") && isSecondKeyAfterCtrlJ() && CtrlPriorHotkey= "$^j"){
        Send, !^+h
        CtrlPriorHotkey := "!^+f"
    }else if (isPressedKeyWithSemicolon()) {
        Send, {SC027}
    } else {
        Send, {Blind}h
    }
Return 

; $+j
;     ; tooltip, test
;     if (isPressedKeyWithSemicolon()) {
;     } else if (isActiveProcess("firefox")) {
;         if (GetKeyState(Ctrl)){
;             Send, hfdfdf
;         }
;     } else {    
;         Send, {Blind}^+h
;     }
; Return  

; firefox tree style tabサイドバーの開閉
$+^h::
    ; tooltip, test
    if (isPressedKeyWithSemicolon()) {
    } else if (isActiveProcess("firefox")) {
        Send, ^q
    } else { 
        Send, {Blind}^+h
    }
Return 

$i::
    if (isSecondColon()){
        ActivateWindowByProcess("intellij") 
        move_corsor_to_active_centor()
    } else if (isPressedKeyWithSemicolon()) {
        Send, |
    } else {
        Send, {Blind}i
    }
Return 

$j::
    ; $+j::
    if (isActiveProcess("Obsidian") && isSecondKeyAfterCtrlJ() && A_PriorKey = "j"){
        ; 以下のような部分いらないかも 
        CtrlPriorHotkey := "j"
        Send, j
    } else if (isSecondColon()){
        ActivateWindowByProcess("intellij") 
        move_corsor_to_active_centor()
    } else if (isPressedKeyWithSemicolon()) {
        Send, {blind}(
        } else {
            Send, {Blind}j
        }
        Return 

        $k::
            if (isPressedKeyWithSemicolon()) {
            Send, )
        } else {
            Send, {Blind}k
        }
        Return 

        $l::
            if (isPressedKeyWithSemicolon()) {
                Send, =
            } else {
                Send, {Blind}l
            }
        Return 

        $m::
            if (isActiveProcess("Obsidian") && isSecondKeyAfterCtrlJ() && CtrlPriorHotkey= "$^j"){
                Send, !^+m
                CtrlPriorHotkey := "!^+m"
            } else if (isPressedKeyWithSemicolon()) {
                Send, ~
            } else {
                Send, {Blind}m
            }
        Return 

        $n::
            if (isPressedKeyWithSemicolon()) {
                Send, _
            } else {
                Send, {Blind}n
            }
        Return 

        $o::
            ;if (isSecondKeyAfterAltJ()){
            if (isSecondColon()){
                ActivateWindowByProcess("Obsidian")
                move_corsor_to_active_centor()
                SemicolonPriorHotkey := "o"
                SemicolonPressedStartTime := 0
            }else if (isPressedKeyWithSemicolon()) {
                Send, {^}
            } else {
                Send, {Blind}o
            }
        Return 

        $p::
            if (isPressedKeyWithSemicolon()) {
                Send, =
            } else {
                Send, {Blind}p
            }
        Return 

        $q::
            if (isPressedKeyWithSemicolon()) {
                Send, +1
            } else if (isPressedKeyWithAt()) {
                Send, 0
            } else {
                Send, {Blind}q
            }
        Return 

        $r::
            if (isSecondColon()){
                ActivateWindowByProcess("vscode") 
                move_corsor_to_active_centor()
                SemicolonPriorHotkey := "r"
                SemicolonPressedStartTime := 0
            }
            if (isPressedKeyWithSemicolon()) {
                Send, '
            } else if (isPressedKeyWithAt()) {
                Send, 3
            } else {
                Send, {Blind}r
            }
        Return 

        $s::
            if (isSecondColon()){
                ActivateWindowByProcess("chrome") 
                move_corsor_to_active_centor()
            } else if (isPressedKeyWithSemicolon()) {
                Send, -
            } else if (isPressedKeyWithAt()) {
                Send, 4
            } else {
                Send, {Blind}s
            }
        Return 

        $^s::
            if (isPressedKeyWithSemicolon()) {
                Sendinput, {■ }{Space} 
            } else {
                Send, {Blind}^s
            }
        Return 

        $t::
            ;if (isSecondKeyAfterAltJ()){
            if (isSecondColon()){
                Clipboard = %A_Year%-%A_Mon%-%A_MDay%
                SemicolonPriorHotkey := "^t"
                SemicolonPressedStartTime := 0
                Send, ^v
            }else if (isPressedKeyWithSemicolon()) {
                Send, $
            } else {
                Send, {Blind}t
            }
        Return 

        $^t::
            if (isSecondColon()){
                ActivateWindowByProcess("terminal") 
                move_corsor_to_active_centor()
                SemicolonPriorHotkey := "^t"
                SemicolonPressedStartTime := 0
            }else if (isPressedKeyWithSemicolon()) {
            } else {
                Send, {Blind}t
            }
        Return 

        $u::
            if (isSecondColon()){
                SendSnippet(" -> ") 
            } else if (isPressedKeyWithSemicolon()) {
                Send, &
            } else {
                Send, {Blind}u
            }
        Return

        $^u::
            if (isPressedKeyWithSemicolon()) {
                ; if (isSecondColon()){
                If (IME_GET() == 1){
                    IME_SET(0)
                    SendSnippet(" -> ")
                    ReleaseModifiers()
                    IME_SET(1) 
                } else {
                    SendSnippet("-> ")
                    ; 下のやつをつけるとCtrl押しっぱなしが解消される(理由あいまい)
                    ReleaseModifiers()
                }
            } else {
                Send, {Blind}^u
            }
        Return 

        $^v::
            if (isPressedKeyWithSemicolon()) {
                SendInput, {【}{】}
                Sleep 50
                send {left}
            } else {
                Send, {Blind}^v
            }
        Return 

        $v::
            ;if (isSecondKeyAfterAltJ()){
            if (isSecondColon()){
                ActivateWindowByProcess("vscode") 
                move_corsor_to_active_centor()
                SemicolonPriorHotkey := "v"
                SemicolonPressedStartTime := 0
            } else if (isPressedKeyWithAt()) {
                Send, 9
            }else if (isPressedKeyWithSemicolon()) {
                Send, ]
            } else {
                Send, {Blind}v
            }
        Return 
        ; 
        ; #IfWinNotActive ahk_class VRChat 

        $w::
            if (isSecondColon()){
                ActivateWindowByProcess("terminal") 
                move_corsor_to_active_centor()
                SemicolonPriorHotkey := "w"
                SemicolonPressedStartTime := 0
            } else if (isPressedKeyWithSemicolon()) {
                Send, ?
            } else if (isPressedKeyWithAt()) {
                Send, 1
            } else { 
                ; Send, {Blind}{DownTemp w}
                Send, {Blind}w
            }
        Return 

        $x::
            if (isPressedKeyWithSemicolon()) {
                Send, /
            } else if (isPressedKeyWithAt()) {
                Send, 7
            } else {
                Send, {Blind}x
            }
        Return 

        $y::
            if (isPressedKeyWithSemicolon()) {
                Send, {+}
            } else {
                Send, {Blind}y
            }
        Return 

        $^y::
            if (isPressedKeyWithSemicolon()) {
                Send a
                ; か
            } else {
                Send, {Blind}^y
            }
        Return 

        $z::
            if (isPressedKeyWithSemicolon()) {
                Send, \
            } else if (isPressedKeyWithAt()) {
                Send, 0
            } else {
                Send, {Blind}z
            }
        Return 

        ; obsidian Ctrl+jのあとならファイルを開く
        $!j::Return

        $^j::
            ;以下コード意味不, もとの機能の上書きかな
            if (isActiveProcess("Chrome")){
                Return
            }
            ; Ctrl j の入力待ちでctrl jを打つとバグる
            Send, ^j
            CtrlPriorHotkey := "$^j" 
        Return

        ; #IfWinActive ahk_class UnityWndClass 
        ; $w::w

        $2::
            if (isSecondColon()){
                ActivateWindowByProcess("Obsidian")
                move_corsor_to_active_centor()
                SemicolonPriorHotkey := "2"
                SemicolonPressedStartTime := 0
                return
            }
            if (isPressedKeyWithSemicolon()) {
                Send, {+}
            } else {
                Send, {Blind}2
            }
        Return 

        $3::
            if (isPressedKeyWithSemicolon()) {
                Send, {+}
            } else {
                Send, {Blind}3
            }
        Return 

        $4::
            if (isPressedKeyWithSemicolon()) {
                Send, ``
            } else {
                Send, {Blind}4
            }
        Return 

