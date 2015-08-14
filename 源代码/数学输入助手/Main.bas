Attribute VB_Name = "MainModule"
Option Explicit
Public appdisk$, winsys$, aa$, transcolor&, testhwnd&, rtn&
Sub Main()
   Dim byt() As Byte
   appdisk = IIf(Right(App.path, 1) = "\", App.path, App.path & "\")
   Call Getsys
   transcolor = RGB(66, 66, 66)
   
   '********** 释放资源文件中的OCX
   aa = winsys & "swflash.ocx"
   If Dir(aa) = "" Then
      byt = LoadResData(101, "CUSTOM")
      Open aa For Binary As #1
      Put #1, 1, byt()
      Close #1
   End If
   aa = winsys & "Regsvr32 /s " & aa
   Call Shell(aa, vbHide)
   
   InputHelper.Show
End Sub

Public Sub Getsys() '获取system32路径
   aa = Trim(Environ("ComSpec"))
   winsys = Mid(aa, 1, InStrRev(aa, "\"))
End Sub

