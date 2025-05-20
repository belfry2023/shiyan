; 文件名: d7dd4bb8837a04a5fba77aa5d7ee15c.asm
; 功能: 统计字符串中的空格数量并显示结果

include io32.inc        ; 包含输入输出宏库

.data
    string byte 'Let us have a try  ! ', 0dh, 0ah, 0  ; 定义待处理的字符串（含回车换行和结束符）

.code
start:
    xor ebx, ebx        ; 清零 ebx（用作字符索引）
    xor esi, esi        ; 清零 esi（用于统计空格数量）
    mov eax, offset string
    call dispmsg        ; 调用宏显示字符串

outlp:
    mov al, string[ebx] ; 读取当前字符到 al
    cmp al, 0           ; 检查是否到达字符串结尾
    jz done             ; 若为结尾则跳转到 done

again:
    cmp al, ' '         ; 检查当前字符是否为空格
    jnz next            ; 若非空格则跳转到 next
    inc esi             ; 空格计数器加 1

inlp:
    inc ebx             ; 索引递增
    jmp outlp           ; 跳回循环继续处理

next:
    inc ebx             ; 索引递增
    jmp outlp           ; 跳回循环继续处理

done:
    mov eax, esi        ; 将空格数量存入 eax
    call dispuid        ; 调用宏显示统计结果

end start