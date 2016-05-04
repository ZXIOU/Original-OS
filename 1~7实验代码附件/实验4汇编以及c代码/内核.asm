extrn _Judge:near               ;声明一个c程序函数
extrn _ClearOrder:near          ;声明一个c程序函数
extrn _Main:near           		;声明一个c程序函数
extrn _Message1:near      		;声明一个外部变量	
extrn _Message2:near      		;声明一个外部变量	
extrn _Message3:near      		;声明一个外部变量
extrn _Message4:near      		;声明一个外部变量	
extrn _Message5:near      		;声明一个外部变量
extrn _Message6:near      		;声明一个外部变量
extrn _order:near      		    ;声明一个外部变量
Restart equ 7c00h
Progream1 equ 8500h				
Progream2 equ 8700h
Progream3 equ 8900h
Time equ 8b00h
Help equ 8d00h

.8086
_TEXT segment byte public 'CODE'
DGROUP group _TEXT,_DATA,_BSS
assume cs:_TEXT
org 8100h

start:
	mov  ax,  cs
	mov  ds,  ax                ; DS = CS
	mov  es,  ax                ; ES = CS
	call _Main
	jmp $

public _str
_str proc
    mov	ax, cs	       			; 置其他段寄存器值与CS相同
	mov	ds, ax	       			; 数据段
	mov	es, ax		 			; 置ES=DS
	mov	bp, offset _Message1	; BP=当前串的偏移地址
	mov	cx, 15  		        ; CX = 串长
	mov	ax, 1300h		 		; AH = 13h（功能号）、AL = 00h（无光标）
	mov	bx, 0fh		 		    ; 页号为0(BH = 0) 黑底亮白字(BL = 0fh)
    mov dh, 0		       		; 行号
	mov	dl, 0			 		; 列号
	int	10h			 			; BIOS的10h功能：显示一行字符
		
	mov	ax, cs	       			; 置其他段寄存器值与CS相同
	mov	ds, ax	       			; 数据段
	mov	es, ax		 			; 置ES=DS
	mov	bp, offset _Message2	; BP=当前串的偏移地址
	mov	cx, 24  		        ; CX = 串长
	mov	ax, 1300h		 		; AH = 13h（功能号）、AL = 00h（无光标）
	mov	bx, 0fh		 		    ; 页号为0(BH = 0) 黑底亮白字(BL = 0fh)
    mov dh, 1		       		; 行号
	mov	dl, 0			 		; 列号
	int	10h			 			; BIOS的10h功能：显示一行字符
	ret
_str endp


public _line
_line proc
	mov si,offset nowrow
	mov ah,[si]
	mov al,25
	cmp al,ah
	jnz next
	call clear2
next:
	mov	ax, cs	       			; 置其他段寄存器值与CS相同
	mov	ds, ax	       			; 数据段
	mov	es, ax		 			; 置ES=DS
	mov	bp, offset _Message3	; BP=当前串的偏移地址
	mov	bx, 0fh		 		    ; 页号为0(BH = 0) 黑底亮白字(BL = 0fh)
	mov	cx, 12  		        ; CX = 串长
	mov	ax, 1301h		 		; AH = 13h（功能号）、AL = 00h（无光标）
	mov dh,[si] 		       	; 行号
	mov	dl, 0			 		; 列号
	int	10h			 			; BIOS的10h功能：显示一行字符
	inc dh
	mov [si],dh
	ret
_line endp

public _proc1
_proc1 proc
     ;读软盘或硬盘上的若干物理扇区到内存的ES:BX处：
    mov ax,cs                	; 段地址 		; 存放数据的内存基地址
    mov es,ax                	; 设置段地址
    mov bx,8500h			    ; 偏移地址		; 存放数据的内存偏移地址
    mov ah,2                 	; 功能号
    mov al,1                 	; 扇区数
    mov dl,0                 	; 驱动器号 		; 软盘为0，硬盘和U盘为80H
    mov dh,0                 	; 磁头号        ; 起始编号为0
    mov ch,0                 	; 柱面号        ; 起始编号为0
    mov cl,4                 	; 起始扇区号    ; 起始编号为1
    int 13H 				 	; 调用读磁盘BIOS的13h功能
    mov si,offset nowrow
    mov al,3
	mov [si],al 
    mov ax,Progream1
    jmp ax
    ret
_proc1 endp

public _proc2
_proc2 proc
     ;读软盘或硬盘上的若干物理扇区到内存的ES:BX处：
    mov ax,cs                	; 段地址 		; 存放数据的内存基地址
    mov es,ax                	; 设置段地址
    mov bx,8700h			    ; 偏移地址		; 存放数据的内存偏移地址
    mov ah,2                 	; 功能号
    mov al,1                 	; 扇区数
    mov dl,0                 	; 驱动器号 		; 软盘为0，硬盘和U盘为80H
    mov dh,0                 	; 磁头号        ; 起始编号为0
    mov ch,0                 	; 柱面号        ; 起始编号为0
    mov cl,5                	; 起始扇区号    ; 起始编号为1
    int 13H 				 	; 调用读磁盘BIOS的13h功能
    mov si,offset nowrow
    mov al,3
	mov [si],al 
    mov ax,Progream2
    jmp ax
    ret
_proc2 endp   
    
public _proc3
_proc3 proc
     ;读软盘或硬盘上的若干物理扇区到内存的ES:BX处：
    mov ax,cs                	; 段地址 		; 存放数据的内存基地址
    mov es,ax                	; 设置段地址
    mov bx,8900h			    ; 偏移地址		; 存放数据的内存偏移地址
    mov ah,2                 	; 功能号
    mov al,1                 	; 扇区数
    mov dl,0                 	; 驱动器号 		; 软盘为0，硬盘和U盘为80H
    mov dh,0                 	; 磁头号        ; 起始编号为0
    mov ch,0                 	; 柱面号        ; 起始编号为0
    mov cl,6                 	; 起始扇区号    ; 起始编号为1
    int 13H 				 	; 调用读磁盘BIOS的13h功能
    mov si,offset nowrow
    mov al,3
	mov [si],al 
    mov ax,Progream3
    jmp ax
    ret
_proc3 endp

public _restart
_restart proc
	mov ax,Restart
    jmp ax
_restart endp

public _shutdown
_shutdown proc
	call _clear1
	mov	ax, cs	       			; 置其他段寄存器值与CS相同
	mov	ds, ax	       			; 数据段
	mov	es, ax		 			; 置ES=DS
	mov	bp, offset _Message6    ; BP=当前串的偏移地址
	mov	cx, 24  		        ; CX = 串长
	mov	ax, 1300h		 		; AH = 13h（功能号）、AL = 00h（无光标）
	mov	bx, 0fh		 		    ; 页号为0(BH = 0) 黑底亮白字(BL = 0fh)
    mov dh, 12		       		; 行号
	mov	dl, 30			 		; 列号
	int	10h			 			; BIOS的10h功能：显示一行字符
	call delayss	
	call _clear1
close: 
	mov ah,0h
	int 16h
    jmp close 
_shutdown endp

public _time
_time proc
	;读软盘或硬盘上的若干物理扇区到内存的ES:BX处：
    mov ax,cs                	; 段地址 		; 存放数据的内存基地址
    mov es,ax                	; 设置段地址
    mov bx,8b00h			    ; 偏移地址		; 存放数据的内存偏移地址
    mov ah,2                 	; 功能号
    mov al,1                 	; 扇区数
    mov dl,0                 	; 驱动器号 		; 软盘为0，硬盘和U盘为80H
    mov dh,0                 	; 磁头号        ; 起始编号为0
    mov ch,0                 	; 柱面号        ; 起始编号为0
    mov cl,7                 	; 起始扇区号    ; 起始编号为1
    int 13H 				 	; 调用读磁盘BIOS的13h功能
    mov si,offset nowrow
    mov al,3
	mov [si],al 
    mov ax,Time
    jmp ax
    ret
_time endp

public _help
_help proc
	;读软盘或硬盘上的若干物理扇区到内存的ES:BX处：
    mov ax,cs                	; 段地址 		; 存放数据的内存基地址
    mov es,ax                	; 设置段地址
    mov bx,8d00h			    ; 偏移地址		; 存放数据的内存偏移地址
    mov ah,2                 	; 功能号
    mov al,1                 	; 扇区数
    mov dl,0                 	; 驱动器号 		; 软盘为0，硬盘和U盘为80H
    mov dh,0                 	; 磁头号        ; 起始编号为0
    mov ch,0                 	; 柱面号        ; 起始编号为0
    mov cl,8                 	; 起始扇区号    ; 起始编号为1
    int 13H 				 	; 调用读磁盘BIOS的13h功能
    mov si,offset nowrow
    mov al,3
	mov [si],al
    mov ax,Help
    jmp ax
    ret
_help endp

public _in
_in proc
lp:
	call _line
	call _ClearOrder
	xor bx,bx
	xor cx,cx
	mov si,offset _order
lp1:
	inc cl
	mov al,32
	cmp al,cl
	jnz	lp2
	call error2 
	jmp lp
lp2:
	mov ah,0
    int 16h
    mov [si+bx],al
    mov ah,0eh
	mov al,[si+bx]
    int 10h
    add bx,1
    mov ah,0dh
    cmp ah,al
    jnz lp1
	call _judge
	call error1
	jmp lp 
	ret 
_in endp

error1 proc
	mov si,offset nowrow
    mov	ax, cs	       				; 置其他段寄存器值与CS相同
	mov	ds, ax	       				; 数据段
	mov	es, ax		 				; 置ES=DS
	mov	bp, offset _Message4    	; BP=当前串的偏移地址
	mov	bx, 0fh		 		    	; 页号为0(BH = 0) 黑底亮白字(BL = 0fh)
	mov	cx, 18  		        	; CX = 串长
	mov	ax, 1300h		 			; AH = 13h（功能号）、AL = 00h（无光标）		
    mov dh,[si] 		       		; 行号
	mov	dl, 0			 			; 列号
	int	10h			 				; BIOS的10h功能：显示一行字符
	;inc byte[si]
	mov al,24
	cmp al,dh
	jnz lp4
	call delays
lp4:
	inc dh
	mov [si],dh
	;call _in
	ret
error1 endp

error2 proc
	mov si,offset nowrow
    mov	ax, cs	       				; 置其他段寄存器值与CS相同
	mov	ds, ax	       				; 数据段
	mov	es, ax		 				; 置ES=DS
	mov	bp, offset _Message5    	; BP=当前串的偏移地址
	mov	bx, 0fh		 		    	; 页号为0(BH = 0) 黑底亮白字(BL = 0fh)
	mov	cx, 24  		        	; CX = 串长
	mov	ax, 1300h		 			; AH = 13h（功能号）、AL = 00h（无光标）		
    mov dh,[si] 		       		; 行号
	mov	dl, 0			 			; 列号
	int	10h			 				; BIOS的10h功能：显示一行字符
	mov al,24
	cmp al,dh
	jnz lp5
	call delays
lp5:
	;inc byte[si]
	inc dh
	mov [si],dh
	ret
error2 endp

public _clear1
_clear1 proc						; 清屏
	mov     ax, 0600h			 
 	mov     bx, 0700h 
 	mov     cx, 0h
	mov     dx, 184fh 
	int     10h
	ret
_clear1 endp


clear2 proc							; 清屏 
	mov     ax, 0600h			 
 	mov     bx, 0700h 
 	mov     cx, 0300h
	mov     dx, 184fh 
	int     10h
	mov si,offset nowrow
	mov cl,3
	mov [si],cl
	ret	
clear2 endp

delays 	proc						; 延时程序 
again:
	mov di,offset count
	mov cx,[di]
	dec cx				        	; 递减计数变量
	mov [di],cx
	jnz again						; >0,跳转;
	mov di,offset count
	mov [di],delay
	mov di,offset dcount
	mov cx,[di]
	dec cx				        	; 递减计数变量
	mov [di],cx
    jnz again						; >0,跳转;
    mov di,offset count
	mov [di],delay
	mov di,offset dcount
	mov [di],ddelay
	ret
delays endp

delayss proc						; 长时间延时程序 
	mov cx,10
continue:
	push cx
	call delays
	pop cx
	loop continue
	ret
delayss endp

delay equ 50000					    ; 计时器延迟计数
ddelay equ 580					    ; 计时器延迟计数
count dw delay
dcount dw ddelay
nowrow db 3

_TEXT ends
;************DATA segment*************
_DATA segment word public 'DATA'
_DATA ends
;*************BSS segment*************
_BSS	segment word public 'BSS'
_BSS ends
;**************end of file***********
end start