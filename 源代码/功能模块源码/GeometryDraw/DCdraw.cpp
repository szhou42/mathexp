#include <math.h>    
#include <io.h>    
#include <string>    
#include <fstream>    
#include <iostream>    
#include <stdio.h>    
#include <Windows.h>    
#include <atlimage.h>    
using namespace std;   

//������С
#define BitWidth 200  
#define BitHeight 200    
//ƽ��ͼ
#define SQUARE   0
#define RECT     1
#define CIRCLE   2
#define TRIANGLE 3
#define DIAMOND  4
#define PARALLELOGRAM 5
#define LADDER 6
#define SECTOR 7
//����ͼ
#define CUBE 8
#define CUBOID 9
//�ȵȡ�������

/***********************************************************************************************
*������ ��       GetCurve
*������������ �� �����Σ�����ͼ��
*�������� ��     GeometryFigure:
			    Ҫ��ʲô����ͼ��(���ļ���������ĳ���)
			    arg1/2/3/4:
			    ���ݲ�ͬ��ͼ��������Ĳ�������뾶 �ⳤ
*��������ֵ ��   λͼ���
***********************************************************************************************/
HBITMAP GetCurve(int GeometryFigure,int arg1,int arg2,int arg3,int arg4)  
{   
	//��ʼ��
    HBITMAP hBitmap;   
	HBRUSH brush2=NULL;
    HDC hBufDC;    
    HBITMAP hBitTemp;          
    HDC hDC = GetDC(NULL);   
    hBufDC = CreateCompatibleDC(hDC);     
    SetBkMode(hBufDC,TRANSPARENT);  
	
    hBitmap = CreateCompatibleBitmap(hDC, BitWidth, BitHeight);    
    hBitTemp = (HBITMAP) SelectObject(hBufDC, hBitmap);    

	//������ɫ����(�߿���ɫ)
    HPEN pen = CreatePen(PS_SOLID,1,RGB(255,255,255));		
	//������������
    HFONT hfnt = CreateFont(50,50,0,0,400,0,0,0,						
        DEFAULT_CHARSET,OUT_TT_PRECIS,CLIP_TT_ALWAYS,        
        PROOF_QUALITY   ,DEFAULT_PITCH,"����");      
	//������ɫˢ��
	HBRUSH brush = CreateSolidBrush(RGB(255,255,255));					
	//����HDC
    SelectObject(hBufDC,pen);											
    SelectObject(hBufDC,brush);											
	SelectObject(hBufDC,hfnt);												
    SetTextColor(hBufDC, RGB(145,44,238));								
   
	//ʹ��ɫ���γ�������(�ѱ�����ɫŪ�ɰ׵�)
	Rectangle(hBufDC,0,0,BitWidth,BitHeight);	
	//���������ݵ�ʱ�򻻳ɺ�ɫ����
	SelectObject(hBufDC,CreatePen(PS_SOLID,1,RGB(0,0,0)));
	//�û�Ҫ�һ�ʲô�ͻ�ʲô
	switch(GeometryFigure)
	{
	case SQUARE:
			Rectangle(hBufDC,(BitWidth-arg1)/2,(BitHeight-arg1)/2,BitWidth-(BitWidth-arg1)/2,BitHeight-(BitHeight-arg1)/2);
		break;
	case RECT:
			Rectangle(hBufDC,(BitWidth-arg1)/2,(BitHeight-arg2)/2,BitWidth-(BitWidth-arg1)/2,BitHeight-(BitHeight-arg2)/2);
		break;
	case CIRCLE:
			Ellipse(hBufDC,10,10,10,10);
		break;		
	case 
		TRIANGLE:
			
		break;
	}
    return hBitmap;   
}   
   
   

/***********************************************************************************************
*������ �� DrawGeometryFigure
*������������ �� �����Σ�����ͼ��
*�������� �� szFileName:
			�������ļ���ͼ���ļ��ı���·��
			GeometryFigure:
			Ҫ��ʲô����ͼ��(���ļ���������ĳ���)
			arg1/2/3/4:
			���ݲ�ͬ��ͼ��������Ĳ�������뾶 �ⳤ
*��������ֵ �� ������
***********************************************************************************************/

int WINAPI DrawGeometryFigure(LPSTR szFileName,int GeometryFigure,int arg1,int arg2,int arg3,int arg4)
{
    HBITMAP myHbitmap = GetCurve(GeometryFigure,arg1,arg2,arg3,arg4);   
    CImage   m_image;      
    m_image.Attach(myHbitmap);      
    m_image.Save(szFileName);   
    return 0;   	
	
}