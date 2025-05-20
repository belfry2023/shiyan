;ex0411
include io32.inc
.data 
; 数据段
inmsg  byte ' Input number(0~9) : ' , 0
ermsg  byte 0dh, 0ah, ' Error! Input again: ' , 0
 ; 代码段
.code 
start:
    mov eax, offset inmsg  ; 提示输入数字
    call dispmsg
again:  
    call readc  ; 等待按键
    cmp al,'0'  ; 数字 < 0？
    jb erdisp
    cmp al,'9'  ; 数字 > 9？
    ja erdisp
    call dispcrlf
    call dispc
    jmp done
erdisp:  
    mov eax, offset ermsg
    call dispmsg
    jmp again
done:

end start