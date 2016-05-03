        .model small
        .stack
        .data
array   db 07h,04h,03h,02h,04h,02h,03h
count   db 7
cn      db 0
cp      db 0
space   db 13,10," ","$"
        .code
main    proc    ;i <- bl    j<- bh
        mov ax,@data
        mov ds,ax

        lea si,array
        call printarr
        lea dx,space
        mov ah,09h
        int 21h

        mov bl,0

        mov cl,count
        mov cn,cl
        dec cn
lp1:    cmp cn,00h
        jz ex2
        mov bx,0
        mov al,array[bx]
        mov ah,array[1+bx]
        cmp ah,al
        xchg ah,al
nswap:  mov cl,count
        mov cn,cl
        dec cp
        sub cp,bl

        cmp bh,cp
        je ex2
        inc bh
ex2:    inc bl
ex1:    lea si,array
        call printarr
        mov ah,4ch
        int 21h
main    endp
printarr proc
         mov cl,count
srt:     cmp cl,00h
         jz exp
         mov dl,[si]
         add dl,30h
         mov ah,02h
         int 21h
         inc si
         dec cl
         jmp srt
exp:    ret
printarr endp
        end
                   
