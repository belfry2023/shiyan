;eg0801
include io16.inc
.data 
freq word 1193180/600    ; 生成600Hz频率
.code
;============ 主程序 =============
start:
    mov ax, freq
    call speaker     ; 设置扬声器音调
    call speakon     ; 开启扬声器
    call readc      ; 等待按键输入
    call speakoff    ; 关闭扬声器
;============ 扬声器控制子程序 ============
speaker proc
    ; 功能：设置发音频率
    ; 入口参数：AX = 1.19318×10^6 ÷ 目标频率
    push ax         ; 保存入口参数
    mov al, 0b6h    ; 定时器2设置为模式3（方波发生器）
    out 43h, al     ; 写入控制寄存器
    pop ax          ; 恢复计数值
    out 42h, al     ; 写入低字节
    mov al, ah
    out 42h, al     ; 写入高字节
    ret
speaker endp

;============ 扬声器开启子程序 ============
speakon proc
    push ax
    in al, 61h      ; 读取端口61H当前状态
    or al, 03h      ; 设置PB0和PB1位（开启定时器2和扬声器）
    out 61h, al     ; 更新控制信号
    pop ax
    ret
speakon endp

;============ 扬声器关闭子程序 ============
speakoff proc
    push ax
    in al, 61h      ; 读取端口61H当前状态
    and al, 0fch    ; 清除PB0和PB1位（关闭定时器2和扬声器）
    out 61h, al     ; 更新控制信号
    pop ax
    ret
speakoff endp
end start