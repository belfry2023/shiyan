;eg0401
include io32.inc
.data
no_msg byte 'Not Ready!',0
yes_msg byte 'Ready to go!',0
.code
start:
    mov eax,02h
    shr eax,2
    jc nom
    mov eax,offset no_msg
    jmp done
nom: 
    mov eax,offset yes_msg
done: 
    call dispmsg
    exit 0
end start