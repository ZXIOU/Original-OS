org  8100h						; BIOS���������������ص�0:8100h��������ʼִ��
Progream1 equ 8300h
Progream2 equ 8500h
Progream3 equ 8700h

Start:
	call clear
    mov	ax, cs	       			; �������μĴ���ֵ��CS��ͬ
	mov	ds, ax	       			; ���ݶ�
	mov	es, ax		 			; ��ES=DS
	mov	bp, message1		 	; BP=��ǰ����ƫ�Ƶ�ַ
	mov	cx, lengh1  		    ; CX = ����
	mov	ax, 1301h		 		; AH = 13h�����ܺţ���AL = 01h��������ڴ�β��
	mov	bx, 0fh		 		    ; ҳ��Ϊ0(BH = 0) �ڵװ���(BL = 07h)
    mov dh, 0		       		; �к�=0
	mov	dl, 0			 		; �к�=0
	int	10h			 			; BIOS��10h���ܣ���ʾһ���ַ�
	
	mov ah,0					; ����ִ�еĳ����� 
    int 16h
    mov byte[opernumber],al
    mov ah,0eh
    mov bx,opernumber
	mov al,[bx]
    int 10h 
	
	
	mov	ax, cs	       			; �������μĴ���ֵ��CS��ͬ
	mov	ds, ax	       			; ���ݶ�
	mov	es, ax		 			; ��ES=DS
	mov	bp, message2		 	; BP=��ǰ����ƫ�Ƶ�ַ
	mov	cx, lengh2  		    ; CX = ����
	mov	ax, 1301h		 		; AH = 13h�����ܺţ���AL = 01h��������ڴ�β��
	mov	bx, 0fh		 		    ; ҳ��Ϊ0(BH = 0) �ڵװ���(BL = 07h)
    mov dh, 1		       		; �к�=1
	mov	dl, 0			 		; �к�=0
	int	10h			 			; BIOS��10h���ܣ���ʾһ���ַ�

	xor cx,cx
lp:								; ����ִ�еĴ��� 
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

play:							; ��ʼִ�г��� 
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
		
end:							; ��������Ѿ�ִ���� 
	mov	ax, cs	       			; �������μĴ���ֵ��CS��ͬ
	mov	ds, ax	       			; ���ݶ�
	mov	es, ax		 			; ��ES=DS
	mov	bp, message3		 	; BP=��ǰ����ƫ�Ƶ�ַ
	mov	cx, lengh3  		    ; CX = ����
	mov	ax, 1301h		 		; AH = 13h�����ܺţ���AL = 01h��������ڴ�β��
	mov	bx, 0fh		 		    ; ҳ��Ϊ0(BH = 0) �ڵװ���(BL = 07h)
    mov di,[nowload]
    mov di,[nowload]
    add di,di
    mov dx,[rowcol+di]
	int	10h		
	jmp $ 
	
proc1:
     ;�����̻�Ӳ���ϵ����������������ڴ��ES:BX����
    mov ax,cs                	; �ε�ַ 		; ������ݵ��ڴ����ַ
    mov es,ax                	; ���öε�ַ
    mov bx,Progream1			; ƫ�Ƶ�ַ		; ������ݵ��ڴ�ƫ�Ƶ�ַ
    mov ah,2                 	; ���ܺ�
    mov al,1                 	; ������
    mov dl,0                 	; �������� 		; ����Ϊ0��Ӳ�̺�U��Ϊ80H
    mov dh,0                 	; ��ͷ��        ; ��ʼ���Ϊ0
    mov ch,0                 	; �����        ; ��ʼ���Ϊ0
    mov cl,3                 	; ��ʼ������    ; ��ʼ���Ϊ1
    int 13H 				 	; ���ö�����BIOS��13h����
    mov di,[nowload]
    mov di,[nowload]
    add di,di
    mov dx,[rowcol+di]
    jmp Progream1

proc2:
     ;�����̻�Ӳ���ϵ����������������ڴ��ES:BX����
    mov ax,cs                	; �ε�ַ 		; ������ݵ��ڴ����ַ
    mov es,ax                	; ���öε�ַ
    mov bx,Progream2			; ƫ�Ƶ�ַ		; ������ݵ��ڴ�ƫ�Ƶ�ַ
    mov ah,2                 	; ���ܺ�
    mov al,1                 	; ������
    mov dl,0                 	; �������� 		; ����Ϊ0��Ӳ�̺�U��Ϊ80H
    mov dh,0                 	; ��ͷ��        ; ��ʼ���Ϊ0
    mov ch,0                 	; �����        ; ��ʼ���Ϊ0
    mov cl,4                	; ��ʼ������    ; ��ʼ���Ϊ1
    int 13H 				 	; ���ö�����BIOS��13h����
    mov di,[nowload]
    mov di,[nowload]
    add di,di
    mov dx,[rowcol+di]
    jmp Progream2
    
proc3:
     ;�����̻�Ӳ���ϵ����������������ڴ��ES:BX����
    mov ax,cs                	; �ε�ַ 		; ������ݵ��ڴ����ַ
    mov es,ax                	; ���öε�ַ
    mov bx,Progream3			; ƫ�Ƶ�ַ		; ������ݵ��ڴ�ƫ�Ƶ�ַ
    mov ah,2                 	; ���ܺ�
    mov al,1                 	; ������
    mov dl,0                 	; �������� 		; ����Ϊ0��Ӳ�̺�U��Ϊ80H
    mov dh,0                 	; ��ͷ��        ; ��ʼ���Ϊ0
    mov ch,0                 	; �����        ; ��ʼ���Ϊ0
    mov cl,5                 	; ��ʼ������    ; ��ʼ���Ϊ1
    int 13H 				 	; ���ö�����BIOS��13h����
    mov di,[nowload]
    add di,di
    mov dx,[rowcol+di]
    jmp Progream3

 
	
clear:							; ����
	mov     ax, 0600h			 
 	mov     bx, 0700h 
 	mov     cx, 0h
	mov     dx, 184fh 
	int     10h
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
	mov cx,100
continue:
	call delays
	loop continue
	ret

delay equ 50000					; ��ʱ���ӳټ���,���ڿ��ƻ�����ٶ�
ddelay equ 580					; ��ʱ���ӳټ���,���ڿ��ƻ�����ٶ�
count dw delay
dcount dw ddelay

message1 db 'Now tell me the number of progreams that you want to execute: '	; ��ʾ����ʾ�� 
lengh1 equ ($-message1)
message2 db 'Please decide the order: '
lengh2 equ ($-message2)
message3 db 'All procedures have been run to completion!'
lengh3 equ ($-message3)
order db 0,0,0
opernumber dw 0 
nowload dw 0
rowcol dw 0400h,0500h,0600h,0700h
