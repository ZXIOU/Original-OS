org  9400h						; BIOS���������������ص�0:8900h��������ʼִ��

Start:
	mov     ax, 0600h
 	mov     bx, 0700h 
 	mov     cx, 0h
	mov     dx, 184fh 
	int     10h	
    mov	ax, cs	       			; �������μĴ���ֵ��CS��ͬ
	mov	ds, ax	       			; ���ݶ�
	mov	es, ax		 			; ��ES=DS
	mov	bp, message1		 	; BP=��ǰ����ƫ�Ƶ�ַ
	mov	cx, lengh1  		    ; CX = ����
	mov	ax, 1300h		 		; AH = 13h�����ܺţ���AL = 00h���޹�꣩
	mov	bx, 0fh		 		    ; ҳ��Ϊ0(BH = 0) �ڵ�������(BL = 0fh)
	mov dh, 0		       		; �к�=0
	mov	dl, 0			 		; �к�=0
	int	10h			 			; BIOS��10h���ܣ���ʾһ���ַ�
	call delayss
	mov	ax, cs	       			; �������μĴ���ֵ��CS��ͬ
	mov	ds, ax	       			; ���ݶ�
	mov	es, ax		 			; ��ES=DS
	mov	bp, message2		 	; BP=��ǰ����ƫ�Ƶ�ַ
	mov	cx, lengh2  		    ; CX = ����
	mov	ax, 1300h		 		; AH = 13h�����ܺţ���AL = 00h���޹�꣩
	mov	bx, 0fh		 		    ; ҳ��Ϊ0(BH = 0) �ڵ�������(BL = 0fh)
	mov dh, 2		       		; �к�=0
	mov	dl, 0			 		; �к�=0
	int	10h			 			; BIOS��10h���ܣ���ʾһ���ַ�
	mov	ax, cs	       			; �������μĴ���ֵ��CS��ͬ
	mov	ds, ax	       			; ���ݶ�
	mov	es, ax		 			; ��ES=DS
	mov	bp, message3		 	; BP=��ǰ����ƫ�Ƶ�ַ
	mov	cx, lengh3  		    ; CX = ����
	mov	ax, 1300h		 		; AH = 13h�����ܺţ���AL = 00h���޹�꣩
	mov	bx, 0fh		 		    ; ҳ��Ϊ0(BH = 0) �ڵ�������(BL = 0fh)
	mov dh, 3		       		; �к�=0
	mov	dl, 0			 		; �к�=0
	int	10h			 			; BIOS��10h���ܣ���ʾһ���ַ�
lp:
	mov ah,0
    int 16h
    mov ah,13
    cmp ah,al
    jnz lp
	jmp 8400h 
	  
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
	mov cx,15
continue:
	call delays
	loop continue
	ret

delay equ 50000					; ��ʱ���ӳټ���,���ڿ��ƻ�����ٶ�
ddelay equ 580					; ��ʱ���ӳټ���,���ڿ��ƻ�����ٶ�
count dw delay
dcount dw ddelay

message1 db 'The third program is executing...'	; ��ʾ����ʾ�� 
lengh1 equ ($-message1)
message2 db 'The third program has been finished!'	; ��ʾ����ʾ�� 
lengh2 equ ($-message2)
message3 db 'You can press the Enter key to return.'	; ��ʾ����ʾ�� 
lengh3 equ ($-message3)