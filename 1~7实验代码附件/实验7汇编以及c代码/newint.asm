org  b400h						; BIOS将把引导扇区加载到0:b400h处，并开始执行

Start:
	mov     ax, 0600h
 	mov     bx, 0700h 
 	mov     cx, 0h
	mov     dx, 184fh 
	int     10h	
	
	int 33h
	int 34h
	int 35h
	int 36h
lp:
	mov ah,0
    int 16h
    mov ah,13
    cmp ah,al
    jnz lp
	jmp 8400h

