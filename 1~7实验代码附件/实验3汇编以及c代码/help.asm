org  8d00h						; BIOS���������������ص�0:8d00h��������ʼִ��

Start:
	mov     ax, 0600h
 	mov     bx, 0700h 
 	mov     cx, 0h
	mov     dx, 184fh 
	int     10h	
    mov ax,cs
	mov ds,ax					; DS = CS
	mov es,ax					; ES = CS
	mov	ax,0B800h				; �ı������Դ���ʼ��ַ
	mov	gs,ax					; GS = B800h
	mov bx,0
loop1:
	push bx						; ��ջ���� 
	mov ax,word[row+bx]			; ������ʾ���� 
	mov word[x],ax				 
	mov word[y],0
	mov cx,0	
show:
	push bx						; ��ջ����
	call cal					; ������ʾλ�� 
	inc word[y]					; ������ʾ�ַ��� 
	mov ah,0fh					; 0000���ڵס�1111:����ɫ 
	mov	di,[image+bx]			; di=��ǰ����ƫ�Ƶ�ַ 	
	mov bx,cx
	mov al,[di+bx]			    ; AL = ��ʾ�ַ�ֵ��Ĭ��ֵΪ20h=�ո����
	mov word[gs:bp],ax  		; ��ʾ�ַ���ASCII��ֵ
	inc cx
	pop bx						; ��ջ��ԭbx 
	mov ax,word[number+bx]
	cmp ax,cx   
	jz  loop2
	jmp show
loop2:
	pop bx						; ��ջ��ԭbx
	inc bx
	inc bx
	mov ax,18					; ѭ����ʾ9���ַ������� 
	cmp ax,bx   
	jz  lp 				        ; ��ʾ���� 
	jmp loop1					; ������һ��
		
lp:
	mov ah,0
    int 16h
    mov ah,13
    cmp ah,al
    jnz lp
    jmp 8100h

cal:
	push bx					    ; �����Դ��ַ
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
	
x dw 0
y dw 0
img1 db 'These are the available commands:' 
img2 db '-help         show you all the commands'
img3 db '-restart      restart the OS'
img4 db '-shutdown     shutdown the OS'
img5 db '-time         show you the real time'
img6 db '-run proc1    run the prgream1'
img7 db '-run proc2    run the prgream2'
img8 db '-run proc3    run the prgream3'
img9 db 'You can press the Enter key to return.'
row dw 0,3,4,5,6,7,8,9,11	         
number dw 33,39,28,29,36,30,30,30,38
image dw img1,img2,img3,img4,img5,img6,img7,img8,img9