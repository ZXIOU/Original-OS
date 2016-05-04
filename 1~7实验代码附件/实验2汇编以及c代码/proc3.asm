org  8700h						; BIOS将把引导扇区加载到0:8700h处，并开始执行

Start:
    mov	ax, cs	       			; 置其他段寄存器值与CS相同
	mov	ds, ax	       			; 数据段
	mov	es, ax		 			; 置ES=DS
	mov	bp, message1		 	; BP=当前串的偏移地址
	mov	cx, lengh1  		    ; CX = 串长
	mov	ax, 1301h		 		; AH = 13h（功能号）、AL = 01h（光标置于串尾）
	mov	bx, 0fh		 		    ; 页号为0(BH = 0) 黑底白字(BL = 07h)
	int	10h			 			; BIOS的10h功能：显示一行字符
	call delayss
	jmp 8180h 
	  
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
