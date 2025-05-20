;eg0205
include io32.inc
.data
    num    byte    6, 7, 7, 8, 3, 0, 0, 0    ; 待转换的数字序列
    tab    byte    '0123456789'              ; 数字对应的ASCII码表（索引0~9）
.code
start:
    mov    ecx, lengthof num       ; ECX = 数字序列的长度（循环次数）
    mov    esi, offset num         ; ESI指向num数组首地址
    mov    ebx, offset tab         ; EBX指向ASCII码表首地址
again:
    mov    al, [esi]           ; AL = 当前待转换的数字（如6）
    xlat                       ; 换码：AL = [EBX + AL]（获取对应ASCII码）
    call   dispc               ; 显示AL中的ASCII字符
    add    esi, 1              ; ESI指向下一个数字（A应为1的笔误）
    loop   again               ; 循环直到ECX=0
end start