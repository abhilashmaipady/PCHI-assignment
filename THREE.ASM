        .model small
        .stack
        .data
array1  db 05h,43h,32h,34h
array2  db 10h,32h,32h,23h
count   db 4
cn      db 0
prompt db 13,10,"  ","$"

        .code
main    proc
        mov ax,@data
        mov ds,ax

        lea si,array1
        lea di,array2
        mov bh,count
        
lp1:    cmp bh,00h
        jbe lp2
        mov bl,[si]
        add bl,[di]

        lea dx,prompt
        mov ah,09h
        int 21h
        call print8
        lea dx,prompt
        mov ah,09h
        int 21h
        call hex2dec
        inc si
        inc di
        dec bh
        jmp lp1
                
lp2:    mov ah,4ch
        int 21h

main    endp
print8  proc
       
        mov dl,bl
        and dl,0f0h
        mov cl,04h
        ror dl,cl
        add dl,30h
        cmp dl,39h
        jbe lp3
        add dl,07h
lp3:    mov ah,02h
        int 21h

        mov dl,bl
        and dl,0fh
        add dl,30h
        cmp dl,39h
        jbe lp4
        add dl,07h
lp4:    mov ah,02h
        int 21h
        ret
print8  endp

hex2dec proc
        mov cn,0
        mov al,bl
        mov ah,00h
lp5:    mov dx,0000h
        mov cx,0010
        div cx
        push dx
        inc cn
        cmp ax,0009h
        jg lp5
        inc cn
        push ax
lp6:    cmp cn,00h
        je lp7
        pop ax
        mov dl,al
        add dl,30h
        mov ah,02h
        int 21h
        dec cn
        jmp lp6
lp7:    ret
hex2dec endp
        end
