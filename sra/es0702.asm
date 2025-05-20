include io16.inc
.data
    intmsg byte 'A 8259A Interrupt! Count: 000',0dh,0ah,0
    counter byte 0
.code
start:
    mov ax, 3508h
    int 21h
    push es
    push bx
    cli
    push ds
    mov ax, seg new08h
    mov ds, ax
    mov dx, offset new08h
    mov ax, 2508h
    int 21h
    pop ds
    in al, 21h
    push ax
    and al, 0feh
    out 21h, al
    mov counter, 0
    sti
start1:
    cmp counter, 10
    jb start1
    ; 恢复中断向量部分
    cli
    pop ax
    out 21h, al      ; 恢复原IMR
    pop dx           ; 弹出原中断处理程序的偏移量（BX）
    pop ds           ; 弹出原中断处理程序的段地址（ES）
    mov ax, 2508h
    int 21h          ; 恢复原08h中断向量
    sti
    mov ax, 4c00h
    int 21h          ; 正常退出程序

new08h proc
    sti
    push ax
    push si
    push ds
    push bx
    mov ax, @data
    mov ds, ax
    inc counter

    ; Check if counter is even
    mov al, counter
    test al, 1
    jnz skip_display

    ; Convert counter to ASCII string
    mov al, counter
    mov ah, 0
    mov bl, 100
    div bl
    add al, '0'
    mov [intmsg+26], al  ; Hundreds place

    mov al, ah
    mov ah, 0
    mov bl, 10
    div bl
    add al, '0'
    mov [intmsg+27], al  ; Tens place
    add ah, '0'
    mov [intmsg+28], ah  ; Ones place

    mov si, offset intmsg
    call dpstri

skip_display:
    ; Send EOI to PIC
    mov al, 20h
    out 20h, al

    pop bx
    pop ds
    pop si
    pop ax
    iret
new08h endp

dpstri proc
    push ax
    push bx
dps1:
    mov al, [si]
    cmp al, 0
    jz dps2
    mov bx, 0
    mov ah, 0eh
    int 10h
    inc si
    jmp dps1
dps2:
    pop bx
    pop ax
    ret
dpstri endp
end start