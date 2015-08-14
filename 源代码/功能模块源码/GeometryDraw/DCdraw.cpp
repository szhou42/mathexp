#include <math.h>    
#include <io.h>    
#include <string>    
#include <fstream>    
#include <iostream>    
#include <stdio.h>    
#include <Windows.h>    
#include <atlimage.h>    
using namespace std;   

//画布大小
#define BitWidth 200  
#define BitHeight 200    
//平面图
#define SQUARE   0
#define RECT     1
#define CIRCLE   2
#define TRIANGLE 3
#define DIAMOND  4
#define PARALLELOGRAM 5
#define LADDER 6
#define SECTOR 7
//立体图
#define CUBE 8
#define CUBOID 9
//等等…………

/***********************************************************************************************
*函数名 ：       GetCurve
*函数功能描述 ： 画几何，立体图形
*函数参数 ：     GeometryFigure:
			    要画什么样的图形(见文件顶部定义的常量)
			    arg1/2/3/4:
			    根据不同的图形所需求的参数，如半径 棱长
*函数返回值 ：   位图句柄
***********************************************************************************************/
HBITMAP GetCurve(int GeometryFigure,int arg1,int arg2,int arg3,int arg4)  
{   
	//初始化
    HBITMAP hBitmap;   
	HBRUSH brush2=NULL;
    HDC hBufDC;    
    HBITMAP hBitTemp;          
    HDC hDC = GetDC(NULL);   
    hBufDC = CreateCompatibleDC(hDC);     
    SetBkMode(hBufDC,TRANSPARENT);  
	
    hBitmap = CreateCompatibleBitmap(hDC, BitWidth, BitHeight);    
    hBitTemp = (HBITMAP) SelectObject(hBufDC, hBitmap);    

	//创建白色画笔(边框颜色)
    HPEN pen = CreatePen(PS_SOLID,1,RGB(255,255,255));		
	//创建字体类型
    HFONT hfnt = CreateFont(50,50,0,0,400,0,0,0,						
        DEFAULT_CHARSET,OUT_TT_PRECIS,CLIP_TT_ALWAYS,        
        PROOF_QUALITY   ,DEFAULT_PITCH,"隶书");      
	//创建白色刷子
	HBRUSH brush = CreateSolidBrush(RGB(255,255,255));					
	//并入HDC
    SelectObject(hBufDC,pen);											
    SelectObject(hBufDC,brush);											
	SelectObject(hBufDC,hfnt);												
    SetTextColor(hBufDC, RGB(145,44,238));								
   
	//使白色矩形充满画布(把背景颜色弄成白的)
	Rectangle(hBufDC,0,0,BitWidth,BitHeight);	
	//画真正内容的时候换成黑色画笔
	SelectObject(hBufDC,CreatePen(PS_SOLID,1,RGB(0,0,0)));
	//用户要我画什么就画什么
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
*函数名 ： DrawGeometryFigure
*函数功能描述 ： 画几何，立体图形
*函数参数 ： szFileName:
			画出来的几何图形文件的保存路径
			GeometryFigure:
			要画什么样的图形(见文件顶部定义的常量)
			arg1/2/3/4:
			根据不同的图形所需求的参数，如半径 棱长
*函数返回值 ： 无意义
***********************************************************************************************/

int WINAPI DrawGeometryFigure(LPSTR szFileName,int GeometryFigure,int arg1,int arg2,int arg3,int arg4)
{
    HBITMAP myHbitmap = GetCurve(GeometryFigure,arg1,arg2,arg3,arg4);   
    CImage   m_image;      
    m_image.Attach(myHbitmap);      
    m_image.Save(szFileName);   
    return 0;   	
	
}