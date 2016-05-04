#include <stdio.h> 
char Message1[17]="Original OS 1.0";  
char Message2[26]="(c) 2015 ZX Corporation.";
char Message3[14]="User:\\ZXIOU>";
char Message4[20]="Instruction error!";
char Message5[26]="Input exceeds the limit!";
char Message6[26]="It's been shutdowning...";
char Message7[41]="Please enter a character(use getch()): ";
char Message8[40]="Outputing the character(use putch()): ";
char Message9[47]="Please enter a character string(use gets()): ";
char Message10[46]="Outputing the character string(use puts()): ";
char Message11[56]="Outputing the lower character string(use upptolow()): ";
char Message12[56]="Outputing the lower character string(use lowtoupp()): ";
char Message13[40]="You can press the Enter key to return.";
char Message14[6]="ouch";
char order[100];
char ch;
char string[100];

typedef struct RegisterImage{
	int SS;
	int GS;
	int FS;
	int ES;
	int DS;
	int DI;
	int SI;
	int BP;
	int SP;
	int BX;
	int DX;
	int CX;
	int AX;
	int IP;
	int CS;
	int FLAGS;
}RegisterImage;

typedef struct PCB{
	RegisterImage regImg;
	int Process_Status;
}PCB;

void Judge(); 
void ClearOrder();
void Save_Process(int,int,int,int,int,int,int,int,int,int,int,int,int,int,int,int);
void Run_Process();
PCB* Current_Process();
void init(PCB* pcb,int segement, int offset);
void init_PCB();
void special();

PCB pcb_list[4];
;int pcbStartFlag=0;
int saveNumber=0;
int runNumber=0;
int NEW=0;
int RUNNING=1;

void Main()
{
	clear1();
	init_PCB(); 
	str();
	in();	
}

void Save_Process(int gs,int fs,int es,int ds,int di,int si,int bp,int sp,
			int dx,int cx,int bx,int ax,int ss,int ip,int cs,int flags)
{
	pcb_list[saveNumber].regImg.AX = ax;
	pcb_list[saveNumber].regImg.BX = bx;
	pcb_list[saveNumber].regImg.CX = cx;
	pcb_list[saveNumber].regImg.DX = dx;

	pcb_list[saveNumber].regImg.DS = ds;
	pcb_list[saveNumber].regImg.ES = es;
	pcb_list[saveNumber].regImg.FS = fs;
	pcb_list[saveNumber].regImg.GS = gs;
	pcb_list[saveNumber].regImg.SS = ss;

	pcb_list[saveNumber].regImg.IP = ip;
	pcb_list[saveNumber].regImg.CS = cs;
	pcb_list[saveNumber].regImg.FLAGS = flags;
	
	pcb_list[saveNumber].regImg.DI = di;
	pcb_list[saveNumber].regImg.SI = si;
	pcb_list[saveNumber].regImg.SP = sp;
	pcb_list[saveNumber].regImg.BP = bp;
	saveNumber++;
	if(saveNumber==4)
	  saveNumber=0;	
}

void Run_Number()
{
	runNumber++;
	if(runNumber==4)
	  runNumber=0; 
}

void init(PCB* pcb,int segement, int offset)
{
	pcb->regImg.GS = 0xb800;
	pcb->regImg.SS = segement;
	pcb->regImg.ES = segement;
	pcb->regImg.DS = segement;
	pcb->regImg.CS = segement;
	pcb->regImg.FS = segement;
	pcb->regImg.IP = offset;
	pcb->regImg.SP = offset - 4;
	pcb->regImg.AX = 0;
	pcb->regImg.BX = 0;
	pcb->regImg.CX = 0;
	pcb->regImg.DX = 0;
	pcb->regImg.DI = 0;
	pcb->regImg.SI = 0;
	pcb->regImg.BP = 0;
	pcb->regImg.FLAGS = 512;
	pcb->Process_Status = NEW;
}

void init_PCB()
{
	init(&pcb_list[0],0x1000,0x100);
	init(&pcb_list[1],0x2000,0x100);
	init(&pcb_list[2],0x3000,0x100);
	init(&pcb_list[3],0x4000,0x100);
}

PCB* Current_Process()
{
	return &pcb_list[runNumber];
}

void special()
{
	if(pcb_list[runNumber].Process_Status==NEW)
		pcb_list[runNumber].Process_Status=RUNNING;
}

void Judge()
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
	else if(order[0]=='i'&&order[1]=='n'&&order[2]=='t'&&order[3]==13)
	     newint();
	else if(order[0]=='g'&&order[1]=='e'&&order[2]=='t'&&order[3]=='p'&&order[4]=='u'&&order[5]=='t'&&order[6]==13)
	     getput();
	else if(order[0]=='t'&&order[1]=='h'&&order[2]=='r'&&order[3]=='e'&&order[4]=='a'&&order[5]=='d'&&order[6]==13)
		 Multi_thread();
}

void ClearOrder()
{
	order[0]='\0';
}
