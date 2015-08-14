VERSION 5.00
Begin VB.Form Form2 
   Caption         =   "Form2"
   ClientHeight    =   1680
   ClientLeft      =   165
   ClientTop       =   855
   ClientWidth     =   3015
   LinkTopic       =   "Form2"
   ScaleHeight     =   1680
   ScaleWidth      =   3015
   StartUpPosition =   3  '窗口缺省
   Begin VB.Menu SysMenu 
      Caption         =   "SysMenu"
      Begin VB.Menu menuBegin 
         Caption         =   "开始"
      End
      Begin VB.Menu menuEnd 
         Caption         =   "停止"
      End
      Begin VB.Menu QGGMM 
         Caption         =   "改变GGMM"
         Begin VB.Menu QPetGG 
            Caption         =   "QQPetGG"
         End
         Begin VB.Menu QPetMM 
            Caption         =   "QQPetMM"
         End
      End
      Begin VB.Menu menuExit 
         Caption         =   "退出"
      End
   End
End
Attribute VB_Name = "Form2"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False


Private Sub menuBegin_Click()
    Form1.Timer1.Enabled = True
End Sub

Private Sub menuEnd_Click()
    Form1.Timer1.Enabled = False
End Sub

Private Sub menuExit_Click()
    End
End Sub

Private Sub QPetGG_Click()
    QQGGMM = 1
End Sub

Private Sub QPetMM_Click()
    QQGGMM = 0
End Sub
