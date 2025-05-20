include io32.inc  
; 数据段
.data
array    dword 675,354,-34,198,267,0.9,2371,-67,4257

; 代码段
.code
start:
    push lengthof array    ; 压入数据个数
    push offset array      ; 压入数组的偏移地址
    call mean              ; 调用求平均值子程序
    add esp,8              ; 平衡堆栈
    call dispsid           ; 显示结果（需自行实现）

; 子程序：计算32位有符号数平均值
mean proc
    push ebp
    mov ebp,esp
    push ebx
    push ecx
    push edx

    mov ebx,[ebp + 8]      ; 取数组偏移地址
    mov ecx,[ebp + 12]     ; 取数据个数
    xor eax,eax            ; 累加器清零
    xor edx,edx            ; 索引初始化

mean1:
    add eax,[ebx + edx * 4]  ; 累加数组元素
    add edx,1               ; 索引递增
    cmp edx,ecx
    jb mean1                ; 循环求和

    cdq                     ; 符号扩展EAX到EDX
    idiv ecx                ; 有符号除法（EAX=平均值）

    pop edx
    pop ecx
    pop ebx
    pop ebp
    ret
mean endp
end start