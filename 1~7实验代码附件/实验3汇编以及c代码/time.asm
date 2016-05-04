org  8b00h						; BIOS将把引导扇区加载到0:8b00h处，并开始执行
	
start:
	mov ax, 0600h			 
 	mov bx, 0700h 
 	mov cx, 0h
	mov dx, 184fh 
	int 10h
	    
	mov	ax, cs	       			; 置其他段寄存器值与CS相同
	mov	ds, ax	       			; 数据段
	mov	es, ax		 			; 置ES=DS
	mov	bp, message1		 	; BP=当前串的偏移地址
	mov	cx, lengh1  		    ; CX = 串长
	mov	ax, 1300h		 		; AH = 13h（功能号）、AL = 00h（无光标）
	mov	bx, 0fh		 		    ; 页号为0(BH = 0) 黑底亮白字(BL = 0fh)
	mov dh, 14		       		; 行号=0
	mov	dl, 24			 		; 列号=0
	int	10h			 			; BIOS的10h功能：显示一行字符
lp:
    mov ax,cs
	mov ds,ax					; DS = CS
	mov es,ax					; ES = CS
	mov ah,04h
	int 1Ah
	mov al,cl
	call bcd_to_ascii
	mov [message],ah
	mov [message+1],al
	mov al,dh
	call bcd_to_ascii
	mov [message+3],ah
	mov [message+4],al
	mov al,dl
	call bcd_to_ascii
	mov [message+6],ah
	mov [message+7],al
	
	mov ah,02h
	int 1Ah
	mov al,ch
	call bcd_to_ascii
	mov [message+9],ah
	mov [message+10],al
	mov al,cl
	call bcd_to_ascii
	mov [message+12],ah
	mov [message+13],al
	mov al,dh
	call bcd_to_ascii
	mov [message+15],ah
	mov [message+16],al
	
	mov	ax, ds			    ; ES:BP = 串地址
	mov	es, ax			    ; 置ES=DS 
	mov	bp,message 			; BP=当前串的偏移地址
	mov	cx,lengh         	; CX = 串长（=10）
	mov	ax, 1300h	 		; AH = 13h（功能号）、AL = 00h（无光标）
	mov	bx, 0fh			    ; 页号为0(BH = 0) 黑底亮白字(BL = 0fh)
	mov dh, 12				; 行号=12
	mov	dl, 31			    ; 列号=31
	int	10h					; BIOS的10h功能：显示一行字符
	call delays
	mov ah,01h
	int 16h
	jz lp
	mov ah,00h
	int 16h
	jmp 8100h
	
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
	
delays:								; 延时程序 
again:
	dec word[count]					; 递减计数变量
	jnz again						; >0,跳转;
	mov word[count],delay
	dec word[dcount]				; 递减计数变量
    jnz again						; >0,跳转;
	mov word[count],delay
	mov word[dcount],ddelay
	ret

delay equ 4000						; 计时器延迟计数
ddelay equ 500						; 计时器延迟计数
count dw delay
dcount dw ddelay	
message db 0,0,'/',0,0,'/',0,0,' ',0,0,':',0,0,':',0,0
lengh equ ($-message)
message1 db 'You can press any key to return.'	; 显示的提示语 
lengh1 equ ($-message1)
	
