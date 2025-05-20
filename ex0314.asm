;eg0104
include io32.inc
.data
    table byte '   | 0 1 2 3 4 5 6 7 8 9 A B C D E F' , 13, 10
          byte ' ---+-------------------------------' , 13, 10
          byte ' 20| ' , 20h, 20h, 21h, 20h, 22h, 20h, 23h, 20h, 24h, 20h, 25h, 20h, 26h, 20h, 27h, 20h, 28h, 20h, 29h, 20h
          byte 2ah, 20h, 2bh, 20h, 2ch, 20h, 2dh, 20h, 2eh, 20h, 2fh, 20h, 13, 10
          byte  ' 30| ' , 30h, 20h, 31h, 20h, 32h, 20h, 33h, 20h, 34h, 20h, 35h, 20h, 36h, 20h, 37h, 20h, 38h, 20h, 39h, 20h
          byte 3ah, 20h, 3bh, 20h, 3ch, 20h, 3dh, 20h, 3eh, 20h, 3fh, 20h, 13, 10
          byte  ' 40| ' , 40h, 20h, 41h, 20h, 42h, 20h, 43h, 20h, 44h, 20h, 45h, 20h, 46h, 20h, 47h, 20h, 48h, 20h, 49h, 20h
          byte 4ah, 20h, 4bh, 20h, 4ch, 20h, 4dh, 20h, 4eh, 20h, 4fh, 20h, 13, 10
          byte  ' 50| ' , 50h, 20h, 51h, 20h, 52h, 20h, 53h, 20h, 54h, 20h, 55h, 20h, 56h, 20h, 57h, 20h, 58h, 20h, 59h, 20h
          byte 5ah, 20h, 5bh, 20h, 5ch, 20h, 5dh, 20h, 5eh, 20h, 5fh, 20h, 13, 10
          byte  ' 60| ' , 60h, 20h, 61h, 20h, 62h, 20h, 63h, 20h, 64h, 20h, 65h, 20h, 66h, 20h, 67h, 20h, 68h, 20h, 69h, 20h
          byte 6ah, 20h, 6bh, 20h, 6ch, 20h, 6dh, 20h, 6eh, 20h, 6fh, 20h, 13, 10
          byte  ' 70| ' , 70h, 20h, 71h, 20h, 72h, 20h, 73h, 20h, 74h, 20h, 75h, 20h, 76h, 20h, 77h, 20h, 78h, 20h, 79h, 20h
          byte 7ah, 20h, 7bh, 20h, 7ch, 20h, 7dh, 20h, 7eh, 20h, 7fh, 20h, 13, 10
          byte 0
.code
start:
 mov eax, offset table
 call dispmsg
 exit 0
end start