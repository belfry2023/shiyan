;eg0501
include io32.inc
.data
string byte 'Do you have fun with Assembly?',0
.code
start:
    xor ebx,ebx
    again: mov al, string[ebx]
    cmp al,0
    jz done
    inc ebx
    jmp again
    done : mov eax, ebx
    call dispuid
    exit 0
end start