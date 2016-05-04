org  8100h						; BIOS将把引导扇区加载到0:8100h处，并开始执行
Progream1 equ 8300h
Progream2 equ 8500h
Progream3 equ 8700h

Start:
	call clear
    mov	ax, cs	       			; 置其他段寄存器值与CS相同
	mov	ds, ax	       			; 数据段
	mov	es, ax		 			; 置ES=DS
	mov	bp, message1		 	; BP=当前串的偏移地址
	mov	cx, lengh1  		    ; CX = 串长
	mov	ax, 1301h		 		; AH = 13h（功能号）、AL = 01h（光标置于串尾）
	mov	bx, 0fh		 		    ; 页号为0(BH = 0) 黑底白字(BL = 07h)
    mov dh, 0		       		; 行号=0
	mov	dl, 0			 		; 列号=0
	int	10h			 			; BIOS的10h功能：显示一行字符
	
	mov ah,0					; 输入执行的程序数 
    int 16h
    mov byte[opernumber],al
    mov ah,0eh
    mov bx,opernumber
	mov al,[bx]
    int 10h 
	
	
	mov	ax, cs	       			; 置其他段寄存器值与CS相同
	mov	ds, ax	       			; 数据段
	mov	es, ax		 			; 置ES=DS
	mov	bp, message2		 	; BP=当前串的偏移地址
	mov	cx, lengh2  		    ; CX = 串长
	mov	ax, 1301h		 		; AH = 13h（功能号）、AL = 01h（光标置于串尾）
	mov	bx, 0fh		 		    ; 页号为0(BH = 0) 黑底白字(BL = 07h)
    mov dh, 1		       		; 行号=1
	mov	dl, 0			 		; 列号=0
	int	10h			 			; BIOS的10h功能：显示一行字符

	xor cx,cx
lp:								; 输入执行的次序 
	mov ah,0
    int 16h
    mov bx,cx
    mov [order+bx],al
    mov ah,0eh
	mov al,[order+bx]
    int 10h
    inc cx
    mov ax,[opernumber]
    sub ax,30h
    cmp ax,cx
    jnz lp

play:							; 开始执行程序 
	mov bx,[nowload]
	mov al,31h
	cmp al,[order+bx]
	jz proc1
	mov al,32h
	cmp al,[order+bx]
	jz proc2
	mov al,33h
	cmp al,[order+bx]
	jz proc3	
	inc word[nowload]
	mov ax,[opernumber]
	sub ax,30h
	cmp ax,[nowload]
	jnz play
		
end:							; 报告程序已经执行完 
	mov	ax, cs	       			; 置其他段寄存器值与CS相同
	mov	ds, ax	       			; 数据段
	mov	es, ax		 			; 置ES=DS
	mov	bp, message3		 	; BP=当前串的偏移地址
	mov	cx, lengh3  		    ; CX = 串长
	mov	ax, 1301h		 		; AH = 13h（功能号）、AL = 01h（光标置于串尾）
	mov	bx, 0fh		 		    ; 页号为0(BH = 0) 黑底白字(BL = 07h)
    mov di,[nowload]
    mov di,[nowload]
    add di,di
    mov dx,[rowcol+di]
	int	10h		
	jmp $ 
	
proc1:
     ;读软盘或硬盘上的若干物理扇区到内存的ES:BX处：
    mov ax,cs                	; 段地址 		; 存放数据的内存基地址
    mov es,ax                	; 设置段地址
    mov bx,Progream1			; 偏移地址		; 存放数据的内存偏移地址
    mov ah,2                 	; 功能号
    mov al,1                 	; 扇区数
    mov dl,0                 	; 驱动器号 		; 软盘为0，硬盘和U盘为80H
    mov dh,0                 	; 磁头号        ; 起始编号为0
    mov ch,0                 	; 柱面号        ; 起始编号为0
    mov cl,3                 	; 起始扇区号    ; 起始编号为1
    int 13H 				 	; 调用读磁盘BIOS的13h功能
    mov di,[nowload]
    mov di,[nowload]
    add di,di
    mov dx,[rowcol+di]
    jmp Progream1

proc2:
     ;读软盘或硬盘上的若干物理扇区到内存的ES:BX处：
    mov ax,cs                	; 段地址 		; 存放数据的内存基地址
    mov es,ax                	; 设置段地址
    mov bx,Progream2			; 偏移地址		; 存放数据的内存偏移地址
    mov ah,2                 	; 功能号
    mov al,1                 	; 扇区数
    mov dl,0                 	; 驱动器号 		; 软盘为0，硬盘和U盘为80H
    mov dh,0                 	; 磁头号        ; 起始编号为0
    mov ch,0                 	; 柱面号        ; 起始编号为0
    mov cl,4                	; 起始扇区号    ; 起始编号为1
    int 13H 				 	; 调用读磁盘BIOS的13h功能
    mov di,[nowload]
    mov di,[nowload]
    add di,di
    mov dx,[rowcol+di]
    jmp Progream2
    
proc3:
     ;读软盘或硬盘上的若干物理扇区到内存的ES:BX处：
    mov ax,cs                	; 段地址 		; 存放数据的内存基地址
    mov es,ax                	; 设置段地址
    mov bx,Progream3			; 偏移地址		; 存放数据的内存偏移地址
    mov ah,2                 	; 功能号
    mov al,1                 	; 扇区数
    mov dl,0                 	; 驱动器号 		; 软盘为0，硬盘和U盘为80H
    mov dh,0                 	; 磁头号        ; 起始编号为0
    mov ch,0                 	; 柱面号        ; 起始编号为0
    mov cl,5                 	; 起始扇区号    ; 起始编号为1
    int 13H 				 	; 调用读磁盘BIOS的13h功能
    mov di,[nowload]
    add di,di
    mov dx,[rowcol+di]
    jmp Progream3

 
	
clear:							; 清屏
	mov     ax, 0600h			 
 	mov     bx, 0700h 
 	mov     cx, 0h
	mov     dx, 184fh 
	int     10h
	ret
	  
delays:							; 延时程序 
again:
	dec word[count]				; 递减计数变量
	jnz again					; >0,跳转;
	mov word[count],delay
	dec word[dcount]			; 递减计数变量
    jnz again					; >0,跳转;
	mov word[count],delay
	mov word[dcount],ddelay
	ret

delayss:						; 长时间延时程序 
	mov cx,100
continue:
	call delays
	loop continue
	ret

delay equ 50000					; 计时器延迟计数,用于控制画框的速度
ddelay equ 580					; 计时器延迟计数,用于控制画框的速度
count dw delay
dcount dw ddelay

message1 db 'Now tell me the number of progreams that you want to execute: '	; 显示的提示语 
lengh1 equ ($-message1)
message2 db 'Please decide the order: '
lengh2 equ ($-message2)
message3 db 'All procedures have been run to completion!'
lengh3 equ ($-message3)
order db 0,0,0
opernumber dw 0 
nowload dw 0
rowcol dw 0400h,0500h,0600h,0700h
