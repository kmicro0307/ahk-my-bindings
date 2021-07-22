#UseHook

*::
If (IME_GET() == 1){
   IME_SET(0)  
   Send, {Blind}*
   IME_SET(1)     
} else {
    Send, {Blind}* 
}
Return 

:::
If (IME_GET() == 1){
   IME_SET(0)  
   Send, {Blind}:
   IME_SET(1)     
} else {
    Send, {Blind}:
}
Return

"::
If (IME_GET() == 1){
   IME_SET(0)  
   Send, {Blind}"
   IME_SET(1)     
} else {
    Send, {Blind}" 
}
Return

'::
If (IME_GET() == 1){
   IME_SET(0)  
   Send, {Blind}'
   IME_SET(1)     
} else {
    Send, {Blind}' 
}
Return

+@::
If (IME_GET() == 1){
   IME_SET(0)  
   Send, {Blind}+@
   IME_SET(1)     
} else {
    Send, {Blind}+@
}
Return

; @は修飾キーで使うかも
; @::
; If (IME_GET() == 1){
;    IME_SET(0)  
;    Send, {Blind}@
;    IME_SET(1)     
; } else {
;     Send, {Blind}@
; }
; Return

+3::
If (IME_GET() == 1){
   IME_SET(0)  
   Send, {Blind}+3
   IME_SET(1)     
} else {
    Send, {Blind}+3
}
Return
