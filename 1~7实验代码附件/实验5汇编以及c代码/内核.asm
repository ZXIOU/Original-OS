extrn _Judge:near               ;����һ��c������
extrn _ClearOrder:near          ;����һ��c������
extrn _Main:near           		;����һ��c������
extrn _getchar:near             ;����һ��c������
extrn _putchar:near             ;����һ��c������
extrn _gets:near                ;����һ��c������
extrn _puts:near                ;����һ��c������
extrn _Message1:near      		;����һ���ⲿ����	
extrn _Message2:near      		;����һ���ⲿ����	
extrn _Message3:near      		;����һ���ⲿ����
extrn _Message4:near      		;����һ���ⲿ����	
extrn _Message5:near      		;����һ���ⲿ����
extrn _Message6:near      		;����һ���ⲿ����
extrn _Message7:near      		;����һ���ⲿ����
extrn _Message8:near      		;����һ���ⲿ����
extrn _Message9:near      		;����һ���ⲿ����
extrn _Message10:near      		;����һ���ⲿ����
extrn _Message11:near      		;����һ���ⲿ����
extrn _Message12:near      		;����һ���ⲿ����
extrn _Message13:near      		;����һ���ⲿ����
extrn _Message14:near      		;����һ���ⲿ����
extrn _order:near      		    ;����һ���ⲿ����
extrn _ch:near      		    ;����һ���ⲿ����
extrn _string:near      		;����һ���ⲿ����

Restart equ 8400h
Progream1 equ 9000h				
Progream2 equ 9200h
Progream3 equ 9400h
Time equ 9600h
Help equ 9800h
Newint equ 9c00h

.8086
_TEXT segment byte public 'CODE'
DGROUP group _TEXT,_DATA,_BSS
assume cs:_TEXT
org 8400h

start:
	mov  ax,  cs
	mov  ds,  ax                	; DS = CS
	mov  es,  ax                	; ES = CS
	mov [es:84h],offset Int21		; ����ʱ���ж�������ƫ�Ƶ�ַ
	mov [es:86h],ax					; ����ʱ���ж������Ķε�ַ=CS
	call _Main
	jmp $


Int21:
	push ax
	push ds
	push es
	mov bp,sp
	mov si,[bp+14]
	cmp ah,0
	jz getch
	cmp ah,1
	jz putch
	cmp ah,2
	jz getstr
	cmp ah,3
	jz putstr
	cmp ah,4
	jz ouch_
	cmp ah,5
	jz lowtoupp_ 
	cmp ah,6
	jz upptolow_
	cmp ah,7
	jz showanyway_

ouch_: jmp ouch
lowtoupp_: jmp lowtoupp
upptolow_: jmp upptolow
showanyway_: jmp showanyway
	
getch:
	;mov si,[sp]
	mov ah,0
    int 16h
    mov [si],al
    mov ah,0eh
    int 10h
    
    mov al,20h				; AL = EOI
	out 20h,al				; ����EOI����8529A
	out 0A0h,al				; ����EOI����8529A
	pop es
	pop ds
	pop ax
    iret

putch:
	;mov si,offset _ch
    mov ah,0eh
	mov al,[si]
    int 10h
    
    mov al,20h					; AL = EOI
	out 20h,al					; ����EOI����8529A
	out 0A0h,al					; ����EOI����8529A
	pop es
	pop ds
	pop ax
    iret
    
getstr:
	;mov si,offset _string
	mov bx,0
loop1:
	mov ah,0
    int 16h
    mov [si+bx],al
    mov ah,0eh
    int 10h
    add bx,1
    mov ah,0dh
    cmp ah,al
    jnz loop1
    
    mov al,20h					; AL = EOI
	out 20h,al					; ����EOI����8529A
	out 0A0h,al					; ����EOI����8529A
	pop es
	pop ds
	pop ax
    iret

putstr:
	;mov si,offset _string
	mov bx,0
loop2:
    mov ah,0eh
	mov al,[si+bx]
    int 10h
    add bx,1
    mov ah,0dh
    cmp ah,al
    jnz loop2
    
    mov al,20h					; AL = EOI
	out 20h,al					; ����EOI����8529A
	out 0A0h,al					; ����EOI����8529A
	pop es
	pop ds
	pop ax
    iret

ouch:
	mov	ax, cs	       			; �������μĴ���ֵ��CS��ͬ
	mov	ds, ax	       			; ���ݶ�
	mov	es, ax		 			; ��ES=DS
	mov	bp, offset _Message14	; BP=��ǰ����ƫ�Ƶ�ַ
	mov	cx, 4  		        	; CX = ����
	mov	ax, 1300h		 		; AH = 13h�����ܺţ���AL = 00h���޹�꣩
	mov	bx, 0fh		 		    ; ҳ��Ϊ0(BH = 0) �ڵ�������(BL = 0fh)
    mov dh, 12		       		; �к�
	mov	dl, 38			 		; �к�
	int	10h			 			; BIOS��10h���ܣ���ʾһ���ַ�
	
	mov al,20h					; AL = EOI
	out 20h,al					; ����EOI����8529A
	out 0A0h,al					; ����EOI����8529A
	pop es
	pop ds
	pop ax
    iret
    
lowtoupp:
	mov bx,0
loop3:
    mov ah,0eh
	mov al,[si+bx]
	cmp al,97
	jb lpp1
	sub al,32
lpp1:
	mov [si+bx],al
    int 10h
    add bx,1
    mov ah,0dh
    cmp ah,al
    jnz loop3
	
	mov al,20h					; AL = EOI
	out 20h,al					; ����EOI����8529A
	out 0A0h,al					; ����EOI����8529A
	pop es
	pop ds
	pop ax
    iret
    
upptolow:
	mov bx,0
loop4:
    mov ah,0eh
	mov al,[si+bx]
	cmp al,91
	jae lpp2
	add al,32
lpp2:
	cmp al,2dh
	jnz	lpp3
	sub al,32
lpp3:	
	mov [si+bx],al
    int 10h
    add bx,1
    mov ah,0dh
    cmp ah,al
    jnz loop4
	
	mov al,20h					; AL = EOI
	out 20h,al					; ����EOI����8529A
	out 0A0h,al					; ����EOI����8529A
	pop es
	pop ds
	pop ax
    iret

showanyway:	
	mov ah,02h
	mov bh,0
	int	10h			 			; BIOS��10h���ܣ���ʾһ���ַ�
	
	mov bx,0
loop5:
    mov ah,0eh
	mov al,[si+bx]
    int 10h
    add bx,1
    mov ah,0dh
    cmp ah,al
    jnz loop5
    
	mov al,20h					; AL = EOI
	out 20h,al					; ����EOI����8529A
	out 0A0h,al					; ����EOI����8529A
	pop es
	pop ds
	pop ax
    iret
    
public _getch
_getch proc
	mov ah,0
	int 21h
	ret
_getch endp

public _putch
_putch proc
	mov ah,1
	int 21h
	ret
_putch endp

public _getstr
_getstr proc
	mov ah,2
	int 21h
	ret
_getstr endp

public _putstr
_putstr proc
	mov ah,3
	int 21h
	ret
_putstr endp

_ouch proc
	mov ah,4
	int 21h
	ret
_ouch endp

_lowtoupp proc
	mov ah,5
	int 21h
	ret
_lowtoupp endp

_upptolow proc
	mov ah,6
	int 21h
	ret
_upptolow endp

_showanyway proc
	mov ah,7
	mov dh,24
	mov dl,0
	int 21h
	ret
_showanyway endp

public _getput 
_getput proc
	mov ax, 0600h
 	mov bx, 0700h 
 	mov cx, 0h
	mov dx, 184fh 
	int 10h

	call _ouch
	
	mov	ax, cs	       			; �������μĴ���ֵ��CS��ͬ
	mov	ds, ax	       			; ���ݶ�
	mov	es, ax		 			; ��ES=DS
	mov	bp, offset _Message7	; BP=��ǰ����ƫ�Ƶ�ַ
	mov	cx, 39  		        ; CX = ����
	mov	ax, 1301h		 		; AH = 13h�����ܺţ���AL = 00h���޹�꣩
	mov	bx, 0fh		 		    ; ҳ��Ϊ0(BH = 0) �ڵ�������(BL = 0fh)
    mov dh, 0		       		; �к�
	mov	dl, 0			 		; �к�
	int	10h			 			; BIOS��10h���ܣ���ʾһ���ַ�
	mov si,offset _ch
	push si	
	call _getchar
	
	mov	bp, offset _Message8	; BP=��ǰ����ƫ�Ƶ�ַ
	mov	cx, 38  		        ; CX = ����
	mov	ax, 1301h		 		; AH = 13h�����ܺţ���AL = 00h���޹�꣩
	mov	bx, 0fh		 		    ; ҳ��Ϊ0(BH = 0) �ڵ�������(BL = 0fh)
    mov dh, 1		       		; �к�
	mov	dl, 0			 		; �к�
	int	10h			 			; BIOS��10h���ܣ���ʾһ���ַ�
	mov si,offset _ch
	push si	
	call _putchar
	
		
	mov	bp, offset _Message9	; BP=��ǰ����ƫ�Ƶ�ַ
	mov	cx, 45  		        ; CX = ����
	mov	ax, 1301h		 		; AH = 13h�����ܺţ���AL = 00h���޹�꣩
	mov	bx, 0fh		 		    ; ҳ��Ϊ0(BH = 0) �ڵ�������(BL = 0fh)
    mov dh, 2		       		; �к�
	mov	dl, 0			 		; �к�
	int	10h			 			; BIOS��10h���ܣ���ʾһ���ַ�
	mov si,offset _string
	push si	
	call _gets
	
	call _showanyway
	
	mov	bp, offset _Message10	; BP=��ǰ����ƫ�Ƶ�ַ
	mov	cx, 44  		        ; CX = ����
	mov	ax, 1301h		 		; AH = 13h�����ܺţ���AL = 00h���޹�꣩
	mov	bx, 0fh		 		    ; ҳ��Ϊ0(BH = 0) �ڵ�������(BL = 0fh)
    mov dh, 3		       		; �к�
	mov	dl, 0			 		; �к�
	int	10h			 			; BIOS��10h���ܣ���ʾһ���ַ�
	mov si,offset _string
	push si
	call _puts
	
	mov	bp, offset _Message11	; BP=��ǰ����ƫ�Ƶ�ַ
	mov	cx, 54  		        ; CX = ����
	mov	ax, 1301h		 		; AH = 13h�����ܺţ���AL = 00h���޹�꣩
	mov	bx, 0fh		 		    ; ҳ��Ϊ0(BH = 0) �ڵ�������(BL = 0fh)
    mov dh, 4		       		; �к�
	mov	dl, 0			 		; �к�
	int	10h			 			; BIOS��10h���ܣ���ʾһ���ַ�
	mov si,offset _string
	push si	
	call _lowtoupp
	
	mov	bp, offset _Message12	; BP=��ǰ����ƫ�Ƶ�ַ
	mov	cx, 54  		        ; CX = ����
	mov	ax, 1301h		 		; AH = 13h�����ܺţ���AL = 00h���޹�꣩
	mov	bx, 0fh		 		    ; ҳ��Ϊ0(BH = 0) �ڵ�������(BL = 0fh)
    mov dh, 5		       		; �к�
	mov	dl, 0			 		; �к�
	int	10h			 			; BIOS��10h���ܣ���ʾһ���ַ�
	mov si,offset _string
	push si	
	call _upptolow
		
	mov	bp, offset _Message13	; BP=��ǰ����ƫ�Ƶ�ַ
	mov	cx, 38  		        ; CX = ����
	mov	ax, 1300h		 		; AH = 13h�����ܺţ���AL = 00h���޹�꣩
	mov	bx, 0fh		 		    ; ҳ��Ϊ0(BH = 0) �ڵ�������(BL = 0fh)
    mov dh, 7		       		; �к�
	mov	dl, 0			 		; �к�
	int	10h			 			; BIOS��10h���ܣ���ʾһ���ַ�
	
loop6:
	mov ah,0
    int 16h
    mov ah,13
    cmp ah,al
    jnz loop6
    
    mov si,offset nowrow
    mov al,3
	mov [si],al 
    mov ax,8400h
	jmp ax 
	
_getput endp

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
    mov bx,9000h			    ; ƫ�Ƶ�ַ		; ������ݵ��ڴ�ƫ�Ƶ�ַ
    mov ah,2                 	; ���ܺ�
    mov al,1                 	; ������
    mov dl,0                 	; �������� 		; ����Ϊ0��Ӳ�̺�U��Ϊ80H
    mov dh,0                 	; ��ͷ��        ; ��ʼ���Ϊ0
    mov ch,0                 	; �����        ; ��ʼ���Ϊ0
    mov cl,11                 	; ��ʼ������    ; ��ʼ���Ϊ1
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
    mov bx,9200h			    ; ƫ�Ƶ�ַ		; ������ݵ��ڴ�ƫ�Ƶ�ַ
    mov ah,2                 	; ���ܺ�
    mov al,1                 	; ������
    mov dl,0                 	; �������� 		; ����Ϊ0��Ӳ�̺�U��Ϊ80H
    mov dh,0                 	; ��ͷ��        ; ��ʼ���Ϊ0
    mov ch,0                 	; �����        ; ��ʼ���Ϊ0
    mov cl,12                	; ��ʼ������    ; ��ʼ���Ϊ1
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
    mov bx,9400h			    ; ƫ�Ƶ�ַ		; ������ݵ��ڴ�ƫ�Ƶ�ַ
    mov ah,2                 	; ���ܺ�
    mov al,1                 	; ������
    mov dl,0                 	; �������� 		; ����Ϊ0��Ӳ�̺�U��Ϊ80H
    mov dh,0                 	; ��ͷ��        ; ��ʼ���Ϊ0
    mov ch,0                 	; �����        ; ��ʼ���Ϊ0
    mov cl,13                 	; ��ʼ������    ; ��ʼ���Ϊ1
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
	mov si,offset nowrow
    mov al,3
	mov [si],al 
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
    mov bx,9600h			    ; ƫ�Ƶ�ַ		; ������ݵ��ڴ�ƫ�Ƶ�ַ
    mov ah,2                 	; ���ܺ�
    mov al,1                 	; ������
    mov dl,0                 	; �������� 		; ����Ϊ0��Ӳ�̺�U��Ϊ80H
    mov dh,0                 	; ��ͷ��        ; ��ʼ���Ϊ0
    mov ch,0                 	; �����        ; ��ʼ���Ϊ0
    mov cl,14                 	; ��ʼ������    ; ��ʼ���Ϊ1
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
    mov bx,9800h			    ; ƫ�Ƶ�ַ		; ������ݵ��ڴ�ƫ�Ƶ�ַ
    mov ah,2                 	; ���ܺ�
    mov al,2                 	; ������
    mov dl,0                 	; �������� 		; ����Ϊ0��Ӳ�̺�U��Ϊ80H
    mov dh,0                 	; ��ͷ��        ; ��ʼ���Ϊ0
    mov ch,0                 	; �����        ; ��ʼ���Ϊ0
    mov cl,15                 	; ��ʼ������    ; ��ʼ���Ϊ1
    int 13H 				 	; ���ö�����BIOS��13h����
    mov si,offset nowrow
    mov al,3
	mov [si],al
    mov ax,Help
    jmp ax
    ret
_help endp

public _newint
_newint proc
	;�����̻�Ӳ���ϵ����������������ڴ��ES:BX����
    mov ax,cs                	; �ε�ַ 		; ������ݵ��ڴ����ַ
    mov es,ax                	; ���öε�ַ
    mov bx,9a00h			    	; ƫ�Ƶ�ַ		; ������ݵ��ڴ�ƫ�Ƶ�ַ
    mov ah,2                 	; ���ܺ�
    mov al,1                 	; ������
    mov dl,0                 	; �������� 		; ����Ϊ0��Ӳ�̺�U��Ϊ80H
    mov dh,0                 	; ��ͷ��        ; ��ʼ���Ϊ0
    mov ch,0                 	; �����        ; ��ʼ���Ϊ0
    mov cl,17                 	; ��ʼ������    ; ��ʼ���Ϊ1
    int 13H 				 	; ���ö�����BIOS��13h����
    mov si,offset nowrow
    mov al,3
	mov [si],al
    mov ax,Newint
    jmp ax
    ret
_newint endp

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