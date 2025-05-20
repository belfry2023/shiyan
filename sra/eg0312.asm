;eg0206
include io32.inc
.data
    msg    byte    "welcome", 0    ; 定义以0结尾的字符串
.code
start:
    mov    ecx, (lengthof msg) - 1    ; ECX = 字符串长度（不计结尾的0）
    mov    ebx, 0                     ; EBX = 0，指向字符串首字符

again:
    sub    msg[ebx], 'a' - 'A'    ; 将小写字母转换为大写（减20H）
    inc    ebx                    ; EBX++，指向下一个字符
    loop   again                  ; 循环直到ECX=0

    mov    eax, offset msg            ; EAX = 字符串地址
    call   dispmsg                    ; 调用子程序显示字符串
end start