//������̷����ʼ�
/*

VB����dllִ��DLLMain():
	��RegisterWindowMessageע�ᵥ�ַ���Ϣ����ַ���Ϣ
	����HookApi()��hook���뷨������ȡ�û��������������:
		��������ǰ5���ֽ��滻��JMP �º�����ַ

VB����DLLstartHOOK()�����Լ��Ĵ��ھ������dll,�Ա�����ַ������ַ�	

VB����DLLsetHOOKState True����ʼhook:
	DLLsetHOOKState True�ڵ���sethook()����ʼhook:
		����һ��ȫ��hook�����м�����Ϣ������KeyboardProc:
			�յ��ַ���Ϣ��ʱ��ͷ���VB

����ǰ�潲��,���뷨������ȡ�û���������������Ѿ���hook�ˣ����Խ��������ǾͿ����������������Ʒ��
Ҳ����myImmGetCompositionStringA��myImmGetCompositionStringW
myImmGetCompositionStringA:
	�������:�����뷨��ǰ���ַ����ŵ�g_IMEString��(Ascii��)	
	�ڲ�����:(��ʱ��)
		
myImmGetCompositionStringW:
	�������:�����뷨��ǰ���ַ����ŵ�g_IMEString��(Unicode��)
	�ڲ�����:(��ʱ��)	
		
*/
#include <windows.h>
#include <stdio.h>
#include <stdlib.h>
#pragma comment(lib,"imm32.lib")

#pragma data_seg("mysechx")
HHOOK g_hKeyboard=NULL;
HWND g_hMainhWnd=NULL;
char g_IMEString[256]="";
bool g_HOOKflag=false;
#pragma data_seg()

class clsHookInfo
{
private:
	BYTE mbytOldCode[5];
	BYTE mbytNewCode[5];
	int mlngFunAddr;
	bool hookBeOK;
public:
	bool HookApi(LPCTSTR strDllName,LPCTSTR strFunName,int lngFunAddr)
	{
		hookBeOK=false;
		HMODULE hModule=NULL;
		int dwJmpAddr=0;
		hModule=GetModuleHandle(strDllName);					//�õ�dll��ַ
		if (hModule==NULL) {return false;}
		mlngFunAddr=(int)GetProcAddress(hModule,strFunName);	//�õ�������ַ
		if (mlngFunAddr==NULL) {return false;}
		CopyMemory(mbytOldCode,(const void *)mlngFunAddr,5);	//�Ѻ�����ǰ5���ֽڱ�������
		mbytNewCode[0]=0xE9;									//E9��jmp
		dwJmpAddr=lngFunAddr-mlngFunAddr-5;						//�����ԭAPI����API��ƫ��
		CopyMemory(&mbytNewCode[1],&dwJmpAddr,4);				//��ָ���滻��
		hookBeOK=true;
		HookStatus(true);										//hook,Ok
		return true;
	}
	bool HookStatus(bool blnIsHook)
	{
		DWORD oldACC,newACC;
		if (!hookBeOK) {return false;}
		if (blnIsHook)
		{
			VirtualProtect((LPVOID)mlngFunAddr,5,PAGE_WRITECOPY,&oldACC);
			CopyMemory((void *)mlngFunAddr,mbytNewCode,5);
			VirtualProtect((LPVOID)mlngFunAddr,5,oldACC,&newACC);
		}
		else
		{
			VirtualProtect((LPVOID)mlngFunAddr,5,PAGE_WRITECOPY,&oldACC);
			CopyMemory((void *)mlngFunAddr,mbytOldCode,5);
			VirtualProtect((LPVOID)mlngFunAddr,5,oldACC,&newACC);
		}
		return true;
	}
};

clsHookInfo g_myHOOK1;
clsHookInfo g_myHOOK2;
char g_StringBuf1[256]="";
char g_StringBuf2[256]="";
UINT WM_HXWDLLWX_QQBTX=NULL;
UINT WM_HXWDLLWX_HOOKKEY=NULL;
HWND protect=NULL;

BOOL MByteToWChar(LPCSTR lpcszStr,LPWSTR lpwszStr,DWORD dwSize)
{
    DWORD dwMinSize;
    dwMinSize = MultiByteToWideChar(CP_ACP, 0, lpcszStr, -1, NULL, 0);
    if(dwSize < dwMinSize)
    {
     return FALSE;
    }
    MultiByteToWideChar (CP_ACP, 0, lpcszStr, -1, lpwszStr, dwMinSize); 
    return TRUE;
}

BOOL WCharToMByte(LPCWSTR lpcwszStr,LPSTR lpszStr,DWORD dwSize)
{
   DWORD dwMinSize;
   dwMinSize = WideCharToMultiByte(CP_OEMCP,NULL,lpcwszStr,-1,NULL,0,NULL,FALSE);
   if(dwSize < dwMinSize)
   {
    return FALSE;
   }
   WideCharToMultiByte(CP_OEMCP,NULL,lpcwszStr,-1,lpszStr,dwSize,NULL,FALSE);
   return TRUE;
}


LONG WINAPI myImmGetCompositionStringA(HIMC hIMC, DWORD dwIndex, LPVOID lpBuf, DWORD dwBufLen)
{
	//MessageBox(NULL,hIMC,hIMC,MB_OK);
	LONG myReturn=0;
	LONG tempLen=0;
	int StrBufLen=0;
	if (dwIndex==GCS_RESULTSTR && g_HOOKflag)
	{
		memset(g_IMEString,0,256);
		tempLen=255;
		g_myHOOK1.HookStatus(false);
		ImmGetCompositionStringA(hIMC,GCS_RESULTSTR,g_IMEString,tempLen);
		g_myHOOK1.HookStatus(true);
		g_IMEString[tempLen]=0;
		if (lstrcmp(g_IMEString,g_StringBuf1)!=0)//���g_IMEString������g_StringBuf1(���Ǹ��ϴβ����)
		{
			memset(g_StringBuf1,0,256);
			lstrcpy(g_StringBuf1,g_IMEString);
			
			SendMessage(g_hMainhWnd,WM_HXWDLLWX_QQBTX,0,0);
			
			memset(g_StringBuf2,0,256);
			lstrcpy(g_StringBuf2,g_IMEString);
		}
		if (lpBuf==NULL || dwBufLen==0)
		{
			myReturn=lstrlen(g_StringBuf2);  //���û�ַ�������û���Ⱦ�ֱ�ӷ��� ���ֲ����� Ҳ���ѿ���Ȩ�����뷨
		}
		else
		{
			StrBufLen=lstrlen(g_StringBuf2);
			memset(lpBuf,0,dwBufLen);
			if (dwBufLen>=StrBufLen) 
			{
				dwBufLen=StrBufLen;
				myReturn=StrBufLen;
			}
			else
			{
				myReturn=0;
			}
			memcpy(lpBuf,g_StringBuf2,dwBufLen);
		}
	}
	else
	{
		g_myHOOK1.HookStatus(false);
		myReturn=ImmGetCompositionStringA(hIMC,dwIndex,lpBuf,dwBufLen);//����dwIndex����GCS_RESULTSTR�Ͳ��ܶ�����ֻ�ܻ������뷨�Լ�������
		g_myHOOK1.HookStatus(true);
	}
	return myReturn;
}

LONG WINAPI myImmGetCompositionStringW(HIMC hIMC, DWORD dwIndex, LPVOID lpBuf, DWORD dwBufLen)
{
	LONG myReturn=0;
	LONG tempLen=0;
	int StrBufLen=0;
	if (dwIndex==GCS_RESULTSTR && g_HOOKflag)
	{
		memset(g_IMEString,0,256);
		tempLen=254;
		g_myHOOK2.HookStatus(false);
		ImmGetCompositionStringW(hIMC,GCS_RESULTSTR,g_IMEString,tempLen);
		g_myHOOK2.HookStatus(true);
		g_IMEString[254]=0;
		g_IMEString[255]=0;
		if (lstrcmpW((wchar_t *)g_IMEString,(wchar_t *)g_StringBuf1)!=0)
		{
			memset(g_StringBuf1,0,256);
			lstrcpyW((wchar_t *)g_StringBuf1,(wchar_t *)g_IMEString);
			WCharToMByte((wchar_t *)g_StringBuf1,g_IMEString,256);
			SendMessage(g_hMainhWnd,WM_HXWDLLWX_QQBTX,0,0);
			memset(g_StringBuf2,0,256);
			MByteToWChar(g_IMEString,(wchar_t *)g_StringBuf2,128);
		}
		if (lpBuf==NULL || dwBufLen==0)
		{
			myReturn=lstrlenW((wchar_t *)g_StringBuf2)*2;
		}
		else
		{
			StrBufLen=lstrlenW((wchar_t *)g_StringBuf2)*2;
			memset(lpBuf,0,dwBufLen);
			if (dwBufLen>=StrBufLen) 
			{
				dwBufLen=StrBufLen;
				myReturn=StrBufLen;
			}
			else
			{
				myReturn=0;
			}
			memcpy(lpBuf,g_StringBuf2,dwBufLen);
		}
	}
	else
	{
		g_myHOOK2.HookStatus(false);
		myReturn=ImmGetCompositionStringW(hIMC,dwIndex,lpBuf,dwBufLen);
		g_myHOOK2.HookStatus(true);
	}
	return myReturn;
}


BOOL WINAPI DllMain(HINSTANCE hinstDLL,DWORD fdwReason,LPVOID lpvReserved)
{
   FILE *f = NULL;
   char *name = "C:\\Users\\administrator\\Desktop\\temp";
   switch(fdwReason)
    {
      case DLL_PROCESS_ATTACH:
		f = fopen(name,"r");
		if (f!=NULL)
		{
		  WM_HXWDLLWX_QQBTX=RegisterWindowMessage("WM_HXWDLLWX_QQBTX");//ע���Զ�����Ϣ
		  WM_HXWDLLWX_HOOKKEY=RegisterWindowMessage("WM_HXWDLLWX_HOOKKEY");//ע���Զ�����Ϣ
		  g_myHOOK1.HookApi("imm32.dll","ImmGetCompositionStringA",(int)myImmGetCompositionStringA);//�����뷨����ȡ���û������ַ����ĺ�������
		  g_myHOOK2.HookApi("imm32.dll","ImmGetCompositionStringW",(int)myImmGetCompositionStringW);//�����뷨����ȡ���û������ַ����ĺ�������
	   	  fclose(f);
		}
        break;
	  case DLL_THREAD_ATTACH:
		 break;
	  case DLL_THREAD_DETACH:
		 break;
      case DLL_PROCESS_DETACH:
		  g_myHOOK1.HookStatus(false);
		  g_myHOOK2.HookStatus(false);
        break;
      default:
        break;
    }
	return true;
}


LRESULT CALLBACK KeyboardProc(int code,WPARAM wParam,LPARAM lParam)
{
	CWPSTRUCT * winMSG;
	if (code==0 && g_HOOKflag)             //�Ѿ���ʼhook��						����code=0 =>code=HC_ACTION =>wParam��lParam����������Ϣ 
	{
		winMSG=(CWPSTRUCT *)lParam;
		if (winMSG->message==WM_IME_CHAR)
		{
			SendMessage(g_hMainhWnd,WM_HXWDLLWX_HOOKKEY,winMSG->wParam,winMSG->lParam);
		}
	}
	return CallNextHookEx(g_hKeyboard,code,wParam,lParam);
}

void setHOOK()
{
	g_hKeyboard=SetWindowsHookEx(WH_CALLWNDPROC,KeyboardProc,GetModuleHandle("hxwdllwx.dll"),0);
}

int WINAPI DLLstartHOOK(HWND myhWnd)
{
	if (g_hMainhWnd==NULL)
	{
		g_hMainhWnd=myhWnd;
	}
	return 1;
}

int WINAPI DLLstopHOOK()
{
	if (g_hKeyboard!=NULL)
	{
		UnhookWindowsHookEx(g_hKeyboard);
		g_hKeyboard=NULL;
	}
	return 1;
}

int WINAPI DLLsetHOOKState(bool myState)
{
	if (myState)
	{
		if (g_hKeyboard==NULL)//���Ҫ����Ӽ��̵���û��ʼ���Ӽ��̾Ϳ�ʼ��
		{
			setHOOK();
		}
		g_HOOKflag=true;
	}
	else
	{
		g_HOOKflag=false;
	}
	return 1;
}

LPCTSTR WINAPI DLLGetPubString()			//������˵�������:����һ�οռ���ַ�������ȥ �ٰ���οռ�ĵ�ַ���ص�VB
{
	char tmpStr[258]="";
	lstrcpy(tmpStr,g_IMEString);
	tmpStr[256]=0;
	tmpStr[257]=0;
	return (LPCTSTR)SysAllocString((const OLECHAR *)tmpStr);//������˵�������: �����ַ��� Ȼ�������ָ�����ַ�������ȥ
}

int WINAPI DLLSetPubString(LPCTSTR tmpStr)
{
	memset(g_IMEString,0,256);
	if (lstrlen(tmpStr)>255)
	{
		lstrcpyn(g_IMEString,tmpStr,256);
	}
	else
	{
		lstrcpy(g_IMEString,tmpStr);
	}
	return 1;
}

