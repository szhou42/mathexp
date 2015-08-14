Attribute VB_Name = "Robber"
Option Explicit
Public Declare Function RegisterWindowMessage Lib "user32" Alias "RegisterWindowMessageA" (ByVal lpString As String) As Long
' ------------------------系统API-----------------------------
Public Declare Function SetWindowLong Lib "user32" Alias "SetWindowLongA" (ByVal hwnd As Long, ByVal nIndex As Long, ByVal dwNewLong As Long) As Long
Public Declare Function CallWindowProc Lib "user32" Alias "CallWindowProcA" (ByVal lpPrevWndFunc As Long, ByVal hwnd As Long, ByVal Msg As Long, ByVal wParam As Long, ByVal lParam As Long) As Long
Public Declare Sub Sleep Lib "Kernel32" (ByVal dwMilliseconds As Long)
' ------------------------DLL导出函数-------------------------
Public Declare Function DLLstartHOOK Lib "hxwdllwx.dll" (ByVal hwnd As Long) As Long
Public Declare Function DLLstopHOOK Lib "hxwdllwx.dll" () As Long
Public Declare Function DLLsetHOOKState Lib "hxwdllwx.dll" (ByVal myState As Boolean) As Long
Public Declare Function DLLGetPubString Lib "hxwdllwx.dll" () As String
Public Declare Function DLLSetPubString Lib "hxwdllwx.dll" (ByVal tmpstr As String) As Long
Private Declare Function Result Lib "mathSolving.dll" (ByVal pstr As String) As Double
Private Declare Function CreateGifFromEq Lib "MimeTex.dll" (ByVal latex As String, ByVal gif As String) As Long
Private Declare Function DrawGeometryFigure Lib "GeometryDraw.dll" (ByVal szFileName As String, ByVal Figure As Long, ByVal arg1 As Long, ByVal arg2 As Long, ByVal arg3 As Long, ByVal arg4 As Long) As Long

' ------------------------用到的常量和变量--------------------
Public Const GWL_WNDPROC = -4
Public WM_HXWDLLWX_QQBTX As Long
Public WM_HXWDLLWX_HOOKKEY As Long
Public hPrevWndProc As Long
Public bMode As Long
Public Const WM_USER = &H400
Public Const TRAY_CALLBACK = (WM_USER + 1001)

' ------------------------自己写的窗口过程--------------------

Public Function SubWndProc(ByVal hwnd As Long, ByVal Msg As Long, ByVal wParam As Long, ByVal lParam As Long) As Long
    On Error Resume Next
    '截获信息
    Dim tmpS As String
    Dim sequence As String, tmpSeq As String, seqFinal As String, num As String
    Dim convertion As String, context As String, leftBra As Integer, rigBra As Integer, size As Integer, x As String
    Dim fs As New FileSystemObject
    Dim i As Long
    Dim semicolon  As Integer
    
    x = ""
    Debug.Print "windows proc"
    If Msg = WM_HXWDLLWX_QQBTX Then
        tmpS = DLLGetPubString()
    Debug.Print "windows proc->hook message"
        If Left(tmpS, 5) = "calc-" Then
            tmpS = CStr(Result(Mid(tmpS, 6)))
            DLLSetPubString tmpS
            GoTo theEnd
        End If
        
        If Left(tmpS, 5) = "unyt-" Then
            '得到除"unit-"之外的字符串
            '获取括号中的字符串,如果是cm-m的话 就将括号后面的数值除以100
            convertion = Mid(tmpS, 6)
            leftBra = InStr(convertion, "(")
            rigBra = InStr(convertion, ")")
            size = rigBra - leftBra - 1
            context = Mid(convertion, leftBra + 1, size)
            If context = "cm-m" Then
                x = Mid(convertion, rigBra + 1)
                x = Left(x, Len(x)) & "/100"
                context = CStr(Result(x))
            End If
            DLLSetPubString context
        End If
        
        If Left(tmpS, 5) = "covt-" Then
            convertion = Mid(tmpS, 6)
            leftBra = InStr(convertion, "(")
            rigBra = InStr(convertion, ")")
            size = rigBra - leftBra - 1
            context = Mid(convertion, leftBra + 1, size)
            If context = "10-2" Then
                x = Mid(convertion, rigBra + 1)
                context = Dec2Bin(x)
            End If
            
            If context = "2-10" Then
                x = Mid(convertion, rigBra + 1)
                context = Bin2Dec(x)
            End If
            
            If context = "10-16" Then
                x = Mid(convertion, rigBra + 1)
                context = Dec2Hex(x)
            End If
            
            If context = "16-10" Then
                x = Mid(convertion, rigBra + 1)
                context = Hex2Dec(x)
            End If
            
            If context = "2-16" Then
                x = Mid(convertion, rigBra + 1)
                context = Bin2Hex(x)
            End If

            If context = "16-2" Then
                x = Mid(convertion, rigBra + 1)
                context = Hex2Bin(x)
            End If
            
            DLLSetPubString context
            GoTo theEnd
        End If
        
        
        If Left(tmpS, 4) = "tex-" Then
            CreateGifFromEq Mid(tmpS, 5), "c:\math.gif"
            While fs.FileExists("c:\math.gif") = False
            Wend
            Clipboard.Clear
            Clipboard.SetData LoadPicture("c:\math.gif")
            Sleep 300                   '如果不在此处等待一阵的话，会不稳定。可能是因为下面的删除语句(但是顺序执行的话按道理会让上一句先执行完再执行下一句的啊)。。。。。
            fs.DeleteFile "c:\math.gif", True
            DLLSetPubString ""
            SendKeys "^v"
            GoTo theEnd
        End If
        
         If Left(tmpS, 4) = "img-" Then
            '先获取类型,再获取参数
            Dim ret As Long
            Dim pos1 As Integer
            Dim pos2 As Integer
            Dim pos3 As Integer
            Dim pos4 As Integer
            pos1 = InStr(1, tmpS, ";")
            pos2 = InStr(pos1 + 1, tmpS, ";")
            pos3 = InStr(pos2 + 1, tmpS, ";")
            pos4 = InStr(pos3 + 1, tmpS, ";")
            If Mid(tmpS, 5, InStr(1, tmpS, ";") - 5) = "square" Then                    '1 arg
                ret = DrawGeometryFigure("c:\graph.jpg", 0, Mid(tmpS, pos1 + 1, pos2 - (pos1 + 1)), 0, 0, 0)
            ElseIf Mid(tmpS, 5, InStr(1, tmpS, ";") - 5) = "rect" Then                  '2 arg
                ret = DrawGeometryFigure("c:\graph.jpg", 1, Mid(tmpS, pos1 + 1, pos2 - (pos1 + 1)), Mid(tmpS, pos2 + 1, pos3 - (pos2 + 1)), 0, 0)
            Else
            
            End If
            
            While fs.FileExists("c:\graph.jpg") = False
            Wend
            Clipboard.Clear
            Clipboard.SetData LoadPicture("c:\graph.jpg")
            Sleep 300                   '如果不在此处等待一阵的话，会不稳定。可能是因为下面的删除语句(但是顺序执行的话按道理会让上一句先执行完再执行下一句的啊)。。。。。
            fs.DeleteFile "c:\graph.jpg", True
            DLLSetPubString ""
            SendKeys "^v"
            GoTo theEnd
        End If
        
        
        
        If Left(tmpS, 4) = "seq-" Then
            '得到数列表达式
            sequence = Mid(tmpS, 5)
            '得到num的最大值
            semicolon = InStr(sequence, ";")
            num = Mid(sequence, semicolon + 1)
            '获取去除num之后的字符串
            sequence = Mid(sequence, 1, Len(sequence) - Len(num))
            '将i代入num计算
            For i = 1 To CStr(num)
                tmpSeq = Replace(sequence, "num", CStr(i))
                seqFinal = seqFinal & CStr(Result(tmpSeq)) & ","
            Next i
            DLLSetPubString seqFinal
            GoTo theEnd
        End If
        Set cn = New ADODB.Connection
        Set rs = New ADODB.Recordset
        cn.Open "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & App.path & "\mathFormula.mdb;Persist Security Info=False"    '连接数据库
        sql = "select*From biao where 字符='" & tmpS & "'"                '连接表从ci中查找text1.text中的内容
        rs.Open sql, cn, 1, 1                                           '以只读方式打开
        If rs.EOF <> True Then                                          '判断是否寻找到底
            tmpS = rs("公式")
        End If
        DLLSetPubString tmpS
    End If
theEnd:
    SubWndProc = CallWindowProc(hPrevWndProc, hwnd, Msg, wParam, lParam)
End Function


