#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

; -----------------------------------------
; vimライクキーバインドを実装する
; 主にテキスト操作に使用するキーバインドを設定する
; -----------------------------------------


; ■ hjklでvimバインドっぽく移動する
SC028 & w::
    ActivateWindowByProcess("terminal") 
    move_corsor_to_active_centor()
  Return

SC028 & e::
    ActivateWindowByProcess("obsidian") 
    move_corsor_to_active_centor()
  Return

SC028 & c::
    ActivateWindowByProcess("chrome")
    move_corsor_to_active_centor()
  Return

SC028 & j::
  ActivateWindowByProcess("intellij") 
  move_corsor_to_active_centor()
  Return

SC028 & v::
  ActivateWindowByProcess("vscode") 
  move_corsor_to_active_centor()
  Return