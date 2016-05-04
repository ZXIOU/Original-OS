org  7e00h							; BIOS将把引导扇区加载到0:8b00h处，并开始执行
	
start:	
	xor ax,ax						; AX = 0
	mov es,ax						; ES = 0
	mov si,[es:24h]
	mov word [es:0dch],si
	mov di,[es:26h]
	mov word [es:0deh],di
	mov word [es:20h],Timer			; 设置时钟中断向量的偏移地址
	mov word [es:24h],Key			; 设置时钟中断向量的偏移地址
	mov word [es:0cch],Int33		; 设置时钟中断向量的偏移地址
	mov word [es:0d0h],Int34		; 设置时钟中断向量的偏移地址
	mov word [es:0d4h],Int35		; 设置时钟中断向量的偏移地址
	mov word [es:0d8h],Int36		; 设置时钟中断向量的偏移地址
	mov ax,cs 
	mov word [es:22h],ax			; 设置时钟中断向量的段地址=CS
	mov word [es:26h],ax			; 设置时钟中断向量的段地址=CS
	mov word [es:0ceh],ax			; 设置时钟中断向量的段地址=CS
	mov word [es:0d2h],ax			; 设置时钟中断向量的段地址=CS
	mov word [es:0d6h],ax			; 设置时钟中断向量的段地址=CS
	mov word [es:0dah],ax			; 设置时钟中断向量的段地址=CS
	mov word [mark],ax				; 设置时钟中断向量的段地址=CS
	mov ds,ax			
	mov es,ax                		; 设置段地址
    mov bx,8400h			    	; 偏移地址		; 存放数据的内存偏移地址
    mov ah,2                 		; 功能号
    mov al,6                 		; 扇区数
    mov dl,0                 		; 驱动器号 		; 软盘为0，硬盘和U盘为80H
    mov dh,0                 		; 磁头号        ; 起始编号为0
    mov ch,0                 		; 柱面号        ; 起始编号为0
    mov cl,5                 		; 起始扇区号    ; 起始编号为1
    int 13H 				 		; 调用读磁盘BIOS的13h功能
    jmp 8400h

color dw 0ah,0eh,06h,0ch,0dh,0bh
count dw 0
mark dw 0

Timer:	
	pusha
	push ds
	push es							
	mov ah,04h
	int 1Ah
	mov al,cl
	call bcd_to_ascii
	mov [message1],ah
	mov [message1+1],al
	mov byte[message1+2],'/'
	mov al,dh
	call bcd_to_ascii
	mov [message1+3],ah
	mov [message1+4],al
	mov byte[message1+5],'/'
	mov al,dl
	call bcd_to_ascii
	mov [message1+6],ah
	mov [message1+7],al
	
	mov ah,02h
	int 1Ah
	mov al,ch
	call bcd_to_ascii
	mov [message1+9],ah
	mov [message1+10],al
	mov byte[message1+11],':'
	mov al,cl
	call bcd_to_ascii
	mov [message1+12],ah
	mov [message1+13],al
	mov byte[message1+14],':'
	mov al,dh
	call bcd_to_ascii
	mov [message1+15],ah
	mov [message1+16],al
	
	mov	ax, ds	       		; 数据段
	mov	es, ax		 		; 置ES=DS
	mov	bp, message1 		; BP=当前串的偏移地址
	mov	cx, lengh1         	; CX = 串长
	mov	ax, 1300h	 		; AH = 13h（功能号）、AL = 00h（无光标）
	mov	bx, 000fh			; 页号为0(BH = 0) 黑底亮白字(BL = 0fh)
	mov dh, 24				; 行号
	mov	dl, 62			    ; 列号
	int	10h					; BIOS的10h功能：显示一行字符
	
	mov al,20h				; AL = EOI
	out 20h,al				; 发送EOI到主8529A
	out 0A0h,al				; 发送EOI到从8529A
	pop es
	pop ds
	popa
	iret

Key:
	pusha
	push ds
	push es
	sti
	int 37h  
	
	mov ax,word[mark]
	mov	ds,ax	       				; 数据段
	mov	es, ax		 				; 置ES=DS
	mov	bp, message2 				; BP=当前串的偏移地址
	mov	cx, lengh2         			; CX = 串长
	mov	ax, 1300h	 				; AH = 13h（功能号）、AL = 00h（无光标）
	mov si, [count]
	mov	bx, [color+si]				; 页号为0(BH = 0) 黑底亮白字(BL = 0fh)
	inc byte[count]
	inc byte[count]
	mov dl,byte[count]
	cmp dl,0ch
	jnz hehe
	mov word[count],0
hehe:
	mov dh, 23					; 行号
	mov	dl, 62			    	; 列号
	int	10h	
	
	mov al,20h					; AL = EOI
	out 20h,al					; 发送EOI到主8529A
	out 0A0h,al					; 发送EOI到从8529A
	pop es
	pop ds
	popa
	iret

Int33:
	pusha
	push ds
	push es
	mov ax,word[mark]
	mov	ds,ax	       				
	mov	es, ax		 				
	mov	bp, message3 				; BP=当前串的偏移地址
	mov	cx, lengh3         			; CX = 串长
	mov	ax, 1300h	 				; AH = 13h（功能号）、AL = 00h（无光标）
	mov	bx, 000fh					; 页号为0(BH = 0) 黑底亮白字(BL = 0fh)
	mov dh, 6						; 行号
	mov	dl, 19			    		; 列号
	int	10h							; BIOS的10h功能：显示一行字符
	pop es
	pop ds
	popa
	iret

Int34:
	pusha
	push ds
	push es
	mov ax,word[mark]
	mov	ds,ax	       				
	mov	es, ax		 				
	mov	bp, message4 				; BP=当前串的偏移地址
	mov	cx, lengh4         			; CX = 串长
	mov	ax, 1300h	 				; AH = 13h（功能号）、AL = 00h（无光标）
	mov	bx, 000fh					; 页号为0(BH = 0) 黑底亮白字(BL = 0fh)
	mov dh, 6						; 行号
	mov	dl, 55			    		; 列号
	int	10h							; BIOS的10h功能：显示一行字符
	pop es
	pop ds
	popa
	iret

Int35:
	pusha
	push ds
	push es
	mov ax,word[mark]
	mov	ds,ax	       				
	mov	es, ax		 				
	mov	bp, message5 				; BP=当前串的偏移地址
	mov	cx, lengh5         			; CX = 串长
	mov	ax, 1300h	 				; AH = 13h（功能号）、AL = 00h（无光标）
	mov	bx, 000fh					; 页号为0(BH = 0) 黑底亮白字(BL = 0fh)
	mov dh, 18						; 行号
	mov	dl, 19			    		; 列号
	int	10h							; BIOS的10h功能：显示一行字符
	pop es
	pop ds
	popa
	iret

Int36:
	pusha
	push ds
	push es
	mov ax,word[mark]
	mov	ds,ax	       				
	mov	es, ax		 				
	mov	bp, message6 				; BP=当前串的偏移地址
	mov	cx, lengh6         			; CX = 串长
	mov	ax, 1300h	 				; AH = 13h（功能号）、AL = 00h（无光标）
	mov	bx, 000fh					; 页号为0(BH = 0) 黑底亮白字(BL = 0fh)
	mov dh, 18						; 行号
	mov	dl, 55			    		; 列号
	int	10h							; BIOS的10h功能：显示一行字符
	pop es
	pop ds
	popa
	iret
	
bcd_to_ascii:                       ;BCD码转ASCII
                                    ;输入：AL=bcd码
                                    ;输出：AX=ascii
    mov ah,al                       ;分拆成两个数字 
    and al,0x0f                     ;仅保留低4位 
    add al,0x30                     ;转换成ASCII 

    shr ah,4                        ;逻辑右移4位 
    and ah,0x0f                        
    add ah,0x30
	ret	
	
message1 db 0,0,'/',0,0,'/',0,0,' ',0,0,':',0,0,':',0,0
lengh1 equ ($-message1)
message2 db 'OUCH! OUCH!'
lengh2 equ ($-message2)
message3 db 1,'Int 33',1
lengh3 equ ($-message3)
message4 db 1,'Int 34',1
lengh4 equ ($-message4)
message5 db 1,'Int 35',1
lengh5 equ ($-message5)
message6 db 1,'Int 36',1
lengh6 equ ($-message6)