org  8b00h						; BIOS���������������ص�0:8b00h��������ʼִ��
	
start:
	mov ax, 0600h			 
 	mov bx, 0700h 
 	mov cx, 0h
	mov dx, 184fh 
	int 10h
	    
	mov	ax, cs	       			; �������μĴ���ֵ��CS��ͬ
	mov	ds, ax	       			; ���ݶ�
	mov	es, ax		 			; ��ES=DS
	mov	bp, message1		 	; BP=��ǰ����ƫ�Ƶ�ַ
	mov	cx, lengh1  		    ; CX = ����
	mov	ax, 1300h		 		; AH = 13h�����ܺţ���AL = 00h���޹�꣩
	mov	bx, 0fh		 		    ; ҳ��Ϊ0(BH = 0) �ڵ�������(BL = 0fh)
	mov dh, 14		       		; �к�=0
	mov	dl, 24			 		; �к�=0
	int	10h			 			; BIOS��10h���ܣ���ʾһ���ַ�
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
	
	mov	ax, ds			    ; ES:BP = ����ַ
	mov	es, ax			    ; ��ES=DS 
	mov	bp,message 			; BP=��ǰ����ƫ�Ƶ�ַ
	mov	cx,lengh         	; CX = ������=10��
	mov	ax, 1300h	 		; AH = 13h�����ܺţ���AL = 00h���޹�꣩
	mov	bx, 0fh			    ; ҳ��Ϊ0(BH = 0) �ڵ�������(BL = 0fh)
	mov dh, 12				; �к�=12
	mov	dl, 31			    ; �к�=31
	int	10h					; BIOS��10h���ܣ���ʾһ���ַ�
	call delays
	mov ah,01h
	int 16h
	jz lp
	mov ah,00h
	int 16h
	jmp 8100h
	
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
	
delays:								; ��ʱ���� 
again:
	dec word[count]					; �ݼ���������
	jnz again						; >0,��ת;
	mov word[count],delay
	dec word[dcount]				; �ݼ���������
    jnz again						; >0,��ת;
	mov word[count],delay
	mov word[dcount],ddelay
	ret

delay equ 4000						; ��ʱ���ӳټ���
ddelay equ 500						; ��ʱ���ӳټ���
count dw delay
dcount dw ddelay	
message db 0,0,'/',0,0,'/',0,0,' ',0,0,':',0,0,':',0,0
lengh equ ($-message)
message1 db 'You can press any key to return.'	; ��ʾ����ʾ�� 
lengh1 equ ($-message1)
	
