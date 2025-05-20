;eg0203
include io32.inc
;-------------- 数据段定义 --------------
.data
    bvar   byte    12h, 34h          ; 定义字节变量
    org     $ + 10                   ; 地址向后调整10字节
    array   word    1, 2, 3, 4, 5, 6, 7, 8, 9, 10  ; 定义字数组

    wvar   word    5678h             ; 定义字变量
    arr_size = $ - array             ; 计算数组总字节数
    arr_len = arr_size / 2           ; 计算数组元素个数（字单位）
    dvar   dword   9abcdef0h         ; 定义双字变量

;-------------- 代码段指令 --------------
.code
start:
    mov    al, bvar                  ; 加载bvar第一个字节到AL
    ; 注意："R mov ah, bvar+1" 中的 "R" 可能为注释或特殊标记
    mov    ah, bvar + 1              ; 加载bvar第二个字节到AH
    mov    bx, wvar[2]               ; 加载wvar偏移2字节处的值到BX（需确认地址对齐）

    mov    ecx, arr_len              ; 将数组长度存入ECX
    mov    edx, $                    ; 将当前地址（$）存入EDX
    mov    esi, offset dvar          ; 将dvar的偏移地址存入ESI
    mov    edi, [esi]                ; 将ESI指向的双字值加载到EDI
    ; 注意："R mov ebp, dvar" 中的 "R" 可能为注释或特殊标记
    mov    ebp, dvar                 ; 直接加载dvar的值到EBP
    call   disprd                    ; 调用显示过程
end start