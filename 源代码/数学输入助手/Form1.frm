VERSION 5.00
Begin VB.Form InputHelper 
   Caption         =   "理工输入专家"
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
   '设置窗口位置
   Me.Top = Screen.Height - Me.Height
   Me.Left = Screen.Width - Me.Width
   '
   '注册Hook消息
   WM_HXWDLLWX_QQBTX = RegisterWindowMessage("WM_HXWDLLWX_QQBTX")
   WM_HXWDLLWX_HOOKKEY = RegisterWindowMessage("WM_HXWDLLWX_HOOKKEY")
   hPrevWndProc = SetWindowLong(Me.hwnd, GWL_WNDPROC, AddressOf SubWndProc)
   DLLstartHOOK Me.hwnd
   DLLsetHOOKState True
   '界面的初始化
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
    '释放资源
    Call Unload_Bubble
    DLLsetHOOKState False
    DLLstopHOOK
    Call SetWindowLong(Me.hwnd, GWL_WNDPROC, hPrevWndProc)
End Sub




Private Sub Timer1_Timer()
    '保留后用
    Dim ack As Integer
    If GetAsyncKeyState(VK_F1) Then
        bMode = 0
        DLLsetHOOKState True
        Show_Bubble "字符公式模式"
    ElseIf GetAsyncKeyState(VK_F2) Then
        bMode = 1
        DLLsetHOOKState True
        Show_Bubble "数学符号成像模式"
    ElseIf GetAsyncKeyState(VK_F3) Then
        bMode = 2
        DLLsetHOOKState True
        Show_Bubble "实时计算模式"
    ElseIf GetAsyncKeyState(VK_F4) Then
        bMode = 3
        DLLsetHOOKState True
        Show_Bubble "方程求解模式"
    ElseIf GetAsyncKeyState(VK_HOME) Then
        bMode = 4
        DLLsetHOOKState False
    ElseIf GetAsyncKeyState(VK_ESCAPE) Then
        ack = MsgBox("关闭小企鹅:Yes 关闭软件:No", vbYesNo, "助手提示:")
        If ack = vbYes Then PlayPet "end.swf"
        Show_Bubble "企鹅不见咯"
        If ack = vbNo Then Unload Me
    ElseIf GetAsyncKeyState(VK_F5) Then
        PlayPet "2.swf"
        Show_Bubble "企鹅又回来咯"
   ElseIf GetAsyncKeyState(VK_F6) Then
        add_data.Show
   End If
End Sub

Public Sub PlayPet(path As String)
   '播放flash
   ShockwaveFlash1.Movie = App.path & "\" & path
   ShockwaveFlash1.Loop = False
   ShockwaveFlash1.Play
End Sub
