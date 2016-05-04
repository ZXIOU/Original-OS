extern getch(); 
extern putch();
extern getstr();
extern putstr();

void getchar(char *ch)
{
	getch(ch);
}

void putchar(char *ch)
{
	putch(ch);
}

void gets(char *str)
{
	getstr(str);	
}

void puts(char *str)
{
	putstr(str);
}
