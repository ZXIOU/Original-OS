Line_Up equ 1                   ;D-Down,U-Up
Line_Dn equ 2                   ;
delay equ 50000					; 计时器延迟计数,用于控制画框的速度
ddelay equ 580					; 计时器延迟计数,用于控制画框的速度

    org 07c00h					; 软盘启动程序加载到0000:07c00h才能正确执行
start:
    mov ax,cs
	mov ds,ax					; DS = CS
	mov es,ax					; ES = CS
	mov	ax,0B800h				; 文本窗口显存起始地址
	mov	gs,ax					; GS = B800h

loop1:
	call delays
    mov al,1
    cmp al,byte[flag]    
	jz  LiUp
    mov al,2
    cmp al,byte[flag]    
	jz  LiDn

LiDn:
	inc word[x]
	mov bx,word[x]
	mov ax,25
	sub ax,bx
	jz lp1
	jmp show

lp1:
	add word[y],10
	mov bx,word[y]
	mov ax,80
	sub ax,bx
	jz tar1
	mov byte[flag],Line_Up
	jmp show
	
LiUp:
	dec word[x]
	mov bx,word[x]
	mov ax,-1
	sub ax,bx
	jz lp2
	jmp show

lp2:
	add word[y],10
	mov byte[flag],Line_Dn
	jmp show

	
show:	
    call cal
	mov ah,byte[color]		    ;  0000：黑底、变换颜色背景 
	mov al,byte[char]			;  AL = 显示字符值（默认值为20h=空格符）
	mov word[gs:bp],ax  		;  显示字符的ASCII码值
	inc byte[color]
	jmp loop1

tar1:
	mov word[x],6
	mov word[y],5
	mov cx,0	
show2:
	mov al,8
    cmp al,cl   
	jz  tar2
	call delays
	call cal
	add word[y],10
	mov bx,cx
	mov ah,0fh				    ;  0000：黑底、1111：亮白字（默认值为07h） 
	mov al,byte[name+bx]		;  AL = 显示字符值（默认值为20h=空格符）
	mov word[gs:bp],ax  		;  显示字符的ASCII码值
	inc cx
	jmp show2

tar2:
	mov word[x],12
	mov word[y],5
	mov cx,0	
show3:
	mov al,8
    cmp al,cl   
	jz  tar3
	call delays
	call cal
	add word[y],10
	mov bx,cx
	mov ah,0fh				    ;  0000：黑底、1111：亮白字（默认值为07h） 
	mov al,byte[number+bx]		;  AL = 显示字符值（默认值为20h=空格符）
	mov word[gs:bp],ax  		;  显示字符的ASCII码值
	inc cx
	jmp show3

tar3:
	mov word[x],18
	mov word[y],25
	mov cx,0	
show4:
	mov al,4
    cmp al,cl   
	jz  tar3
	call delays
	call cal
	add word[y],10
	mov bx,cx
	mov ah,0fh				    ;  0000：黑底、1111：亮白字（默认值为07h） 
	mov al,byte[other+bx]		;  AL = 显示字符值（默认值为20h=空格符）
	mov word[gs:bp],ax  		;  显示字符的ASCII码值
	inc cx
	jmp show4
	
end:
    jmp $                   	; 停止画框，无限循环 


cal:							; 计算显存地址
	xor ax,ax                 	
    mov ax,word[x]
	mov bx,80
	mul bx
	add ax,word[y]
	mov bx,2
	mul bx
	mov bp,ax
	ret

delays:							;延时程序 
again:
	dec word[count]				; 递减计数变量
	jnz again					; >0,跳转;
	mov word[count],delay
	dec word[dcount]			; 递减计数变量
    jnz again					; >0,跳转;
	mov word[count],delay
	mov word[dcount],ddelay
	ret
	
datadef:						;定义变量 
	count dw delay
	dcount dw ddelay
    flag db LiDn            	; 最先向下运动
    color db 0
    x dw -1
	y dw 10
	name db 'Zhang Xu'
	number db '13349154'
	other db 'MADE' 
	char db 3
