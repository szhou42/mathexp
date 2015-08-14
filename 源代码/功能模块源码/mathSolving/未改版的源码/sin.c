#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<math.h>
#define MAX_SIZE 256
enum BOOL{FALSE,TRUE};

typedef struct tagOPERATE{
	double Operand;
	char Operator;
}OPERATE,*LPOPERATE;

void PostSrc(char *src,LPOPERATE lpOperator);
int IsDigit(char);
int isp(char ch); 
int icp(char ch);
int Locate(char ch);
int getOperand(char *s,int *len,double *oprd);
double Calculate(LPOPERATE lpOperator,double x);
void _Proc(char*src);

static char Operator[]="#(+-*/^";
static int InPriority[]={0,1,3,3,5,5,7};
static int OutPriority[]={0,10,2,2,4,4,6};

int Locate(char ch)	
{
	int i=0;
	for(i=0;Operator[i]!='\0';i++)
		if(Operator[i]==ch)
			return i;
		return -1;
		
}
//计算出运算符优先级
int isp(char ch)	
{
	if('A'<=ch && 'Z'>=ch)
		return 9;
	else
		return InPriority[Locate(ch)];
}

int icp(char ch)	
{
	if('A'<=ch && 'Z'>=ch)
		return 8;
	else
		return OutPriority[Locate(ch)];
}
//当遇到负数情况时的处理,如(-100)转化为(0-100)
void _Proc(char*src)
{
	char Buffer[MAX_SIZE];
	char*p=src,*q=Buffer;
	*q++=*p++;
	while('\0'!=*p)
	{
		if('-'==*p && '('==*(p-1))
		{
			*q++='0';
			*q++='-';
			p++;
		}
		else
			*q++=*p++;

	}
	*q='\0';
	strcpy(src,Buffer);
}
void SrcFunProc(char*src)
{
	char Buffer[MAX_SIZE];
	char*p=src,*q=Buffer;
	while(*p!='\0')
	{
		
		switch(*p)
		{
		case 's':	//  A for sin
			*q++='A';
			p+=3;
			break;
		case 'c':	// B for cos
			*q++='B';
			p+=3;
			break;
		case 'e':	//C for exp
			*q++='C';
			p+=3;
			break;
		case 'l':	
			if('n'==*(p+1))	//D for ln()
				*q++='D';
			else
				*q++='E';	//E for lg()	
			p+=2;
			break;
		case 't':	//F for tan()
			*q++='F';
			p+=3;
			break;
		default:
			*q++=*p++;
			break;
		}
	}
	*q='\0';
	strcpy(src,Buffer);
}
void PostSrc(char*src,LPOPERATE lpOperator)
{
	char *p=src,y;
	LPOPERATE lpOptr=lpOperator;
	char stack[MAX_SIZE];
	int top=-1; 
	double Operand;
	int offset=0;
	stack[++top]='#';

	while('\0'!=*p)
	{
		if(IsDigit(*p))
		{
			getOperand(p,&offset,&Operand);
			p+=offset;
			lpOptr->Operand=Operand;
			lpOptr->Operator=0;
			lpOptr++;
		}
		else
			if('x'==*p)
			{
				(lpOptr++)->Operator='x';
				p++;
			}
			else
				if('p'==*p)
				{
					lpOptr->Operand=3.14159266;
					p+=2;
					lpOptr->Operator=0;
					lpOptr++;
				}
				else
					if(')'==*p)
					{
						for(y=stack[top--];y!='(';y=stack[top--])
							(lpOptr++)->Operator=y;
						p++;
					}
					else
					{
						for(y=stack[top--];isp(y)>icp(*p);y=stack[top--])
							(lpOptr++)->Operator=y;
						stack[++top]=y;
						stack[++top]=*p++;
					}
					
					
	}
	while(top!=-1)
		(lpOptr++)->Operator=stack[top--];
}
int IsDigit(char ch)
{
	if(('0'<=ch&&'9'>=ch)||'.'==ch)
		return TRUE;
	return FALSE;
}
int getOperand(char *s,int *len,double *oprd){
	
	char *p = s,ch = *s++;
	double z = 0,x = 0;
	int bits = 0;
	int point = FALSE;
	while( IsDigit(ch) == TRUE){
		if (ch == '.'){
            if (point == TRUE) 
				return FALSE;
			point = TRUE;
		}
		else {
			if (point == TRUE){
				x *= 10;
				x += ch - '0';
				bits++;
			}
			else {
				z *= 10;
				z += ch - '0';
			}
		}
		ch = *s++;
	}
	while(bits-- > 0) x /= 10;
	z += x;
	*oprd = z;
	*len = s - p - 1;
	return TRUE;
}



double Calculate(LPOPERATE lpOperator,double x)
{
	double stack[MAX_SIZE],y1,y2;
	int top=-1;
	LPOPERATE lpOptr=lpOperator;
	stack[++top]=0;
	while(lpOptr->Operator!='#')
	{
		if(!lpOptr->Operator)
			stack[++top]=(lpOptr++)->Operand;
		else
			if('x'==lpOptr->Operator)
			{
				stack[++top]=x;
				lpOptr++;
			}
			
			else	
				switch ((lpOptr++)->Operator)
			{
				case '+':
					y1=stack[top--];
					y2=stack[top--];
					stack[++top]=y1+y2;
					break;
				case '-':
					y1=stack[top--];
					y2=stack[top--];
					stack[++top]=y2-y1;
					break;
				case '*':
					y1=stack[top--];
					y2=stack[top--];
					stack[++top]=y1*y2;
					break;
				case '/':
					y1=stack[top--];
					y2=stack[top--];
					stack[++top]=y2/y1;
					break;
				case '^':
					y1=stack[top--];
					y2=stack[top--];
					stack[++top]=pow(y2,y1);
					break;
				case 'A':
					y1=stack[top--];
					stack[++top]=sin(y1);
					break;
				case 'B':
					y1=stack[top--];
					stack[++top]=cos(y1);
					break;
				case 'C':
					y1=stack[top--];
					stack[++top]=exp(y1);
					break;
				case 'D':
					y1=stack[top--];
					stack[++top]=log(y1);
					break;
				case 'E':
					y1=stack[top--];
					stack[++top]=log10(y1);
					break;
				case 'F':
					y1=stack[top--];
					stack[++top]=tan(y1);
					break;
				default:
					break;
					
			}
	}
	return stack[top];
}
double Result(char *str)
{
	char src[MAX_SIZE];
	double d;
	OPERATE postsrc[MAX_SIZE];
	memset(src,0,MAX_SIZE);
    strcpy(src,str);

	_Proc(src);						//负数转换为减法
	PostSrc(src,postsrc);
	d=Calculate(postsrc,3.1415926);
	return d;
}