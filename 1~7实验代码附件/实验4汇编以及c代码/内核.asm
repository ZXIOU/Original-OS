extrn _Judge:near               ;����һ��c������
extrn _ClearOrder:near          ;����һ��c������
extrn _Main:near           		;����һ��c������
extrn _Message1:near      		;����һ���ⲿ����	
extrn _Message2:near      		;����һ���ⲿ����	
extrn _Message3:near      		;����һ���ⲿ����
extrn _Message4:near      		;����һ���ⲿ����	
extrn _Message5:near      		;����һ���ⲿ����
extrn _Message6:near      		;����һ���ⲿ����
extrn _order:near      		    ;����һ���ⲿ����
Restart equ 7c00h
Progream1 equ 8500h				
Progream2 equ 8700h
Progream3 equ 8900h
Time equ 8b00h
Help equ 8d00h

.8086
_TEXT segment byte public 'CODE'
DGROUP group _TEXT,_DATA,_BSS
assume cs:_TEXT
org 8100h

start:
	mov  ax,  cs
	mov  ds,  ax                ; DS = CS
	mov  es,  ax                ; ES = CS
	call _Main
	jmp $

public _str
_str proc
    mov	ax, cs	       			; �������μĴ���ֵ��CS��ͬ
	mov	ds, ax	       			; ���ݶ�
	mov	es, ax		 			; ��ES=DS
	mov	bp, offset _Message1	; BP=��ǰ����ƫ�Ƶ�ַ
	mov	cx, 15  		        ; CX = ����
	mov	ax, 1300h		 		; AH = 13h�����ܺţ���AL = 00h���޹�꣩
	mov	bx, 0fh		 		    ; ҳ��Ϊ0(BH = 0) �ڵ�������(BL = 0fh)
    mov dh, 0		       		; �к�
	mov	dl, 0			 		; �к�
	int	10h			 			; BIOS��10h���ܣ���ʾһ���ַ�
		
	mov	ax, cs	       			; �������μĴ���ֵ��CS��ͬ
	mov	ds, ax	       			; ���ݶ�
	mov	es, ax		 			; ��ES=DS
	mov	bp, offset _Message2	; BP=��ǰ����ƫ�Ƶ�ַ
	mov	cx, 24  		        ; CX = ����
	mov	ax, 1300h		 		; AH = 13h�����ܺţ���AL = 00h���޹�꣩
	mov	bx, 0fh		 		    ; ҳ��Ϊ0(BH = 0) �ڵ�������(BL = 0fh)
    mov dh, 1		       		; �к�
	mov	dl, 0			 		; �к�
	int	10h			 			; BIOS��10h���ܣ���ʾһ���ַ�
	ret
_str endp


public _line
_line proc
	mov si,offset nowrow
	mov ah,[si]
	mov al,25
	cmp al,ah
	jnz next
	call clear2
next:
	mov	ax, cs	       			; �������μĴ���ֵ��CS��ͬ
	mov	ds, ax	       			; ���ݶ�
	mov	es, ax		 			; ��ES=DS
	mov	bp, offset _Message3	; BP=��ǰ����ƫ�Ƶ�ַ
	mov	bx, 0fh		 		    ; ҳ��Ϊ0(BH = 0) �ڵ�������(BL = 0fh)
	mov	cx, 12  		        ; CX = ����
	mov	ax, 1301h		 		; AH = 13h�����ܺţ���AL = 00h���޹�꣩
	mov dh,[si] 		       	; �к�
	mov	dl, 0			 		; �к�
	int	10h			 			; BIOS��10h���ܣ���ʾһ���ַ�
	inc dh
	mov [si],dh
	ret
_line endp

public _proc1
_proc1 proc
     ;�����̻�Ӳ���ϵ����������������ڴ��ES:BX����
    mov ax,cs                	; �ε�ַ 		; ������ݵ��ڴ����ַ
    mov es,ax                	; ���öε�ַ
    mov bx,8500h			    ; ƫ�Ƶ�ַ		; ������ݵ��ڴ�ƫ�Ƶ�ַ
    mov ah,2                 	; ���ܺ�
    mov al,1                 	; ������
    mov dl,0                 	; �������� 		; ����Ϊ0��Ӳ�̺�U��Ϊ80H
    mov dh,0                 	; ��ͷ��        ; ��ʼ���Ϊ0
    mov ch,0                 	; �����        ; ��ʼ���Ϊ0
    mov cl,4                 	; ��ʼ������    ; ��ʼ���Ϊ1
    int 13H 				 	; ���ö�����BIOS��13h����
    mov si,offset nowrow
    mov al,3
	mov [si],al 
    mov ax,Progream1
    jmp ax
    ret
_proc1 endp

public _proc2
_proc2 proc
     ;�����̻�Ӳ���ϵ����������������ڴ��ES:BX����
    mov ax,cs                	; �ε�ַ 		; ������ݵ��ڴ����ַ
    mov es,ax                	; ���öε�ַ
    mov bx,8700h			    ; ƫ�Ƶ�ַ		; ������ݵ��ڴ�ƫ�Ƶ�ַ
    mov ah,2                 	; ���ܺ�
    mov al,1                 	; ������
    mov dl,0                 	; �������� 		; ����Ϊ0��Ӳ�̺�U��Ϊ80H
    mov dh,0                 	; ��ͷ��        ; ��ʼ���Ϊ0
    mov ch,0                 	; �����        ; ��ʼ���Ϊ0
    mov cl,5                	; ��ʼ������    ; ��ʼ���Ϊ1
    int 13H 				 	; ���ö�����BIOS��13h����
    mov si,offset nowrow
    mov al,3
	mov [si],al 
    mov ax,Progream2
    jmp ax
    ret
_proc2 endp   
    
public _proc3
_proc3 proc
     ;�����̻�Ӳ���ϵ����������������ڴ��ES:BX����
    mov ax,cs                	; �ε�ַ 		; ������ݵ��ڴ����ַ
    mov es,ax                	; ���öε�ַ
    mov bx,8900h			    ; ƫ�Ƶ�ַ		; ������ݵ��ڴ�ƫ�Ƶ�ַ
    mov ah,2                 	; ���ܺ�
    mov al,1                 	; ������
    mov dl,0                 	; �������� 		; ����Ϊ0��Ӳ�̺�U��Ϊ80H
    mov dh,0                 	; ��ͷ��        ; ��ʼ���Ϊ0
    mov ch,0                 	; �����        ; ��ʼ���Ϊ0
    mov cl,6                 	; ��ʼ������    ; ��ʼ���Ϊ1
    int 13H 				 	; ���ö�����BIOS��13h����
    mov si,offset nowrow
    mov al,3
	mov [si],al 
    mov ax,Progream3
    jmp ax
    ret
_proc3 endp

public _restart
_restart proc
	mov ax,Restart
    jmp ax
_restart endp

public _shutdown
_shutdown proc
	call _clear1
	mov	ax, cs	       			; �������μĴ���ֵ��CS��ͬ
	mov	ds, ax	       			; ���ݶ�
	mov	es, ax		 			; ��ES=DS
	mov	bp, offset _Message6    ; BP=��ǰ����ƫ�Ƶ�ַ
	mov	cx, 24  		        ; CX = ����
	mov	ax, 1300h		 		; AH = 13h�����ܺţ���AL = 00h���޹�꣩
	mov	bx, 0fh		 		    ; ҳ��Ϊ0(BH = 0) �ڵ�������(BL = 0fh)
    mov dh, 12		       		; �к�
	mov	dl, 30			 		; �к�
	int	10h			 			; BIOS��10h���ܣ���ʾһ���ַ�
	call delayss	
	call _clear1
close: 
	mov ah,0h
	int 16h
    jmp close 
_shutdown endp

public _time
_time proc
	;�����̻�Ӳ���ϵ����������������ڴ��ES:BX����
    mov ax,cs                	; �ε�ַ 		; ������ݵ��ڴ����ַ
    mov es,ax                	; ���öε�ַ
    mov bx,8b00h			    ; ƫ�Ƶ�ַ		; ������ݵ��ڴ�ƫ�Ƶ�ַ
    mov ah,2                 	; ���ܺ�
    mov al,1                 	; ������
    mov dl,0                 	; �������� 		; ����Ϊ0��Ӳ�̺�U��Ϊ80H
    mov dh,0                 	; ��ͷ��        ; ��ʼ���Ϊ0
    mov ch,0                 	; �����        ; ��ʼ���Ϊ0
    mov cl,7                 	; ��ʼ������    ; ��ʼ���Ϊ1
    int 13H 				 	; ���ö�����BIOS��13h����
    mov si,offset nowrow
    mov al,3
	mov [si],al 
    mov ax,Time
    jmp ax
    ret
_time endp

public _help
_help proc
	;�����̻�Ӳ���ϵ����������������ڴ��ES:BX����
    mov ax,cs                	; �ε�ַ 		; ������ݵ��ڴ����ַ
    mov es,ax                	; ���öε�ַ
    mov bx,8d00h			    ; ƫ�Ƶ�ַ		; ������ݵ��ڴ�ƫ�Ƶ�ַ
    mov ah,2                 	; ���ܺ�
    mov al,1                 	; ������
    mov dl,0                 	; �������� 		; ����Ϊ0��Ӳ�̺�U��Ϊ80H
    mov dh,0                 	; ��ͷ��        ; ��ʼ���Ϊ0
    mov ch,0                 	; �����        ; ��ʼ���Ϊ0
    mov cl,8                 	; ��ʼ������    ; ��ʼ���Ϊ1
    int 13H 				 	; ���ö�����BIOS��13h����
    mov si,offset nowrow
    mov al,3
	mov [si],al
    mov ax,Help
    jmp ax
    ret
_help endp

public _in
_in proc
lp:
	call _line
	call _ClearOrder
	xor bx,bx
	xor cx,cx
	mov si,offset _order
lp1:
	inc cl
	mov al,32
	cmp al,cl
	jnz	lp2
	call error2 
	jmp lp
lp2:
	mov ah,0
    int 16h
    mov [si+bx],al
    mov ah,0eh
	mov al,[si+bx]
    int 10h
    add bx,1
    mov ah,0dh
    cmp ah,al
    jnz lp1
	call _judge
	call error1
	jmp lp 
	ret 
_in endp

error1 proc
	mov si,offset nowrow
    mov	ax, cs	       				; �������μĴ���ֵ��CS��ͬ
	mov	ds, ax	       				; ���ݶ�
	mov	es, ax		 				; ��ES=DS
	mov	bp, offset _Message4    	; BP=��ǰ����ƫ�Ƶ�ַ
	mov	bx, 0fh		 		    	; ҳ��Ϊ0(BH = 0) �ڵ�������(BL = 0fh)
	mov	cx, 18  		        	; CX = ����
	mov	ax, 1300h		 			; AH = 13h�����ܺţ���AL = 00h���޹�꣩		
    mov dh,[si] 		       		; �к�
	mov	dl, 0			 			; �к�
	int	10h			 				; BIOS��10h���ܣ���ʾһ���ַ�
	;inc byte[si]
	mov al,24
	cmp al,dh
	jnz lp4
	call delays
lp4:
	inc dh
	mov [si],dh
	;call _in
	ret
error1 endp

error2 proc
	mov si,offset nowrow
    mov	ax, cs	       				; �������μĴ���ֵ��CS��ͬ
	mov	ds, ax	       				; ���ݶ�
	mov	es, ax		 				; ��ES=DS
	mov	bp, offset _Message5    	; BP=��ǰ����ƫ�Ƶ�ַ
	mov	bx, 0fh		 		    	; ҳ��Ϊ0(BH = 0) �ڵ�������(BL = 0fh)
	mov	cx, 24  		        	; CX = ����
	mov	ax, 1300h		 			; AH = 13h�����ܺţ���AL = 00h���޹�꣩		
    mov dh,[si] 		       		; �к�
	mov	dl, 0			 			; �к�
	int	10h			 				; BIOS��10h���ܣ���ʾһ���ַ�
	mov al,24
	cmp al,dh
	jnz lp5
	call delays
lp5:
	;inc byte[si]
	inc dh
	mov [si],dh
	ret
error2 endp

public _clear1
_clear1 proc						; ����
	mov     ax, 0600h			 
 	mov     bx, 0700h 
 	mov     cx, 0h
	mov     dx, 184fh 
	int     10h
	ret
_clear1 endp


clear2 proc							; ���� 
	mov     ax, 0600h			 
 	mov     bx, 0700h 
 	mov     cx, 0300h
	mov     dx, 184fh 
	int     10h
	mov si,offset nowrow
	mov cl,3
	mov [si],cl
	ret	
clear2 endp

delays 	proc						; ��ʱ���� 
again:
	mov di,offset count
	mov cx,[di]
	dec cx				        	; �ݼ���������
	mov [di],cx
	jnz again						; >0,��ת;
	mov di,offset count
	mov [di],delay
	mov di,offset dcount
	mov cx,[di]
	dec cx				        	; �ݼ���������
	mov [di],cx
    jnz again						; >0,��ת;
    mov di,offset count
	mov [di],delay
	mov di,offset dcount
	mov [di],ddelay
	ret
delays endp

delayss proc						; ��ʱ����ʱ���� 
	mov cx,10
continue:
	push cx
	call delays
	pop cx
	loop continue
	ret
delayss endp

delay equ 50000					    ; ��ʱ���ӳټ���
ddelay equ 580					    ; ��ʱ���ӳټ���
count dw delay
dcount dw ddelay
nowrow db 3

_TEXT ends
;************DATA segment*************
_DATA segment word public 'DATA'
_DATA ends
;*************BSS segment*************
_BSS	segment word public 'BSS'
_BSS ends
;**************end of file***********
end start