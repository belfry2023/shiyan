;eg0301
include io32.inc
.data
    wvar    word    34000    ; 定义16位变量wvar，初始值为34000
.code
start:
    xor    eax, eax          ; 清空EAX（EAX = 0）
    mov    ax, wvar          ; 将wvar的值加载到AX（EAX的低16位）

    shl    eax, 1            ; 左移1位（EAX = EAX × 2）
    mov    ebx, eax          ; 保存中间结果到EBX（EBX = EAX × 2）

    shl    eax, 2            ; 继续左移2位（EAX = EAX × 4，此时EAX = 原值 × 8）
    add    eax, ebx          ; EAX = EAX + EBX（原值 × 8 + 原值 × 2 = 原值 × 10）

    call   dispuid           ; 显示EAX中的无符号十进制结果（乘积）
    call   dispcrlf          ; 执行其他操作（函数名可能为笔误，需确认）
    imul eax,10
    call dispuid
end start