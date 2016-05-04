extrn _fsprocess:near               	;声明一个c程序函数
extrn _CountLetter:near             	;声明一个c程序函数
extrn _str:near  						;声明一个c变量
extrn _str1:near  						;声明一个c变量
extrn _str2:near  						;声明一个c变量
extrn _str3:near  						;声明一个c变量
extrn _strNumber:near  					;声明一个c变量  
.8086
_TEXT segment byte public 'CODE'
DGROUP group _TEXT,_DATA,_BSS
assume cs:_TEXT
org  100h								; BIOS将把引导扇区加载到0:100h处，并开始执行
Start:
	adr dw 8400h,0000h
	call _fsprocess
lp:
	mov ah,0
    int 16h
    mov ah,13
    cmp ah,al
    jnz lp
	mov bp,offset adr
	jmp dword ptr [bp]
	
public _fork
_fork proc
	mov ah,8
   	int 21h
   	ret
_fork endp

public _wait
_wait proc
	mov ah,9
   	int 21h
   	ret
_wait endp

public _exit
_exit proc
	mov ah,10
   	int 21h
   	ret
_exit endp

public _printf 
_printf proc
	mov	ax, cs	       			; 置其他段寄存器值与CS相同
	mov	ds, ax	       			; 数据段
	mov	es, ax		 			; 置ES=DS
	mov bp,	offset _str1
	mov	cx, 49 		        	; CX = 串长
	mov	ax, 1300h		 		; AH = 13h（功能号）、AL = 00h（无光标）
	mov	bx, 0fh		 		    ; 页号为0(BH = 0) 黑底亮白字(BL = 0fh)
    mov dh, 10		       		; 行号
	mov	dl, 10			 		; 列号
	int	10h			 			; BIOS的10h功能：显示一行字符
	
	mov	ax, cs	       			; 置其他段寄存器值与CS相同
	mov	ds, ax	       			; 数据段
	mov	es, ax		 			; 置ES=DS
	mov bp,	offset _str2
	mov	cx, 48 		        	; CX = 串长
	mov	ax, 1300h		 		; AH = 13h（功能号）、AL = 00h（无光标）
	mov	bx, 0fh		 		    ; 页号为0(BH = 0) 黑底亮白字(BL = 0fh)
    mov dh, 11		       		; 行号
	mov	dl, 10			 		; 列号
	int	10h			 			; BIOS的10h功能：显示一行字符

	mov	ax, cs	       			; 置其他段寄存器值与CS相同
	mov	ds, ax	       			; 数据段
	mov	es, ax		 			; 置ES=DS
	mov bp,	offset _str3	
	mov	cx, 39 		        	; CX = 串长
	mov	ax, 1300h		 		; AH = 13h（功能号）、AL = 00h（无光标）
	mov	bx, 0fh		 		    ; 页号为0(BH = 0) 黑底亮白字(BL = 0fh)
    mov dh, 12		       		; 行号
	mov	dl, 10			 		; 列号
	int	10h			 			; BIOS的10h功能：显示一行字符
	
    mov	ax, cs	       			; 置其他段寄存器值与CS相同
	mov	ds, ax	       			; 数据段
	mov	es, ax		 			; 置ES=DS
	mov bx,	sp
	mov bp,	ss:[bx+2]
	mov	cx, 2  		        	; CX = 串长
	mov	ax, 1300h		 		; AH = 13h（功能号）、AL = 00h（无光标）
	mov	bx, 0fh		 		    ; 页号为0(BH = 0) 黑底亮白字(BL = 0fh)
    mov dh, 12		       		; 行号
	mov	dl, 49			 		; 列号
	int	10h			 			; BIOS的10h功能：显示一行字符
_printf endp

_TEXT ends
;************DATA segment*************
_DATA segment word public 'DATA'
_DATA ends
;*************BSS segment*************
_BSS	segment word public 'BSS'
_BSS ends
;**************end of file***********
end start