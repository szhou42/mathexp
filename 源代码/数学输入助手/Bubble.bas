Attribute VB_Name = "Bubble"
Option Explicit
'ϵͳ����
Public Declare Function Shell_NotifyIcon Lib "shell32.dll" Alias "Shell_NotifyIconA" (ByVal dwMessage As Long, lpData As NOTIFYICONDATA) As Long
'---------- dwMessage����������NIM_ADD��NIM_DELETE��NIM_MODIFY ��ʶ��֮һ----------
Public Const NIM_ADD = &H0 '��������������һ��ͼ��
Public Const NIM_DELETE = &H2 'ɾ���������е�һ��ͼ��
Public Const NIM_MODIFY = &H1 '�޸��������и�ͼ����Ϣ

Public Const NIF_MESSAGE = &H1 'NOTIFYICONDATA�ṹ��uFlags�Ŀ�����Ϣ
Public Const NIF_ICON = &H2
Public Const NIF_TIP = &H4
Public Const NIF_STATE = &H8
Public Const NIF_INFO = &H10


Public Const NIIF_NONE = &H0   '������ʾ����
Public Const NIIF_WARNING = &H2
Public Const NIIF_ERROR = &H3
Public Const NIIF_INFO = &H1
Public Const NIIF_GUID = &H4

Public Const WM_LBUTTONDBLCLK = &H203
Public Const WM_LBUTTONDOWN = &H201
Public Const WM_LBUTTONUP = &H202
Public Const WM_MBUTTONDBLCLK = &H209
Public Const WM_MBUTTONDOWN = &H207
Public Const WM_MBUTTONUP = &H208
Public Const WM_RBUTTONDBLCLK = &H206
Public Const WM_RBUTTONDOWN = &H204
Public Const WM_RBUTTONUP = &H205
'ϵͳ��������
Public Type NOTIFYICONDATA
    cbSize As Long '�����ݽṹ�Ĵ�С
    hwnd As Long '������������ͼ��Ĵ��ھ��
    uID As Long '�������������ͼ��ı�ʶ
    uFlags As Long '������ͼ�깦�ܿ��ƣ�����������ֵ����ϣ�һ��ȫ������
'   NIF_MESSAGE ��ʾ���Ϳ�����Ϣ��
'   NIF_ICON��ʾ��ʾ�������е�ͼ�ꣻ
'   NIF_TIP��ʾ�������е�ͼ���ж�̬��ʾ��
    uCallbackMessage As Long '������ͼ��ͨ�������û����򽻻���Ϣ���������Ϣ�Ĵ�����hWnd����
    hIcon As Long '�������е�ͼ��Ŀ��ƾ��
    szTip As String * 128 'ͼ�����ʾ��Ϣ����Ҫ����������ʾ��Ϣ����һ��Ҫ128���ԣ�Ϊ64���޷��������ݣ��������ܶ�������ԭ����
   
    '������ʾ��Ϣ����
    dwState As Long
    dwStateMask As Long
    szInfo As String * 256               '������ʾ����
    uTimeout As Long                     '������ʾ��ʾʱ��
    szInfoTitle As String * 64           '������ʾ����
    dwInfoFlags As Long                  '������ʾ���ͣ��� NIIF_*** ����
End Type
'ϵͳ���̱���
Private m_oNotifyIconData As NOTIFYICONDATA

Public Sub Unload_Bubble()
    Shell_NotifyIcon 2, m_oNotifyIconData
End Sub


Public Sub Make_Bubble()
    '����ϵͳ����ͼ��
    With m_oNotifyIconData
        .cbSize = Len(m_oNotifyIconData)
        .hwnd = InputHelper.hwnd
        .uID = 0
        .uFlags = NIF_ICON Or NIF_INFO Or NIF_MESSAGE Or NIF_TIP
        .uCallbackMessage = WM_LBUTTONDOWN
        .hIcon = InputHelper.Icon
        .szTip = InputHelper.Caption & vbNullChar
    End With
    Shell_NotifyIcon NIM_ADD, m_oNotifyIconData
End Sub



Public Sub Show_Bubble(context As String)
    If Len(context) > 128 Then
        MsgBox "ϵͳ����������ʾ���ֲ��ó���128���ַ���"
        Exit Sub
    End If
    m_oNotifyIconData.szInfoTitle = "��ʾ" & Chr(0)
    m_oNotifyIconData.szInfo = context & Chr(0)
    Shell_NotifyIcon NIM_MODIFY, m_oNotifyIconData
End Sub

