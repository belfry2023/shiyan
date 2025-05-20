; eg0702.asm in DOS
; 功能：读取CMOS RAM中的日期信息并显示（年-月-日格式）
include io16.inc        ; 包含16位I/O库

.code
start:
    ; 读取年份（CMOS RAM 09H单元）
    mov al, 9           ; AL = 9（选择CMOS RAM的09H单元，存储年份的后两位）
    out 70h, al         ; 向70H端口写入单元号
    in al, 71h          ; 从71H端口读取数据到AL
    call dispbb         ; 调用子程序显示AL中的BCD码值（如19H显示为"19"）

    ; 显示分隔符"-"
    mov al, '-'         
    call dispc          ; 调用字符显示子程序

    ; 读取月份（CMOS RAM 08H单元）
    mov al, 8           ; AL = 8（选择08H单元，存储月份）
    out 70h, al
    in al, 71h
    call dispbb

    ; 显示分隔符"-"
    mov al, '-'
    call dispc

    ; 读取日期（CMOS RAM 07H单元）
    mov al, 7           ; AL = 7（选择07H单元，存储日期）
    out 70h, al
    in al, 71h
    call dispbb

    exit 0              ; 退出程序，返回DOS

end start