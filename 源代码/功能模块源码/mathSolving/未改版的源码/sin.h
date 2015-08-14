#include<stdio.h>
#include<stdlib.h>
#include<string.h>
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