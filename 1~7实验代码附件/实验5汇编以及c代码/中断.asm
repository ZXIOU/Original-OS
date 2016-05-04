org  7e00h							; BIOS���������������ص�0:8b00h��������ʼִ��
	
start:	
	xor ax,ax						; AX = 0
	mov es,ax						; ES = 0
	mov si,[es:24h]
	mov word [es:0dch],si
	mov di,[es:26h]
	mov word [es:0deh],di
	mov word [es:20h],Timer			; ����ʱ���ж�������ƫ�Ƶ�ַ
	mov word [es:24h],Key			; ����ʱ���ж�������ƫ�Ƶ�ַ
	mov word [es:0cch],Int33		; ����ʱ���ж�������ƫ�Ƶ�ַ
	mov word [es:0d0h],Int34		; ����ʱ���ж�������ƫ�Ƶ�ַ
	mov word [es:0d4h],Int35		; ����ʱ���ж�������ƫ�Ƶ�ַ
	mov word [es:0d8h],Int36		; ����ʱ���ж�������ƫ�Ƶ�ַ
	mov ax,cs 
	mov word [es:22h],ax			; ����ʱ���ж������Ķε�ַ=CS
	mov word [es:26h],ax			; ����ʱ���ж������Ķε�ַ=CS
	mov word [es:0ceh],ax			; ����ʱ���ж������Ķε�ַ=CS
	mov word [es:0d2h],ax			; ����ʱ���ж������Ķε�ַ=CS
	mov word [es:0d6h],ax			; ����ʱ���ж������Ķε�ַ=CS
	mov word [es:0dah],ax			; ����ʱ���ж������Ķε�ַ=CS
	mov word [mark],ax				; ����ʱ���ж������Ķε�ַ=CS
	mov ds,ax			
	mov es,ax                		; ���öε�ַ
    mov bx,8400h			    	; ƫ�Ƶ�ַ		; ������ݵ��ڴ�ƫ�Ƶ�ַ
    mov ah,2                 		; ���ܺ�
    mov al,6                 		; ������
    mov dl,0                 		; �������� 		; ����Ϊ0��Ӳ�̺�U��Ϊ80H
    mov dh,0                 		; ��ͷ��        ; ��ʼ���Ϊ0
    mov ch,0                 		; �����        ; ��ʼ���Ϊ0
    mov cl,5                 		; ��ʼ������    ; ��ʼ���Ϊ1
    int 13H 				 		; ���ö�����BIOS��13h����
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
	
	mov	ax, ds	       		; ���ݶ�
	mov	es, ax		 		; ��ES=DS
	mov	bp, message1 		; BP=��ǰ����ƫ�Ƶ�ַ
	mov	cx, lengh1         	; CX = ����
	mov	ax, 1300h	 		; AH = 13h�����ܺţ���AL = 00h���޹�꣩
	mov	bx, 000fh			; ҳ��Ϊ0(BH = 0) �ڵ�������(BL = 0fh)
	mov dh, 24				; �к�
	mov	dl, 62			    ; �к�
	int	10h					; BIOS��10h���ܣ���ʾһ���ַ�
	
	mov al,20h				; AL = EOI
	out 20h,al				; ����EOI����8529A
	out 0A0h,al				; ����EOI����8529A
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
	mov	ds,ax	       				; ���ݶ�
	mov	es, ax		 				; ��ES=DS
	mov	bp, message2 				; BP=��ǰ����ƫ�Ƶ�ַ
	mov	cx, lengh2         			; CX = ����
	mov	ax, 1300h	 				; AH = 13h�����ܺţ���AL = 00h���޹�꣩
	mov si, [count]
	mov	bx, [color+si]				; ҳ��Ϊ0(BH = 0) �ڵ�������(BL = 0fh)
	inc byte[count]
	inc byte[count]
	mov dl,byte[count]
	cmp dl,0ch
	jnz hehe
	mov word[count],0
hehe:
	mov dh, 23					; �к�
	mov	dl, 62			    	; �к�
	int	10h	
	
	mov al,20h					; AL = EOI
	out 20h,al					; ����EOI����8529A
	out 0A0h,al					; ����EOI����8529A
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
	mov	bp, message3 				; BP=��ǰ����ƫ�Ƶ�ַ
	mov	cx, lengh3         			; CX = ����
	mov	ax, 1300h	 				; AH = 13h�����ܺţ���AL = 00h���޹�꣩
	mov	bx, 000fh					; ҳ��Ϊ0(BH = 0) �ڵ�������(BL = 0fh)
	mov dh, 6						; �к�
	mov	dl, 19			    		; �к�
	int	10h							; BIOS��10h���ܣ���ʾһ���ַ�
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
	mov	bp, message4 				; BP=��ǰ����ƫ�Ƶ�ַ
	mov	cx, lengh4         			; CX = ����
	mov	ax, 1300h	 				; AH = 13h�����ܺţ���AL = 00h���޹�꣩
	mov	bx, 000fh					; ҳ��Ϊ0(BH = 0) �ڵ�������(BL = 0fh)
	mov dh, 6						; �к�
	mov	dl, 55			    		; �к�
	int	10h							; BIOS��10h���ܣ���ʾһ���ַ�
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
	mov	bp, message5 				; BP=��ǰ����ƫ�Ƶ�ַ
	mov	cx, lengh5         			; CX = ����
	mov	ax, 1300h	 				; AH = 13h�����ܺţ���AL = 00h���޹�꣩
	mov	bx, 000fh					; ҳ��Ϊ0(BH = 0) �ڵ�������(BL = 0fh)
	mov dh, 18						; �к�
	mov	dl, 19			    		; �к�
	int	10h							; BIOS��10h���ܣ���ʾһ���ַ�
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
	mov	bp, message6 				; BP=��ǰ����ƫ�Ƶ�ַ
	mov	cx, lengh6         			; CX = ����
	mov	ax, 1300h	 				; AH = 13h�����ܺţ���AL = 00h���޹�꣩
	mov	bx, 000fh					; ҳ��Ϊ0(BH = 0) �ڵ�������(BL = 0fh)
	mov dh, 18						; �к�
	mov	dl, 55			    		; �к�
	int	10h							; BIOS��10h���ܣ���ʾһ���ַ�
	pop es
	pop ds
	popa
	iret
	
bcd_to_ascii:                       ;BCD��תASCII
                                    ;���룺AL=bcd��
                                    ;�����AX=ascii
    mov ah,al                       ;�ֲ���������� 
    and al,0x0f                     ;��������4λ 
    add al,0x30                     ;ת����ASCII 

    shr ah,4                        ;�߼�����4λ 
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