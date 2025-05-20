;eg0303
include io32.inc
.data
    srcmsg  byte    'In a major matter, no details are small.', 0    ; 源字符串（以0结尾）
    destmsg byte    (lengthof srcmsg) dup (0)                        ; 目标缓冲区（初始化为0）
.code
start:
    mov    esi, offset srcmsg    ; ESI = 源字符串地址
    mov    edi, offset destmsg   ; EDI = 目标缓冲区地址
    mov    ecx, lengthof srcmsg  ; ECX = 字符串长度（包含结尾的0）
    cld                         ; 清除方向标志（DF=0），地址递增
    rep    movsb                ; 按字节重复传送：将[ESI]复制到[EDI]，直到ECX=0

    mov    eax, offset destmsg  ; EAX = 目标字符串地址
    call   dispmsg              ; 调用显示字符串的函数
end start
