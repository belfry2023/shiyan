;eg0102
include io32.inc
.data
    count dword 12345678h,9abcdef0h,0,0,3721h
.code
start:
    mov eax,33221100h
    mov ebx,eax
    mov ecx,count
    mov ebx,offset count
    mov ecx,[ebx]
    mov eax,[ebx+4]
    mov esi,4
    mov edi,count[esi]
    mov edi,[ebx+esi]
    mov ecx,[ebx+esi*4]
    mov ecx,[ebx+esi*4-4]
    mov ebp,esp
    call disprd
end start