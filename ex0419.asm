include io32.inc
.data
    msg1 byte ' Please input a character: ' , 0
    msg2 byte ' The ASCII code of the charater you entered is: ' , 0
    msg3 byte ' The code with even parity is: ' , 0
.code
start:
    mov eax, offset msg1
    call dispmsg
    call readc
    call dispcrlf
    mov ebx, eax
    mov eax, offset msg2
    call dispmsg
    mov eax, ebx
    call dispbb
    call dispcrlf
    and al, 7fh
    jp next
    or al, 80h
next:  
    mov ebx, eax
    mov eax, offset msg3
    call dispmsg
    mov eax, ebx
    call dispbb
exit 0
end start