Attribute VB_Name = "Bubble"
Option Explicit
'系统托盘
Public Declare Function Shell_NotifyIcon Lib "shell32.dll" Alias "Shell_NotifyIconA" (ByVal dwMessage As Long, lpData As NOTIFYICONDATA) As Long
'---------- dwMessage可以是以下NIM_ADD、NIM_DELETE、NIM_MODIFY 标识符之一----------
Public Const NIM_ADD = &H0 '在任务栏中增加一个图标
Public Const NIM_DELETE = &H2 '删除任务栏中的一个图标
Public Const NIM_MODIFY = &H1 '修改任务栏中个图标信息

Public Const NIF_MESSAGE = &H1 'NOTIFYICONDATA结构中uFlags的控制信息
Public Const NIF_ICON = &H2
Public Const NIF_TIP = &H4
Public Const NIF_STATE = &H8
Public Const NIF_INFO = &H10


Public Const NIIF_NONE = &H0   '气泡提示类型
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
'系统托盘类型
Public Type NOTIFYICONDATA
    cbSize As Long '该数据结构的大小
    hwnd As Long '处理任务栏中图标的窗口句柄
    uID As Long '定义的任务栏中图标的标识
    uFlags As Long '任务栏图标功能控制，可以是以下值的组合（一般全包括）
'   NIF_MESSAGE 表示发送控制消息；
'   NIF_ICON表示显示控制栏中的图标；
'   NIF_TIP表示任务栏中的图标有动态提示。
    uCallbackMessage As Long '任务栏图标通过它与用户程序交换消息，处理该消息的窗口由hWnd决定
    hIcon As Long '任务栏中的图标的控制句柄
    szTip As String * 128 '图标的提示信息。若要产生气泡提示信息，则一定要128才性，为64则无法生成气泡，其它功能都正常，原因不明
   
    '气泡提示信息部分
    dwState As Long
    dwStateMask As Long
    szInfo As String * 256               '气泡提示内容
    uTimeout As Long                     '气泡提示显示时间
    szInfoTitle As String * 64           '气泡提示标题
    dwInfoFlags As Long                  '气泡提示类型，见 NIIF_*** 部分
End Type
'系统托盘变量
Private m_oNotifyIconData As NOTIFYICONDATA

Public Sub Unload_Bubble()
    Shell_NotifyIcon 2, m_oNotifyIconData
End Sub


Public Sub Make_Bubble()
    '生成系统托盘图标
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
        MsgBox "系统托盘气泡提示文字不得超过128个字符！"
        Exit Sub
    End If
    m_oNotifyIconData.szInfoTitle = "提示" & Chr(0)
    m_oNotifyIconData.szInfo = context & Chr(0)
    Shell_NotifyIcon NIM_MODIFY, m_oNotifyIconData
End Sub

