VERSION 5.00
Begin VB.Form InputHelper 
   Caption         =   "������ר��"
   ClientHeight    =   1335
   ClientLeft      =   17250
   ClientTop       =   9270
   ClientWidth     =   2835
   LinkTopic       =   "Form1"
   ScaleHeight     =   1335
   ScaleWidth      =   2835
   ShowInTaskbar   =   0   'False
   Begin VB.Timer Timer1 
      Interval        =   90
      Left            =   5520
      Top             =   240
   End
End
Attribute VB_Name = "InputHelper"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private Declare Function GetAsyncKeyState Lib "user32" (ByVal vKey As Long) As Integer
Private Declare Sub Sleep Lib "Kernel32" (ByVal dwMilliseconds As Long)
Private Declare Function GetWindowLong Lib "user32" Alias "GetWindowLongA" (ByVal hwnd As Long, ByVal nIndex As Long) As Long
Private Declare Function SetWindowLong Lib "user32" Alias "SetWindowLongA" (ByVal hwnd As Long, ByVal nIndex As Long, ByVal dwNewLong As Long) As Long
Private Declare Function SetLayeredWindowAttributes Lib "user32" (ByVal hwnd As Long, ByVal crKey As Long, ByVal bAlpha As Byte, ByVal dwFlags As Long) As Long


Const WM_CLOSE = &H10
Const WS_EX_LAYERED = &H80000
Const GWL_EXSTYLE = (-20)
Const LWA_COLORKEY = &H1


Private Sub Form_Load()
   '���ô���λ��
   Me.Top = Screen.Height - Me.Height
   Me.Left = Screen.Width - Me.Width
   '
   'ע��Hook��Ϣ
   WM_HXWDLLWX_QQBTX = RegisterWindowMessage("WM_HXWDLLWX_QQBTX")
   WM_HXWDLLWX_HOOKKEY = RegisterWindowMessage("WM_HXWDLLWX_HOOKKEY")
   hPrevWndProc = SetWindowLong(Me.hwnd, GWL_WNDPROC, AddressOf SubWndProc)
   DLLstartHOOK Me.hwnd
   DLLsetHOOKState True
   '����ĳ�ʼ��
   Call Make_Bubble
   ShockwaveFlash1.BackgroundColor = transcolor
   Me.BorderStyle = 0: Me.Caption = "": Me.Width = ShockwaveFlash1.Width: Me.Height = ShockwaveFlash1.Height: Me.BackColor = transcolor
   rtn = GetWindowLong(hwnd, GWL_EXSTYLE)
   rtn = rtn Or WS_EX_LAYERED
   SetWindowLong hwnd, GWL_EXSTYLE, rtn
   SetLayeredWindowAttributes hwnd, transcolor, 0, LWA_COLORKEY
   ShockwaveFlash1.WMode = 0
   ShockwaveFlash1.Playing = True
   ShockwaveFlash1.Loop = False
   ShockwaveFlash1.Move 0, 0
   PlayPet "2.swf"
   
End Sub

Private Sub Form_Unload(Cancel As Integer)
    '�ͷ���Դ
    Call Unload_Bubble
    DLLsetHOOKState False
    DLLstopHOOK
    Call SetWindowLong(Me.hwnd, GWL_WNDPROC, hPrevWndProc)
End Sub




Private Sub Timer1_Timer()
    '��������
    Dim ack As Integer
    If GetAsyncKeyState(VK_F1) Then
        bMode = 0
        DLLsetHOOKState True
        Show_Bubble "�ַ���ʽģʽ"
    ElseIf GetAsyncKeyState(VK_F2) Then
        bMode = 1
        DLLsetHOOKState True
        Show_Bubble "��ѧ���ų���ģʽ"
    ElseIf GetAsyncKeyState(VK_F3) Then
        bMode = 2
        DLLsetHOOKState True
        Show_Bubble "ʵʱ����ģʽ"
    ElseIf GetAsyncKeyState(VK_F4) Then
        bMode = 3
        DLLsetHOOKState True
        Show_Bubble "�������ģʽ"
    ElseIf GetAsyncKeyState(VK_HOME) Then
        bMode = 4
        DLLsetHOOKState False
    ElseIf GetAsyncKeyState(VK_ESCAPE) Then
        ack = MsgBox("�ر�С���:Yes �ر����:No", vbYesNo, "������ʾ:")
        If ack = vbYes Then PlayPet "end.swf"
        Show_Bubble "��첻����"
        If ack = vbNo Then Unload Me
    ElseIf GetAsyncKeyState(VK_F5) Then
        PlayPet "2.swf"
        Show_Bubble "����ֻ�����"
   ElseIf GetAsyncKeyState(VK_F6) Then
        add_data.Show
   End If
End Sub

Public Sub PlayPet(path As String)
   '����flash
   ShockwaveFlash1.Movie = App.path & "\" & path
   ShockwaveFlash1.Loop = False
   ShockwaveFlash1.Play
End Sub
