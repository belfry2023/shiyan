; ex0722.asm in DOS
include io16.inc
.data
date byte 'Today is 20xx-yy-zz$'  ; 注意：必须用 $ 结尾，而非 0
.code
start:
    mov ax, @data       ; 初始化数据段
    mov ds, ax

    ; 处理年份的后两位（CMOS单元09h）
    mov bx, 11          ; 年份替换位置：索引11和12
    mov al, 9
    out 70h, al
    in al, 71h
    mov dl, al
    shr al, 4           ; 分离高位BCD码
    add al, 30h         ; 转为ASCII
    mov date[bx], al    ; 更新年份高位（'xx'的第一个x）
    inc bx
    and dl, 0fh         ; 分离低位BCD码
    add dl, 30h
    mov date[bx], dl    ; 更新年份低位（'xx'的第二个x）
    add bx, 2           ; 跳到月份位置（索引14）

    ; 处理月份（CMOS单元08h）
    mov al, 8
    out 70h, al
    in al, 71h
    mov dl, al
    shr al, 4
    add al, 30h
    mov date[bx], al    ; 月份高位（'yy'的第一个y）
    inc bx
    and dl, 0fh
    add dl, 30h
    mov date[bx], dl    ; 月份低位（'yy'的第二个y）
    add bx, 2           ; 跳到日期位置（索引17）

    ; 处理日期（CMOS单元07h）
    mov al, 7
    out 70h, al
    in al, 71h
    mov dl, al
    shr al, 4
    add al, 30h
    mov date[bx], al    ; 日期高位（'zz'的第一个z）
    inc bx
    and dl, 0fh
    add dl, 30h
    mov date[bx], dl    ; 日期低位（'zz'的第二个z）

    ; 使用DOS中断显示字符串
    mov ah, 09h         ; 功能号09h（显示以$结尾的字符串）
    mov dx, offset date
    int 21h

    exit 0

end start