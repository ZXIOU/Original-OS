char Message1[17]="Original OS 1.0";  
char Message2[26]="(c) 2015 ZX Corporation.";
char Message3[14]="User:\\ZXIOU>";
char Message4[20]="Instruction error!";
char Message5[26]="Input exceeds the limit!";
char Message6[26]="It's been shutdowning...";
char order[100];
Judge()
{
	if(order[0]=='r'&&order[1]=='u'&&order[2]=='n'&&order[3]==' '&&order[4]=='p'&&order[5]=='r'&&order[6]=='o'&&order[7]=='c')
	{
		if(order[8]=='1'&&order[9]==13)
		  proc1();
		if(order[8]=='2'&&order[9]==13)
		  proc2();
		if(order[8]=='3'&&order[9]==13)
		  proc3();
	}
	else if(order[0]=='r'&&order[1]=='e'&&order[2]=='s'&&order[3]=='t'&&order[4]=='a'&&order[5]=='r'&&order[6]=='t'&&order[7]==13)
	     restart();
	else if(order[0]=='s'&&order[1]=='h'&&order[2]=='u'&&order[3]=='t'&&order[4]=='d'&&order[5]=='o'&&order[6]=='w'&&order[7]=='n'&&order[8]==13)
	     shutdown();
	else if(order[0]=='t'&&order[1]=='i'&&order[2]=='m'&&order[3]=='e'&&order[4]==13)
	     time();
	else if(order[0]=='h'&&order[1]=='e'&&order[2]=='l'&&order[3]=='p'&&order[4]==13)
	     help();
}

ClearOrder()
{
	order[0]='\0';
}

Main()
{
	clear1();
	str();
	in();	
}
