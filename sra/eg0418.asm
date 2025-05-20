;eg0603
include io32.inc 
.data
    count    = 10
    array    dword count dup(0)
    temp     dword ?
    readbuf  byte 30 dup(0)
.code
start:
    mov ecx, count
    mov ebx, offset array
again:
    call read       ; 调用子程序，输入一个数据
    mov eax, temp   ; 获得出口参数
    mov [ebx], eax  ; 存放到数据缓冲区
    add ebx, 4
    dec ecx
    jnz again
read proc
    push eax        ; 出口参数：变量 TEMP = 补码表示的二进制数值
    push ebx        ; 说明：负数用 "-" 引导
    push ecx
    push edx        ; 说明：正数用 "+" 引导
read0:
    mov eax, offset readbuf  ; 输入一个字符串
    call readmsg
    test eax, eax
    jz readerr      ; 没有输入数据，转向错误处理
    cmp eax, 12
    ja readerr      ; 输入超过 12 个字符，转向错误处理
    mov edx, offset readbuf  ; EDX 指向输入缓冲区
    xor ebx, ebx    ; EBX 保存结果
    xor ecx, ecx    ; ECX 为正负标志，0 为正，-1 为负
    mov al, [edx]   ; 取一个字符
    cmp al, '+'     ; 是 "+"，继续
    jz read1
    cmp al, '-'     ; 是 "-"，设置 -1 标志
    jnz read2
    mov ecx, -1
read1:
    inc edx         ; 取下一个字符
    mov al, [edx]
    test al, al     ; 是结尾 0，转向求补码
    jz read3
read2:
    cmp al, '0'
    jb readerr      ; 不是 0 ~ 9 之间的数码，输入错误
    cmp al, '9'
    ja readerr
    sub al, 30h     ; 转换为二进制数
    imul ebx, 10    ; 原数值乘 10：EBX = EBX × 10
    jc readerr      ; CF=1，乘积溢出，输入数据超出 32 位范围
    movzx eax, al   ; 零位扩展，便于相加
    add ebx, eax    ; 原数值乘 10 后，与新数码相加
    cmp ebx, 80000000h
    jbe read1       ; 数据未超过 2^31，继续转换下一个数位
read3:
    test ecx, ecx   ; 判断是正数还是负数
    jz read4
    neg ebx         ; 是负数，进行求补
    jmp read5
read4:
    cmp ebx, 7fffffffh
    ja readerr      ; 正数超过 2^31 - 1，出错
read5:
    mov temp, ebx   ; 设置出口参数
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
readerr:
    mov eax, offset errmsg
    call dispmsg
    jmp read0
errmsg byte 'Input error, enter again:', 0
read endp
end start