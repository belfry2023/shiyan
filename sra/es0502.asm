.386
.model flat, stdcall
option casemap:none

include io32.inc        ; 包含输入输出宏库

.data
    msgN    byte 'Max N: ', 0          ; 输出提示信息
    msgSum  byte 'Max Sum: ', 0
    newline byte 0dh, 0ah, 0           ; 换行符

.code
start:
    xor eax, eax        ; 累加和初始化为0
    xor ebx, ebx        ; N初始化为0

loop_start:
    inc ebx             ; N += 1
    mov ecx, eax        ; 保存当前累加和到ECX
    add ecx, ebx        ; 尝试累加新的N
    jc overflow         ; 若溢出（CF=1），跳转
    mov eax, ecx        ; 更新累加和
    jmp loop_start      ; 继续循环

overflow:
    dec ebx             ; 最大N为EBX-1
    push eax            ; 保存累加和

    ; 输出Max N
    mov eax, offset msgN
    call dispmsg        ; 显示"Max N: "
    mov eax, ebx
    call dispuid        ; 显示N的值
    mov eax, offset newline
    call dispmsg        ; 换行

    ; 输出Max Sum
    mov eax, offset msgSum
    call dispmsg        ; 显示"Max Sum: "
    pop eax             ; 恢复累加和
    call dispuid        ; 显示累加和的值
    mov eax, offset newline
    call dispmsg        ; 换行

    mov eax, 0          ; 退出程序
    ret

end start