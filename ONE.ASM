        .model small
        .stack
        .data
prompt1 db 13,10,"Enter number to find factorial : ","$"
prompt2 db 13,10,"Number of 1's : ","$"
space   db 13,10," ","$"
res     dw 0000h
count   db 00h
        .code
main    proc
        mov ax,@data
        mov ds,ax
        lea dx,prompt1
        mov ah,09h
        int 21h

        mov ah,01h
	int 21h

        lea dx,space
        mov ah,09h
        int 21h

        sub al,30h
        mov ah,00h

        mov cx,ax
        dec cx
lp:     cmp cx,00h
        jz done
        mul cx
        dec cx
        jmp lp

done:   mov res,ax
        lea si,res
        call print16

        lea dx,prompt2
        mov ah,09h
        int 21h

        mov cl,00h
        mov ax,res
ncptd:  cmp ax,0000h
        je cptd
        shl ax,1
        jnc ncptd
        inc cl
        jmp ncptd
        
cptd:   mov count,cl
        lea si,count
        call print8

        mov ah,4ch
        int 21h
main    endp
print8  proc
        mov dl,[si]
        and dl,0f0h
        mov cl,04h
        ror dl,cl
        add dl,30h
        cmp dl,39h
        jbe np
        add dl,07h
np:     mov ah,02h
        int 21h

        mov dl,[si]
        and dl,0fh
        add dl,30h
        cmp dl,39h
        jbe mop
        add dl,07h
mop:    mov ah,02h
        int 21h
        ret
print8  endp
print16 proc
        inc si
        call print8
        dec si
        call print8
        ret
print16 endp
        end
