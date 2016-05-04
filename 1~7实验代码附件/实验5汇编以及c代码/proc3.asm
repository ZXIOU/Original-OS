org  9400h						; BIOS将把引导扇区加载到0:8900h处，并开始执行

Start:
	mov     ax, 0600h
 	mov     bx, 0700h 
 	mov     cx, 0h
	mov     dx, 184fh 
	int     10h	
    mov	ax, cs	       			; 置其他段寄存器值与CS相同
	mov	ds, ax	       			; 数据段
	mov	es, ax		 			; 置ES=DS
	mov	bp, message1		 	; BP=当前串的偏移地址
	mov	cx, lengh1  		    ; CX = 串长
	mov	ax, 1300h		 		; AH = 13h（功能号）、AL = 00h（无光标）
	mov	bx, 0fh		 		    ; 页号为0(BH = 0) 黑底亮白字(BL = 0fh)
	mov dh, 0		       		; 行号=0
	mov	dl, 0			 		; 列号=0
	int	10h			 			; BIOS的10h功能：显示一行字符
	call delayss
	mov	ax, cs	       			; 置其他段寄存器值与CS相同
	mov	ds, ax	       			; 数据段
	mov	es, ax		 			; 置ES=DS
	mov	bp, message2		 	; BP=当前串的偏移地址
	mov	cx, lengh2  		    ; CX = 串长
	mov	ax, 1300h		 		; AH = 13h（功能号）、AL = 00h（无光标）
	mov	bx, 0fh		 		    ; 页号为0(BH = 0) 黑底亮白字(BL = 0fh)
	mov dh, 2		       		; 行号=0
	mov	dl, 0			 		; 列号=0
	int	10h			 			; BIOS的10h功能：显示一行字符
	mov	ax, cs	       			; 置其他段寄存器值与CS相同
	mov	ds, ax	       			; 数据段
	mov	es, ax		 			; 置ES=DS
	mov	bp, message3		 	; BP=当前串的偏移地址
	mov	cx, lengh3  		    ; CX = 串长
	mov	ax, 1300h		 		; AH = 13h（功能号）、AL = 00h（无光标）
	mov	bx, 0fh		 		    ; 页号为0(BH = 0) 黑底亮白字(BL = 0fh)
	mov dh, 3		       		; 行号=0
	mov	dl, 0			 		; 列号=0
	int	10h			 			; BIOS的10h功能：显示一行字符
lp:
	mov ah,0
    int 16h
    mov ah,13
    cmp ah,al
    jnz lp
	jmp 8400h 
	  
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
	mov cx,15
continue:
	call delays
	loop continue
	ret

delay equ 50000					; 计时器延迟计数,用于控制画框的速度
ddelay equ 580					; 计时器延迟计数,用于控制画框的速度
count dw delay
dcount dw ddelay

message1 db 'The third program is executing...'	; 显示的提示语 
lengh1 equ ($-message1)
message2 db 'The third program has been finished!'	; 显示的提示语 
lengh2 equ ($-message2)
message3 db 'You can press the Enter key to return.'	; 显示的提示语 
lengh3 equ ($-message3)