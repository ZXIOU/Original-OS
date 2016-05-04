char str[80]="2013_CS_class3_zhangxu_13349154";
char str1[100]="You will get the number of letters in the string.";
char str2[100]="The string is \"2013_CS_class3_zhangxu_13349154\".";
char str3[100]="The number of letters in the string is ";
char strNumber[5];
int LetterNumber=0;
int pid=0;

void CountLetter();
void printsum();
 
void fsprocess()
{
	pid=fork();
   	if (pid==-1)
	{
		printf("error in fork!");
		exit(-1);
	}
   	else if(pid)  
	{
        wait();
   		printsum();
   		exit(0) ;
	} 
	else 
	{
   		CountLetter();
   		exit(0);
	}
}

void CountLetter()
{
	int i;
	LetterNumber=0;
	for(i=0;i<80;i++)
	{
		if(str[i]=='\0')
		  break;
		else
		  LetterNumber++;	
	}
}

void printsum() 
{
	int temp=LetterNumber;
	int a=temp/10;
	int b=temp-a*10;
	strNumber[0]=a+48;
	strNumber[1]=b+48;
	strNumber[2]='\0';
	printf(&strNumber);
}

