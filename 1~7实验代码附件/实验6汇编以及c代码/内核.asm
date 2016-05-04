extrn _Judge:near               ;����һ��c������
extrn _ClearOrder:near          ;����һ��c������
extrn _Main:near           		;����һ��c������
extrn _getchar:near             ;����һ��c������
extrn _putchar:near             ;����һ��c������
extrn _gets:near                ;����һ��c������
extrn _puts:near                ;����һ��c������
extrn _Save_Process				;����һ��c������
extrn _Run_Number				;����һ��c������
extrn _init_PCB					;����һ��c������
extrn _Current_Process			;����һ��c������
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
;extrn _pcbStartFlag				;����һ���ⲿ����
					
Restart equ 8400h
Progream1 equ 0a800h				
Progream2 equ 0aa00h
Progream3 equ 0ac00h
Time equ 0ae00h
Help equ 0b000h
Newint equ 0b400h

.8086
_TEXT segment byte public 'CODE'
DGROUP group _TEXT,_DATA,_BSS
assume cs:_TEXT
org 8400h

start:
	_pcbStartFlag dw 0
	mov  ax,  cs
	mov  ds,  ax                	; DS = CS
	mov  es,  ax                	; ES = CS
	mov word ptr[_pcbStartFlag],0
	mov [es:20h],offset Timer		; ����ʱ���ж�������ƫ�Ƶ�ַ
	mov [es:22h],ax					; ����ʱ���ж������Ķε�ַ=CS
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

message15 db 0,0,'/',0,0,'/',0,0,' ',0,0,':',0,0,':',0,0
lengh15 equ ($-message15)

Timer:
	cmp word ptr[_pcbStartFlag],0
	jz	regular_timer
	jmp another_timer

regular_timer:
	push ax
	push bx
	push cx
	push dx
	push sp
	push bp
	push si
	push di
	push ds
	push es							
	mov ah,04h
	int 1Ah
	mov al,cl
	call bcd_to_ascii
	mov si,offset message15
	mov [si],ah
	mov [si+1],al
	mov al,'/'
	mov [si+2],al
	mov al,dh
	call bcd_to_ascii
	mov [si+3],ah
	mov [si+4],al
	mov al,'/'
	mov [si+5],al
	mov al,dl
	call bcd_to_ascii
	mov [si+6],ah
	mov [si+7],al
	
	mov al,' '
	mov [si+8],al
	
	mov ah,02h
	int 1Ah
	mov al,ch
	call bcd_to_ascii
	mov [si+9],ah
	mov [si+10],al
	mov al,':'
	mov [si+11],al
	mov al,cl
	call bcd_to_ascii
	mov [si+12],ah
	mov [si+13],al
	mov al,':'
	mov [si+14],al
	mov al,dh
	call bcd_to_ascii
	mov [si+15],ah
	mov [si+16],al
	
	mov	ax, ds	       				; ���ݶ�
	mov	es, ax		 				; ��ES=DS
	mov	bp, offset message15 		; BP=��ǰ����ƫ�Ƶ�ַ
	mov	cx, lengh15         		; CX = ����
	mov	ax, 1300h	 				; AH = 13h�����ܺţ���AL = 00h���޹�꣩
	mov	bx, 000fh					; ҳ��Ϊ0(BH = 0) �ڵ�������(BL = 0fh)
	mov dh, 24						; �к�
	mov	dl, 62			    		; �к�
	int	10h							; BIOS��10h���ܣ���ʾһ���ַ�
	mov al,20h						; AL = EOI
	out 20h,al						; ����EOI����8529A
	out 0A0h,al						; ����EOI����8529A
	pop es
	pop ds
	pop di
	pop si
	pop bp
	pop sp
	pop dx
	pop cx
	pop bx
	pop ax
	iret

timercount db 0
another_timer:
	mov bx,offset timercount
	mov al,[bx]
	add al,1
	cmp al,18
	jnz next_timer
	mov al,0
	mov [bx],al
	jmp Pro_Timer
next_timer:	
	mov [bx],al
	mov al,20h						; AL = EOI
	out 20h,al						; ����EOI����8529A
	out 0A0h,al						; ����EOI����8529A
	iret 

Pro_Timer:
;*****************************************
;*                Save                   *
;*****************************************
    push ss
	push ax
	push bx
	push cx
	push dx
	push sp
	push bp
	push si
	push di
	push ds
	push es
	.386
	push fs
	push gs
	.8086

	mov ax,cs
	mov ds, ax
	mov es, ax
	call near ptr _Save_Process
	
	.386
	pop gs
	pop fs
	pop es
	pop ds
	pop di
	pop si
	pop bp
	pop sp
	pop dx
	pop cx
	pop bx
	pop ax
	pop ss
	
Pre:
	mov ax, cs
	mov ds, ax
	mov es, ax
	
	call near ptr _Run_Number
	call near ptr _Current_Process
	mov bp, ax
;*****************************************
;*                Restart                *
;*****************************************
Restart_:
	push word ptr ds:[bp+30]
	push word ptr ds:[bp+28]
	push word ptr ds:[bp+26]
	
	push word ptr ds:[bp+2]
	push word ptr ds:[bp+4]
	push word ptr ds:[bp+6]
	push word ptr ds:[bp+8]
	push word ptr ds:[bp+10]
	push word ptr ds:[bp+12]
	push word ptr ds:[bp+14]
	push word ptr ds:[bp+18]
	push word ptr ds:[bp+20]
	push word ptr ds:[bp+22]
	push word ptr ds:[bp+24]

	pop ax
	pop cx
	pop dx
	pop bx
	pop bp
	pop si
	pop di
	pop ds
	pop es
	.386
	pop fs
	pop gs
	.8086

	push ax         
	mov al,20h
	out 20h,al
	out 0A0h,al
	pop ax
	iret

adress1 dw 0100h,1000h
public _Multi_thread
_Multi_thread proc
	;�����̻�Ӳ���ϵ����������������ڴ��ES:BX����
    mov ax,1000h                	; �ε�ַ 		; ������ݵ��ڴ����ַ
    mov es,ax                		; ���öε�ַ
    mov bx,0100h			    	; ƫ�Ƶ�ַ		; ������ݵ��ڴ�ƫ�Ƶ�ַ
    mov ah,2                 		; ���ܺ�
    mov al,1                 		; ������
    mov dl,0                 		; �������� 		; ����Ϊ0��Ӳ�̺�U��Ϊ80H
    mov dh,1                 		; ��ͷ��        ; ��ʼ���Ϊ0
    mov ch,0                 		; �����        ; ��ʼ���Ϊ0
    mov cl,9                 		; ��ʼ������    ; ��ʼ���Ϊ1
    int 13H 				 		; ���ö�����BIOS��13h����
    
    mov ax,2000h                	; �ε�ַ 		; ������ݵ��ڴ����ַ
    mov es,ax                		; ���öε�ַ
    mov bx,0100h			    	; ƫ�Ƶ�ַ		; ������ݵ��ڴ�ƫ�Ƶ�ַ
    mov ah,2                 		; ���ܺ�
    mov al,1                 		; ������
    mov dl,0                 		; �������� 		; ����Ϊ0��Ӳ�̺�U��Ϊ80H
    mov dh,1                 		; ��ͷ��        ; ��ʼ���Ϊ0
    mov ch,0                 		; �����        ; ��ʼ���Ϊ0
    mov cl,10                		; ��ʼ������    ; ��ʼ���Ϊ1
    int 13H 				 		; ���ö�����BIOS��13h����
    
    mov ax,3000h                	; �ε�ַ 		; ������ݵ��ڴ����ַ
    mov es,ax                		; ���öε�ַ
    mov bx,0100h			    	; ƫ�Ƶ�ַ		; ������ݵ��ڴ�ƫ�Ƶ�ַ
    mov ah,2                 		; ���ܺ�
    mov al,1                 		; ������
    mov dl,0                 		; �������� 		; ����Ϊ0��Ӳ�̺�U��Ϊ80H
    mov dh,1                 		; ��ͷ��        ; ��ʼ���Ϊ0
    mov ch,0                 		; �����        ; ��ʼ���Ϊ0
    mov cl,11                 		; ��ʼ������    ; ��ʼ���Ϊ1
    int 13H 				 		; ���ö�����BIOS��13h����
    
    mov ax,4000h                	; �ε�ַ 		; ������ݵ��ڴ����ַ
    mov es,ax                		; ���öε�ַ
    mov bx,0100h			    	; ƫ�Ƶ�ַ		; ������ݵ��ڴ�ƫ�Ƶ�ַ
    mov ah,2                 		; ���ܺ�
    mov al,1                 		; ������
    mov dl,0                 		; �������� 		; ����Ϊ0��Ӳ�̺�U��Ϊ80H
    mov dh,1                 		; ��ͷ��        ; ��ʼ���Ϊ0
    mov ch,0                 		; �����        ; ��ʼ���Ϊ0
    mov cl,12                 		; ��ʼ������    ; ��ʼ���Ϊ1
    int 13H 				 		; ���ö�����BIOS��13h����
    
    mov si,offset nowrow
    mov al,3
	mov [si],al
	
	mov word ptr[_pcbStartFlag],1
	call _clear1
	
	mov bx,offset adress1
	jmp dword ptr [bx]
    ret
_Multi_thread endp

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

bcd_to_ascii proc                   ;BCD��תASCII
                                    ;���룺AL=bcd��
                                    ;�����AX=ascii
    mov ah,al                       ;�ֲ���������� 
    and al,0fh                    ;��������4λ 
    add al,30h                     ;ת����ASCII 

    shr ah,4                        ;�߼�����4λ 
    and ah,0fh                        
    add ah,30h
	ret	
bcd_to_ascii endp

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
    mov bx,Progream1			    ; ƫ�Ƶ�ַ		; ������ݵ��ڴ�ƫ�Ƶ�ַ
    mov ah,2                 	; ���ܺ�
    mov al,1                 	; ������
    mov dl,0                 	; �������� 		; ����Ϊ0��Ӳ�̺�U��Ϊ80H
    mov dh,1                 	; ��ͷ��        ; ��ʼ���Ϊ0
    mov ch,0                 	; �����        ; ��ʼ���Ϊ0
    mov cl,2                 	; ��ʼ������    ; ��ʼ���Ϊ1
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
    mov bx,Progream2			    ; ƫ�Ƶ�ַ		; ������ݵ��ڴ�ƫ�Ƶ�ַ
    mov ah,2                 	; ���ܺ�
    mov al,1                 	; ������
    mov dl,0                 	; �������� 		; ����Ϊ0��Ӳ�̺�U��Ϊ80H
    mov dh,1                 	; ��ͷ��        ; ��ʼ���Ϊ0
    mov ch,0                 	; �����        ; ��ʼ���Ϊ0
    mov cl,3                	; ��ʼ������    ; ��ʼ���Ϊ1
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
    mov bx,Progream3			    ; ƫ�Ƶ�ַ		; ������ݵ��ڴ�ƫ�Ƶ�ַ
    mov ah,2                 	; ���ܺ�
    mov al,1                 	; ������
    mov dl,0                 	; �������� 		; ����Ϊ0��Ӳ�̺�U��Ϊ80H
    mov dh,1                 	; ��ͷ��        ; ��ʼ���Ϊ0
    mov ch,0                 	; �����        ; ��ʼ���Ϊ0
    mov cl,4                 	; ��ʼ������    ; ��ʼ���Ϊ1
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
    mov bx,Time			    	; ƫ�Ƶ�ַ		; ������ݵ��ڴ�ƫ�Ƶ�ַ
    mov ah,2                 	; ���ܺ�
    mov al,1                 	; ������
    mov dl,0                 	; �������� 		; ����Ϊ0��Ӳ�̺�U��Ϊ80H
    mov dh,1                 	; ��ͷ��        ; ��ʼ���Ϊ0
    mov ch,0                 	; �����        ; ��ʼ���Ϊ0
    mov cl,5                 	; ��ʼ������    ; ��ʼ���Ϊ1
    int 13H 				 	; ���ö�����BIOS��13h����
    mov si,offset nowrow
    mov al,3
	mov [si],al 
    mov ax,Time
    jmp ax
    ret
_time endp

delaysss 	proc						; ��ʱ���� 
againss:
	mov di,offset count
	mov cx,[di]
	dec cx				        	; �ݼ���������
	mov [di],cx
	jnz againss						; >0,��ת;
	mov di,offset count
	mov [di],delay
	mov di,offset dcount
	mov cx,[di]
	dec cx				        	; �ݼ���������
	mov [di],cx
    jnz againss						; >0,��ת;
    mov di,offset count
	mov [di],delay
	mov di,offset dcount
	mov [di],ddelay
	ret
delaysss endp

public _help
_help proc
	;�����̻�Ӳ���ϵ����������������ڴ��ES:BX����
    mov ax,cs                	; �ε�ַ 		; ������ݵ��ڴ����ַ
    mov es,ax                	; ���öε�ַ
    mov bx,Help			    	; ƫ�Ƶ�ַ		; ������ݵ��ڴ�ƫ�Ƶ�ַ
    mov ah,2                 	; ���ܺ�
    mov al,2                 	; ������
    mov dl,0                 	; �������� 		; ����Ϊ0��Ӳ�̺�U��Ϊ80H
    mov dh,1                 	; ��ͷ��        ; ��ʼ���Ϊ0
    mov ch,0                 	; �����        ; ��ʼ���Ϊ0
    mov cl,6                 	; ��ʼ������    ; ��ʼ���Ϊ1
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
    mov bx,Newint			    ; ƫ�Ƶ�ַ		; ������ݵ��ڴ�ƫ�Ƶ�ַ
    mov ah,2                 	; ���ܺ�
    mov al,1                 	; ������
    mov dl,0                 	; �������� 		; ����Ϊ0��Ӳ�̺�U��Ϊ80H
    mov dh,1                 	; ��ͷ��        ; ��ʼ���Ϊ0
    mov ch,0                 	; �����        ; ��ʼ���Ϊ0
    mov cl,8                 	; ��ʼ������    ; ��ʼ���Ϊ1
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