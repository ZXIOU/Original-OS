﻿; 程序源代码（stone.asm）
; 本程序在文本方式显示器上从左边射出一个*号,以45度向右下运动，撞到边框后反射,如此类推.
org 100h					; 程序加载到100h，可用于生成COM
Dn_Rt equ 1                  	;D-Down,U-Up,R-right,L-Left
Up_Rt equ 2                  	;
Up_Lt equ 3                  	;
Dn_Lt equ 4                  	; 
delay equ 50000					; 计时器延迟计数,用于控制画框的速度
ddelay equ 580					; 计时器延迟计数,用于控制画框的速度

start:		
	mov ax,cs
	mov es,ax					
	mov ds,ax					; DS = CS
	mov es,ax					; ES = CS
	mov	ax,0B800h				; 文本窗口显存起始地址
	mov	gs,ax					; GS = B800h
    mov byte[char],'A'
    call clear
loop1:
	dec word[count]				; 递减计数变量
	jnz loop1					; >0：跳转;
	mov word[count],delay
	dec word[dcount]				; 递减计数变量
    jnz loop1
	mov word[count],delay
	mov word[dcount],ddelay

    mov al,1
    cmp al,byte[rdul]    
	jz  DnRt
    mov al,2
    cmp al,byte[rdul]    
	jz  UpRt
    mov al,3
    cmp al,byte[rdul]    
	jz  UpLt
    mov al,4
    cmp al,byte[rdul]    
	jz  DnLt
   
    jmp $	

DnRt:
	inc word[x]
	inc word[y]
	mov bx,word[x]
	mov ax,13
	sub ax,bx
    jz  dr2ur
	mov bx,word[y]
	mov ax,39
	sub ax,bx
    jz  dr2dl
	jmp show
dr2ur:
    mov word[x],11
    mov byte[rdul],Up_Rt	
    jmp show
dr2dl:
    mov word[y],37
    mov byte[rdul],Dn_Lt	
    jmp show

UpRt:
	dec word[x]
	inc word[y]
	mov bx,word[y]
	mov ax,39
	sub ax,bx
    jz  ur2ul
	mov bx,word[x]
	mov ax,-1
	sub ax,bx
    jz  ur2dr
	jmp show
ur2ul:
    mov word[y],37
    mov byte[rdul],Up_Lt	
    jmp show
ur2dr:
    mov word[x],1
    mov byte[rdul],Dn_Rt	
    jmp show

	
	
UpLt:
	dec word[x]
	dec word[y]
	mov bx,word[x]
	mov ax,-1
	sub ax,bx
    jz  ul2dl
	mov bx,word[y]
	mov ax,-1
	sub ax,bx
    jz  ul2ur
	
	
	jmp show

ul2dl:
    mov word[x],1
    mov byte[rdul],Dn_Lt	
    jmp show
ul2ur:
    mov word[y],1
    mov byte[rdul],Up_Rt	
    jmp show

	
	
DnLt:
	inc word[x]
	dec word[y]
	mov bx,word[y]
	mov ax,-1
	sub ax,bx
    jz  dl2dr
	mov bx,word[x]
	mov ax,13
	sub ax,bx
    jz  dl2ul
	jmp show

dl2dr:
    mov word[y],1
    mov byte[rdul],Dn_Rt	
    jmp show
	
dl2ul:
    mov word[x],11
    mov byte[rdul],Up_Lt	
    jmp show
	
show:	
    xor ax,ax                 ; 计算显存地址
    mov ax,word[x]
	mov bx,80
	mul bx
	add ax,word[y]
	mov bx,2
	mul bx
	mov bp,ax
	mov ah,0ah					;  0000：黑底、0ah：绿字（默认值为07h）
	mov al,byte[char]			;  AL = 显示字符值（默认值为20h=空格符）
	mov word[gs:bp],ax  		;  显示字符的ASCII码值
	mov ah,01h
	int 16h
	jz loop1
	mov ah,00h
	int 16h
	jmp 0000h:8400h
	
clear:
	mov     ax, 0600h			 
 	mov     bx, 0700h 
 	mov     cx, 0h
	mov     dx, 184fh 
	int     10h	
	ret 
	
datadef:	
	count dw delay
	dcount dw ddelay
    rdul db Dn_Rt         ; 向右下运动
    x dw 3
	y dw 0
	char db 'A'