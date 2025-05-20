;eg0602
include io32.inc
.data
var  byte ' This is a test! '
.code
start:  ;主程序
    mov eax, offset var
    mov ecx, sizeof var
    call dispmem
exit 0
; 子程序
dispmem  proc
    push ebx
    mov ebx, eax
dispm1:  
    mov al, [ebx]
    call disphb
    mov al, ' '
    call dispc
    inc ebx
    loop dispm1
    pop ebx
    ret
dispmem  endp
end start