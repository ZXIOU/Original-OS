org  7c00h						; BIOS将把引导扇区加载到0:7C00h处，并开始执行
OffSetOfUserPrg1 equ 8100h

Start:
	mov     ax, 0600h
 	mov     bx, 0700h 
	mov     dx, 184fh 
	int     10h	
    mov ax,cs
	mov ds,ax					; DS = CS
	mov es,ax					; ES = CS
	mov	ax,0B800h				; 文本窗口显存起始地址
	mov	gs,ax					; GS = B800h
	mov bx,0
loop1:
	push bx						; 入栈保护 
	mov ax,word[row+bx]			; 计算显示行数 
	mov word[x],ax				 
	mov ax,word[col+bx]			; 计算显示列数
	mov word[y],ax
	mov cx,0	
show:
	push bx						; 入栈保护
	call delays					; 延时程序 
	call cal					; 计算显示位置 
	inc word[y]					; 右移显示字符串 
	mov ah,[color+bx]			; 0000：黑底、变换前景颜色
	mov	di,[image+bx]			; di=当前串的偏移地址 	
	mov bx,cx
	mov al,[di+bx]			    ; AL = 显示字符值（默认值为20h=空格符）
	mov word[gs:bp],ax  		; 显示字符的ASCII码值
	inc cx
	pop bx						; 出栈还原bx 
	mov ax,word[number+bx]
	cmp ax,cx   
	jz  loop2
	jmp show
loop2:
	pop bx						; 出栈还原bx
	inc bx
	inc bx
	mov ax,16					; 循环显示8次字符串结束 
	cmp ax,bx   
	jz  LoadnEx 				; 显示结束 
	jmp loop1					; 返回上一层	
	
LoadnEx:
     ;读软盘或硬盘上的若干物理扇区到内存的ES:BX处：
    mov ax,cs                	; 段地址 		; 存放数据的内存基地址
    mov es,ax                	; 设置段地址
    mov bx, OffSetOfUserPrg1  	; 偏移地址		; 存放数据的内存偏移地址
    mov ah,2                 	; 功能号
    mov al,1                 	; 扇区数
    mov dl,0                 	; 驱动器号 		; 软盘为0，硬盘和U盘为80H
    mov dh,0                 	; 磁头号        ; 起始编号为0
    mov ch,0                 	; 柱面号        ; 起始编号为0
    mov cl,2                 	; 起始扇区号    ; 起始编号为1
    int 13H 				 	; 调用读磁盘BIOS的13h功能
      ; 用户程序a.com已加载到指定内存区域中
    call delayss
    jmp OffSetOfUserPrg1
    jmp $                       ;无限循环

cal:
	push bx					    ; 计算显存地址
	xor ax,ax                 	
    mov ax,word[x]
	mov bx,80
	mul bx
	add ax,word[y]
	mov bx,2
	mul bx
	mov bp,ax
	pop bx
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
	mov cx,20
continue:
	call delays
	loop continue
	ret

delay equ 40000					; 计时器延迟计数,用于控制画框的速度
ddelay equ 500					; 计时器延迟计数,用于控制画框的速度
count dw delay
dcount dw ddelay
x dw 0
y dw 0
img1 db 3,'   ',3				; 显示的图形 
img2 db 3,3,3,' ',3,3,3
img3 db 3,3,3,3,3,3,3,3,3
img4 db 3,3,3,3,3,3,3
img5 db 3,3,3
img6 db 3
img7 db 'Welcome to Original OS that made by ZX.'	; 显示的提示语 
img8 db 'Please wait several secs,the OS is loading...'
number dw 5,7,9,7,3,1,39,45
image dw img1,img2,img3,img4,img5,img6,img7,img8
row dw 8,9,10,11,12,13,17,19
col dw 37,36,35,36,38,39,10,10
color dw 0ah,0eh,06h,0ch,0dh,0bh,0fh,0fh

	times 510-($-$$) db 0		; 补全引导扇区 
	db 0x55,0xaa

