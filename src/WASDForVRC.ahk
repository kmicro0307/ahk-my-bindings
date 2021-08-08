#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

; VRChat用ににキーを開放する
$w::w
$a::a
$s::s
$d::d
$Space::Space
RAlt::
    Send, {Esc Down}
    Sleep, 50
    Send, {Esc Up}
    Return

