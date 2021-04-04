; 変換キーと他キーのバインディング
; & スクリプトのリロード
; 【One Shot】 
; -> IME ON
; 【Combination】 
; -> 自作モディファイア
; 【memo】
; 変換のホットキー，shiftと一緒に動作してほしいキーとそうでないキーが有る
; してほしくない場合は内部で明示的にUpにする

#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force
;SetWinDelay, 0
;^j::NumpadUP
;^h::NumpadLEFT
;^l::NumpadRIGHT


#InstallKeybdHook
#UseHook
KeyPressedStartTime := 0
*vk1C::
  ; tooltip, %KeyPressedStartTime%
  if ( KeyPressedStartTime = 0 ){
    KeyPressedStartTime := A_TickCount
  }
Return

vk1C up::                         ;スペース解放時}}
  ; Send, % (A_TimeSincePriorHotkey < 1000 ? "{vk1C}":"")
   KeyPresseUpTime := A_TickCount
  ;  tooltip, %KeyPresseUpTime%
  ;  tooltip, %KeyPresseUpTime% - %KeyPressedStartTime%
   PressedTime := KeyPressedUpTime-KeyPressedStartTime
  ; tooltip, %PressedTime%
  ; tooltip, %A_PriorHotkey%
    If (KeyPresseUpTime- KeyPressedStartTime  < 300 and A_PriorHotkey="*vk1C" )
    { 
    Send, {vk1C}
    }
  ; Send,{vk1C}                ;スペースを発射
    KeyPressedStartTime := 0
  return

~vk1C & h::Send, {Blind}{Left}
~vk1C & j::Send, {Blind}{Down}
~vk1C & k::Send, {Blind}{Up}
~vk1C & l::Send, {Blind}{Right}
;~vk1C & a::Send, !{Esc}

;~vk1C & s::Send, {Blind}{Space}

~vk1C & u::Send,{Blind}{NumpadPgUp}
;~vk1C & d::Send,{Blind}{NumpadpgDn}
~vk1C & 0::Send,{Blind}{NumpadHome}
~vk1C & 4::Send,{Blind}{NumpadEnd}
~vk1C & o::
;  If (GetKeyState("Space", "P") or GetKeyState("Shift", "P")) {
 If  GetKeyState("Shift") {
    ; Send, {RShift Up}{NumpadEnd}{Enter}{RShift Down}{NumpadHome}{Space}{BackSpace}{RShift Down}
    SendInput, {LShift Up}{RShift Up}{NumpadHome}{Enter}{Up}{Blind}
    ; SendInput, {RShift Up}{NumpadEnd}{Enter}{End}+{Home}{Space}{BackSpace}+{Home}{Space}{BackSpace}{RShift Down}
    Return
  }
  Send,{Blind}{NumpadEnd}{Enter}
  Return
  ; TODO: shitとの3キー同時押し

;変換+スペース＝エンター
~vk1C & Enter::Send,{Blind}{Space}
;vkF3::Send,{Blind}{Enter}
~vk1C & vkF3::Send,{Blind}{Enter}
~vk1C & vkF4::Send,{Blind}{Enter}
;vkF3::Send,{Blind}{Enter}
;vkF4::Send,{Blind}{Enter}
~vk1C & vkF2::Send,{Blind}{Enter}
~vk1C & z::Send,{Blind}^z

;コピー&ペースト
~vk1C & c::
If (IME_GET() == 1){
  ; ATOKだとよくわからない動作をするので、動作を安定させるためにも、明示的にOFFのキーを送る
  ;  IME_SET(0)  
  Send, {vkF3}
}
Send,{Blind}^c
Return
~vk1C & v::Send,{Blind}^v

;文字削除
~vk1C & x:: Send,{Blind}^x
;~vk1C & d:: Send,{Blind}{BackSpace}

~vk1C & d::Send,{Blind}{End}+{Home}{BS}
; ; wのやつ、消える範囲が世蔵しづらいので没かなー
; ~vk1C & w::Send,{Blind}^+{NumpadLeft}{Delete}
~vk1C & r::Send,{Blind}{End}+{Home}^c

~vk1C & e::Send,{Blind}{End}+{Home}^x
~vk1C & s::Send,{Blind}{home}+{End}
~vk1C & b::Send,{End}
~vk1C & f::Send,{NumpadEnd}
;If (A_PriorHotKey == A_ThisHotKey and A_TimeSincePriorHotkey < 200)
;  {
;    SendInput, {BackSpace 2}
;    Send,{Blind}{NumpadPgUp}
;  }

~vk1C & a::Send, {NumpadHome}
~vk1C & p:: Reload

  

;アンダーバー、ドット、ピリオド
~vk1C & n:: Send,{Blind}{~}
~vk1C & m:: Send,{Blind}{_}

;vkf3 & h::send, {blind}{left}
;vkF3 & j::Send, {Blind}{Down}
;vkF3 & k::Send, {Blind}{Up}
;vkF3 & l::Send, {Blind}{Right}
;vkF3 & a::Send, !{Esc}
;vkF3 & s::Send, ^!{Esc}

;vkF3 & e::Send, {Enter}

;vkF3 & u::Send,{Blind}{NumpadPgUp}
;vkF3 & d::Send,{Blind}{NumpadpgDn}
;vkF3 & 0::Send,{Blind}{NumpadHome}
;vkF3 & 4::Send,{Blind}{NumpadEnd}

;~vkF3 & w::Send,{Blind}^{Right}
;~vkF3 & b::Send,{Blind}^{Left}


;無変換+スペース＝エンター
;vkF3 & Space::Send,{Blind}{Enter}
;
;コピー&ペースト
;vkF3 & c::Send,{Blind}^c
;vkF3 & v::Send,{Blind}^v

;文字削除
;vkF3 & x:: Send,{Blind}{BackSpace}











