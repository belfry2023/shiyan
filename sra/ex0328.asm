;eg0302
include io32.inc
; 数据段
.data
    bcd  byte 92h
; 代码段
.code
start:
    mov al, bcd
    shr al, 4
    add al, 30h
    call dispc
    mov al, bcd
    and al, 0fh
    add al, 30h
    call dispc
end start