org  7c00h						; BIOS���������������ص�0:7C00h��������ʼִ��
OffSetOfUserPrg1 equ 8100h

Start:
	mov     ax, 0600h
 	mov     bx, 0700h 
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
	mov ax,word[col+bx]			; ������ʾ����
	mov word[y],ax
	mov cx,0	
show:
	push bx						; ��ջ����
	call delays					; ��ʱ���� 
	call cal					; ������ʾλ�� 
	inc word[y]					; ������ʾ�ַ��� 
	mov ah,[color+bx]			; 0000���ڵס��任ǰ����ɫ
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
	mov ax,16					; ѭ����ʾ8���ַ������� 
	cmp ax,bx   
	jz  LoadnEx 				; ��ʾ���� 
	jmp loop1					; ������һ��	
	
LoadnEx:
     ;�����̻�Ӳ���ϵ����������������ڴ��ES:BX����
    mov ax,cs                	; �ε�ַ 		; ������ݵ��ڴ����ַ
    mov es,ax                	; ���öε�ַ
    mov bx, OffSetOfUserPrg1  	; ƫ�Ƶ�ַ		; ������ݵ��ڴ�ƫ�Ƶ�ַ
    mov ah,2                 	; ���ܺ�
    mov al,1                 	; ������
    mov dl,0                 	; �������� 		; ����Ϊ0��Ӳ�̺�U��Ϊ80H
    mov dh,0                 	; ��ͷ��        ; ��ʼ���Ϊ0
    mov ch,0                 	; �����        ; ��ʼ���Ϊ0
    mov cl,2                 	; ��ʼ������    ; ��ʼ���Ϊ1
    int 13H 				 	; ���ö�����BIOS��13h����
      ; �û�����a.com�Ѽ��ص�ָ���ڴ�������
    call delayss
    jmp OffSetOfUserPrg1
    jmp $                       ;����ѭ��

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
   
delays:							; ��ʱ���� 
again:
	dec word[count]				; �ݼ���������
	jnz again					; >0,��ת;
	mov word[count],delay
	dec word[dcount]			; �ݼ���������
    jnz again					; >0,��ת;
	mov word[count],delay
	mov word[dcount],ddelay
	ret

delayss:						; ��ʱ����ʱ���� 
	mov cx,20
continue:
	call delays
	loop continue
	ret

delay equ 40000					; ��ʱ���ӳټ���,���ڿ��ƻ�����ٶ�
ddelay equ 500					; ��ʱ���ӳټ���,���ڿ��ƻ�����ٶ�
count dw delay
dcount dw ddelay
x dw 0
y dw 0
img1 db 3,'   ',3				; ��ʾ��ͼ�� 
img2 db 3,3,3,' ',3,3,3
img3 db 3,3,3,3,3,3,3,3,3
img4 db 3,3,3,3,3,3,3
img5 db 3,3,3
img6 db 3
img7 db 'Welcome to Original OS that made by ZX.'	; ��ʾ����ʾ�� 
img8 db 'Please wait several secs,the OS is loading...'
number dw 5,7,9,7,3,1,39,45
image dw img1,img2,img3,img4,img5,img6,img7,img8
row dw 8,9,10,11,12,13,17,19
col dw 37,36,35,36,38,39,10,10
color dw 0ah,0eh,06h,0ch,0dh,0bh,0fh,0fh

	times 510-($-$$) db 0		; ��ȫ�������� 
	db 0x55,0xaa

