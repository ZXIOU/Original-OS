extern getch(); 
extern putch();
extern getstr();
extern putstr();
extern scan();

void scanf(char *format1,char *format2)
{
	scan(format1,format2);
}

void prinf(char *format1,char *format2)
{
	scan(format1,format2);
}
 
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

