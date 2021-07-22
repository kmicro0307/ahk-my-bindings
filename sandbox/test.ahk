#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

ModeValue := 0

a & i::
    if (ModeValue == 1){
        ModeValue = 0
        tooltip, %ModeValue% 
    } else if (ModeValue ==0){
        ModeValue = 1
        tooltip, %ModeValue%
        }
    return 

#if  ModeValue  == 1
a:: 
    Send, 2
    return

#if not ModeValue == 1
a:: 
    Send, 1
    return