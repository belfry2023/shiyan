;eg0701
include io16.inc
.data
    intmsg byte 'A 8259A Interrupt!',0dh,0ah,0
    counter byte 0
.code
start:
    mov ax,3508h
    int 21h
    push es
    push bx
    cli
    push ds
    mov ax,seg new08h
    mov ds,ax
    mov dx,offset new08h
    mov ax,2508h
    int 21h
    pop dx
    in al,21h
    push ax
    and al,0feh
    out 21h,al
    mov counter,0
    sti
start1:
    cmp counter,10
    jb start1
    cli
    pop ax
    out 21h,al
    pop dx
    pop ds
    mov ax,2508h
    int 21h
    sti

new08h proc
    sti
    push ax
    push si
    push ds
    mov ax, @data
    mov ds,ax
    inc counter
    mov si,offset intmsg
    call dpstri
    mov al,20h
    out 20h,al
    pop ds
    pop si
    pop ax
    iret
new08h endp

dpstri proc
    push ax
    push bx
dps1:
    mov al,[si]
    cmp al,0
    jz dps2
    mov bx,0
    mov ah,0eh
    int 10h
    inc si
    jmp dps1
dps2:
    pop bx
    pop ax
    ret
dpstri endp
end start