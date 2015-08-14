VERSION 5.00
Object = "{67397AA1-7FB1-11D0-B148-00A0C922E820}#6.0#0"; "MSADODC.OCX"
Object = "{CDE57A40-8B86-11D0-B3C6-00A0C90AEA82}#1.0#0"; "MSDATGRD.OCX"
Begin VB.Form add_data 
   Caption         =   "添加公式(如无效请重启程序应用修改)"
   ClientHeight    =   4635
   ClientLeft      =   10095
   ClientTop       =   6930
   ClientWidth     =   5205
   BeginProperty Font 
      Name            =   "Tahoma"
      Size            =   8.25
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   Icon            =   "add_data.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   4635
   ScaleWidth      =   5205
   ShowInTaskbar   =   0   'False
   Begin MSDataGridLib.DataGrid DataGrid1 
      Bindings        =   "add_data.frx":1CCA
      Height          =   3255
      Left            =   120
      TabIndex        =   7
      Top             =   1320
      Width           =   5055
      _ExtentX        =   8916
      _ExtentY        =   5741
      _Version        =   393216
      HeadLines       =   1
      RowHeight       =   15
      BeginProperty HeadFont {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ColumnCount     =   2
      BeginProperty Column00 
         DataField       =   ""
         Caption         =   ""
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   2052
            SubFormatType   =   0
         EndProperty
      EndProperty
      BeginProperty Column01 
         DataField       =   ""
         Caption         =   ""
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   2052
            SubFormatType   =   0
         EndProperty
      EndProperty
      SplitCount      =   1
      BeginProperty Split0 
         BeginProperty Column00 
         EndProperty
         BeginProperty Column01 
         EndProperty
      EndProperty
   End
   Begin VB.CommandButton shanchu 
      Caption         =   "删除"
      Height          =   345
      Left            =   240
      TabIndex        =   6
      Top             =   720
      Width           =   735
   End
   Begin MSAdodcLib.Adodc lianjie 
      Height          =   495
      Left            =   7560
      Top             =   840
      Visible         =   0   'False
      Width           =   1695
      _ExtentX        =   2990
      _ExtentY        =   873
      ConnectMode     =   3
      CursorLocation  =   3
      IsolationLevel  =   -1
      ConnectionTimeout=   15
      CommandTimeout  =   30
      CursorType      =   3
      LockType        =   3
      CommandType     =   2
      CursorOptions   =   0
      CacheSize       =   50
      MaxRecords      =   0
      BOFAction       =   0
      EOFAction       =   0
      ConnectStringType=   1
      Appearance      =   1
      BackColor       =   -2147483643
      ForeColor       =   -2147483640
      Orientation     =   0
      Enabled         =   -1
      Connect         =   "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=mathFormula.mdb;Mode=Read;Persist Security Info=False"
      OLEDBString     =   "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=mathFormula.mdb;Mode=Read;Persist Security Info=False"
      OLEDBFile       =   ""
      DataSourceName  =   ""
      OtherAttributes =   ""
      UserName        =   ""
      Password        =   ""
      RecordSource    =   "biao"
      Caption         =   "Adodc1"
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      _Version        =   393216
   End
   Begin VB.Frame Frame1 
      Caption         =   "公式添加"
      Height          =   1215
      Left            =   120
      TabIndex        =   0
      Top             =   0
      Width           =   5055
      Begin VB.Timer Timer1 
         Enabled         =   0   'False
         Interval        =   1000
         Left            =   5040
         Top             =   240
      End
      Begin VB.CommandButton Command1 
         Caption         =   "添加"
         Height          =   345
         Left            =   120
         TabIndex        =   3
         Top             =   360
         Width           =   735
      End
      Begin VB.TextBox zifu 
         Height          =   285
         Left            =   1920
         TabIndex        =   2
         Top             =   360
         Width           =   3015
      End
      Begin VB.TextBox gongshi 
         Height          =   285
         Left            =   1920
         TabIndex        =   1
         Top             =   720
         Width           =   3015
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "公式："
         Height          =   195
         Left            =   1320
         TabIndex        =   5
         Top             =   720
         Width           =   540
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "公式名称："
         Height          =   195
         Left            =   960
         TabIndex        =   4
         Top             =   360
         Width           =   900
      End
   End
End
Attribute VB_Name = "add_data"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim s As String
Private Sub Command1_Click()
On Error GoTo cuo
    If gongshi.Text = "" Or zifu.Text = "" Then
        MsgBox "请不要输入空符号", 0 + 16 + 0, "错误"
    Else
        Set rs = New ADODB.Recordset
        sql = "select*from biao"
        rs.Open sql, cn, 3, 2
        rs.AddNew
        rs!字符 = Trim(zifu.Text)
        rs!公式 = Trim(gongshi.Text)
        rs.Update
        gongshi.Text = ""
        zifu.Text = ""
    End If
    Timer1.Enabled = True
    rs.Close
    Exit Sub
cuo:
    MsgBox "添加数据出错.请稍后再试!", 0 + 16 + 0, "错误"
End Sub

Private Sub DataGrid1_Click()
DataGrid1.Col = 0
s = DataGrid1.Text
Debug.Print s
End Sub

Private Sub Form_Load()
    On Error GoTo cuo
    Set cn = New ADODB.Connection
    cn.Open "provider=microsoft.jet.oledb.4.0;data source =" & App.path & "\mathFormula.mdb;persist security info=false"
    Exit Sub
cuo:
    MsgBox "连接数据库出错.请检查数据库", 0 + 16 + 0, "错误"
End Sub

Private Sub shanchu_Click()
    Dim qr, q As String
    Set rs = New ADODB.Recordset
    sql = "select*from biao"
    rs.Open sql, cn, 3, 2
    If rs.RecordCount < 1 Then
        MsgBox ("未找到数据信息,请确认!"), vbOKOnly, "错误"
    Exit Sub
    End If
    rs.Close
    sql = "Delete from biao where 字符 = '" & s & "'"
    Set rs = New ADODB.Recordset
    rs.Open sql, cn, 3, 2
    Timer1.Enabled = True
End Sub

Private Sub Timer1_Timer()
    lianjie.Refresh
    Set DataGrid1.DataSource = lianjie
    DataGrid1.Refresh
    Timer1.Enabled = False
End Sub
