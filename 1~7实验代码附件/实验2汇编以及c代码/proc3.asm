org  8700h						; BIOS���������������ص�0:8700h��������ʼִ��

Start:
    mov	ax, cs	       			; �������μĴ���ֵ��CS��ͬ
	mov	ds, ax	       			; ���ݶ�
	mov	es, ax		 			; ��ES=DS
	mov	bp, message1		 	; BP=��ǰ����ƫ�Ƶ�ַ
	mov	cx, lengh1  		    ; CX = ����
	mov	ax, 1301h		 		; AH = 13h�����ܺţ���AL = 01h��������ڴ�β��
	mov	bx, 0fh		 		    ; ҳ��Ϊ0(BH = 0) �ڵװ���(BL = 07h)
	int	10h			 			; BIOS��10h���ܣ���ʾһ���ַ�
	call delayss
	jmp 8180h 
	  
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
