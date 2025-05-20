; eg0800.asm in DOS
include io16.inc
.data
    table dw 2277, 2138, 1808, 1709, 1522, 1356, 1208, 1139	
.code
start:
    mov al, 0b6h  ; 设置定时器 2 工作方式
    out 43h, al
again:  
    call readc  ; 等待按键
    cmp al, '1'  ; 判断是否为数字 1～8
    jb next
    cmp al, '8'
    ja next
    sub al, 30h  ; 1～8 的 ASCII 码转换为二进制数
    sub al, 1  ; 再减 1， 将数字 1～8变为 0～7， 以便查表
    xor ah, ah
    shl ax, 1  ; 乘以 2
    mov bx, ax  ; 记数值表是 16 位数据，无法采用 xlat 指令
    mov ax, table[bx]  ; 取出对应的记数值
    out 42h, al  ; 设置定时器 2 的记数值
    mov al, ah
    out 42h, al
    in al, 61h  ; 打开扬声器声音
    or al, 03h  ; 使 D1D0 ＝ PB1PB0 ＝11B， 其他位不变
    out 61h, al
    jmp again  ; 连续发声， 直到按下另一个键
next:  
    push ax
    in al, 61h  ; 不是数字 1～8， 则关闭扬声器声音
    and al, 0fch  ; 使 D1D0 ＝ PB1PB0 ＝00b， 其他位不变
    out 61h, al
    pop ax
    cmp al, 1bh  ; 判断是否为 ESC 键（对应 ASCII 码 1bh）
    jne again  ; 不是 ESC， 继续； 否则程序执行结束
exit 0

end start 
