assume cs:codeseg, ds:dataseg, ss:stackseg
dataseg segment
mus_freq    dw  330, 294, 262, 294     ; 3 2 1 2
            dw  330, 349, 330, 294     ; 3.4 3 2.
            dw  330, 294, 262, 294     ; 3 2 1 2
            dw  330, 349, 330, 294     ; 3.4 3 2.

            dw  330, 294, 262, 294     ; 3 2 1 2
            dw  330, 349, 330, 294     ; 3.4 3 2.
            dw  330, 294, 262, 294     ; 3 2 1 2
            dw  330, 349, 330, 294 ;3.4 3 2 12

            ; ... 根据简谱补充后续音符频率
            dw  -1   ; 结束标志
mus_time    dw  24,12,24,12, 18,6,12,36  ; 3 2 1 2 | 3.4 3 2.
            dw  24,12,24,12, 18,6,12,36  ; 重复段落
            dw  24,12,24,12, 18,6,12,36
            dw  24,12,24,12, 18,6,12,36   ; 最后音符延长
            ; ...（补充剩余时值）
dataseg ends

stackseg segment
   db 100h dup (0)
stackseg ends

codeseg segment
start:
    mov ax, stackseg
    mov ss, ax
    mov sp, 100h

    mov ax, dataseg
    mov ds, ax

    lea si, mus_freq
    lea di, mus_time

play:
    mov dx, [si]
    cmp dx, -1
    je end_play
    call sound
    add si, 2
    add di, 2
    jmp play

end_play:
    mov ax, 4c00h
    int 21h

;演奏一个音符
;入口参数：si - 要演奏的音符的频率的地址
;         di - 要演奏的音符的音长的地址
sound:
    push ax
    push dx
    push cx

    ;8253 芯片(定时/计数器)的设置
    mov al,0b6h    ;8253初始化
    out 43h,al     ;43H是8253芯片控制口的端口地址
    mov dx,12h
    mov ax,34dch
    div word ptr [si] ;计算分频值,赋给ax。[si]中存放声音的频率值。
    out 42h, al       ;先送低8位到计数器，42h是8253芯片通道2的端口地址
    mov al, ah
    out 42h, al       ;后送高8位计数器

    ;设置8255芯片, 控制扬声器的开/关
    in al,61h   ;读取8255 B端口原值
    mov ah,al   ;保存原值
    or al,3     ;使低两位置1，以便打开开关
    out 61h,al  ;开扬声器, 发声

    mov dx, [di]       ;保持[di]时长
wait1:
    mov cx, 28000
delay:
    nop
    loop delay
    dec dx
    jnz wait1

    mov al, ah         ;恢复扬声器端口原值
    out 61h, al

    pop cx
    pop dx
    pop ax
    ret

codeseg ends
end start