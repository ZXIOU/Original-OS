extrn _fsprocess:near               	;����һ��c������
extrn _CountLetter:near             	;����һ��c������
extrn _str:near  						;����һ��c����
extrn _str1:near  						;����һ��c����
extrn _str2:near  						;����һ��c����
extrn _str3:near  						;����һ��c����
extrn _strNumber:near  					;����һ��c����  
.8086
_TEXT segment byte public 'CODE'
DGROUP group _TEXT,_DATA,_BSS
assume cs:_TEXT
org  100h								; BIOS���������������ص�0:100h��������ʼִ��
Start:
	adr dw 8400h,0000h
	call _fsprocess
lp:
	mov ah,0
    int 16h
    mov ah,13
    cmp ah,al
    jnz lp
	mov bp,offset adr
	jmp dword ptr [bp]
	
public _fork
_fork proc
	mov ah,8
   	int 21h
   	ret
_fork endp

public _wait
_wait proc
	mov ah,9
   	int 21h
   	ret
_wait endp

public _exit
_exit proc
	mov ah,10
   	int 21h
   	ret
_exit endp

public _printf 
_printf proc
	mov	ax, cs	       			; �������μĴ���ֵ��CS��ͬ
	mov	ds, ax	       			; ���ݶ�
	mov	es, ax		 			; ��ES=DS
	mov bp,	offset _str1
	mov	cx, 49 		        	; CX = ����
	mov	ax, 1300h		 		; AH = 13h�����ܺţ���AL = 00h���޹�꣩
	mov	bx, 0fh		 		    ; ҳ��Ϊ0(BH = 0) �ڵ�������(BL = 0fh)
    mov dh, 10		       		; �к�
	mov	dl, 10			 		; �к�
	int	10h			 			; BIOS��10h���ܣ���ʾһ���ַ�
	
	mov	ax, cs	       			; �������μĴ���ֵ��CS��ͬ
	mov	ds, ax	       			; ���ݶ�
	mov	es, ax		 			; ��ES=DS
	mov bp,	offset _str2
	mov	cx, 48 		        	; CX = ����
	mov	ax, 1300h		 		; AH = 13h�����ܺţ���AL = 00h���޹�꣩
	mov	bx, 0fh		 		    ; ҳ��Ϊ0(BH = 0) �ڵ�������(BL = 0fh)
    mov dh, 11		       		; �к�
	mov	dl, 10			 		; �к�
	int	10h			 			; BIOS��10h���ܣ���ʾһ���ַ�

	mov	ax, cs	       			; �������μĴ���ֵ��CS��ͬ
	mov	ds, ax	       			; ���ݶ�
	mov	es, ax		 			; ��ES=DS
	mov bp,	offset _str3	
	mov	cx, 39 		        	; CX = ����
	mov	ax, 1300h		 		; AH = 13h�����ܺţ���AL = 00h���޹�꣩
	mov	bx, 0fh		 		    ; ҳ��Ϊ0(BH = 0) �ڵ�������(BL = 0fh)
    mov dh, 12		       		; �к�
	mov	dl, 10			 		; �к�
	int	10h			 			; BIOS��10h���ܣ���ʾһ���ַ�
	
    mov	ax, cs	       			; �������μĴ���ֵ��CS��ͬ
	mov	ds, ax	       			; ���ݶ�
	mov	es, ax		 			; ��ES=DS
	mov bx,	sp
	mov bp,	ss:[bx+2]
	mov	cx, 2  		        	; CX = ����
	mov	ax, 1300h		 		; AH = 13h�����ܺţ���AL = 00h���޹�꣩
	mov	bx, 0fh		 		    ; ҳ��Ϊ0(BH = 0) �ڵ�������(BL = 0fh)
    mov dh, 12		       		; �к�
	mov	dl, 49			 		; �к�
	int	10h			 			; BIOS��10h���ܣ���ʾһ���ַ�
_printf endp

_TEXT ends
;************DATA segment*************
_DATA segment word public 'DATA'
_DATA ends
;*************BSS segment*************
_BSS	segment word public 'BSS'
_BSS ends
;**************end of file***********
end start