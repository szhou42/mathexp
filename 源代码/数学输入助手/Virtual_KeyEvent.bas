Attribute VB_Name = "HotKey"
'热键API
Public Declare Function SetWindowLong Lib "user32" Alias "SetWindowLongA" (ByVal hWnd As Long, ByVal nIndex As Long, ByVal dwNewLong As Long) As Long
Public Declare Function GetWindowLong Lib "user32" Alias "GetWindowLongA" (ByVal hWnd As Long, ByVal nIndex As Long) As Long
Public Declare Function CallWindowProc Lib "user32" Alias "CallWindowProcA" (ByVal lpPrevWndFunc As Long, ByVal hWnd As Long, ByVal Msg As Long, ByVal wParam As Long, ByVal lParam As Long) As Long
Public Declare Function RegisterHotKey Lib "user32" (ByVal hWnd As Long, ByVal ID As Long, ByVal fsModifiers As Long, ByVal vk As Long) As Long
Public Declare Function UnregisterHotKey Lib "user32" (ByVal hWnd As Long, ByVal ID As Long) As Long

'热键常量
Public Const WM_HOTKEY = &H312


'虚拟键常量
Public Const VK_ADD As Long = &H6B '加号键
Public Const VK_APPS As Long = &H5D 'Applications 键（相当于鼠标右键）
Public Const VK_BACK As Long = &H8 'BackSpace 键
Public Const VK_CAPITAL As Long = &H14 'Caps Lock 键（大小写转换键）
Public Const VK_CANCEL As Long = &H3 'Ctrl + Break 过程
Public Const VK_CONTROL As Long = &H11
Public Const VK_DECIMAL As Long = &H6E '小数点号键
Public Const VK_DELETE As Long = &H2E
Public Const VK_DIVIDE As Long = &H6F '除号键
Public Const VK_DOWN As Long = &H28
Public Const VK_END As Long = &H23
Public Const VK_ESCAPE As Long = &H1B
Public Const VK_F1 As Long = &H70
Public Const VK_F10 As Long = &H79
Public Const VK_F11 As Long = &H7A
Public Const VK_F12 As Long = &H7B
Public Const VK_F2 As Long = &H71
Public Const VK_F3 As Long = &H72
Public Const VK_F4 As Long = &H73
Public Const VK_F5 As Long = &H74
Public Const VK_F6 As Long = &H75
Public Const VK_F7 As Long = &H76
Public Const VK_F8 As Long = &H77
Public Const VK_F9 As Long = &H78
Public Const VK_HOME As Long = &H24
Public Const VK_INSERT As Long = &H2D
Public Const VK_LCONTROL As Long = &HA2
Public Const VK_LEFT As Long = &H25
Public Const VK_LMENU As Long = &HA4 '左 Alt 键
Public Const VK_LSHIFT As Long = &HA0
Public Const VK_LWIN As Long = &H5B
Public Const VK_MENU As Long = &H12 'Alt 键
Public Const VK_MULTIPLY As Long = &H6A '乘号键
Public Const VK_NEXT As Long = &H22 '下翻页键
Public Const VK_NUMLOCK As Long = &H90
Public Const VK_NUMPAD0 As Long = &H60
Public Const VK_NUMPAD1 As Long = &H61
Public Const VK_NUMPAD2 As Long = &H62
Public Const VK_NUMPAD3 As Long = &H63
Public Const VK_NUMPAD4 As Long = &H64
Public Const VK_NUMPAD5 As Long = &H65
Public Const VK_NUMPAD6 As Long = &H66
Public Const VK_NUMPAD7 As Long = &H67
Public Const VK_NUMPAD8 As Long = &H68
Public Const VK_NUMPAD9 As Long = &H69
Public Const VK_PAUSE As Long = &H13
Public Const VK_PRINT As Long = &H2A
Public Const VK_PRIOR As Long = &H21 '上翻页键
Public Const VK_RCONTROL As Long = &HA3
Public Const VK_RETURN As Long = &HD '回车键
Public Const VK_RIGHT As Long = &H27
Public Const VK_RMENU As Long = &HA5 '右 Alt 键
Public Const VK_RSHIFT As Long = &HA1
Public Const VK_RWIN As Long = &H5C
Public Const VK_SCROLL As Long = &H91 'Scroll Lock 键
Public Const VK_SEPARATOR As Long = &H6C '小键盘上的回车键
Public Const VK_SHIFT As Long = &H10
Public Const VK_SLEEP As Long = &H5F '休眠键
Public Const VK_SNAPSHOT As Long = &H2C 'Print Screen 键
Public Const VK_SPACE As Long = &H20
Public Const VK_SUBTRACT As Long = &H6D '减号键
Public Const VK_TAB As Long = &H9
Public Const VK_UP As Long = &H26
Public Const VK_OEM_1 As Long = &HBA 'Windows 2000：对于 US 标准键盘，是“;:”键
Public Const VK_OEM_2 As Long = &HBF 'Windows 2000：对于 US 标准键盘，是“/?”键
Public Const VK_OEM_3 As Long = &HC0 'Windows 2000：对于 US 标准键盘，是“`~”键
Public Const VK_OEM_4 As Long = &HDB 'Windows 2000：对于 US 标准键盘，是“[{”键
Public Const VK_OEM_5 As Long = &HDC 'Windows 2000：对于 US 标准键盘，是“\|”键
Public Const VK_OEM_6 As Long = &HDD 'Windows 2000：对于 US 标准键盘，是“]}”键
Public Const VK_OEM_7 As Long = &HDE 'Windows 2000：对于 US 标准键盘，是“单/双引号”键
Public Const VK_OEM_COMMA As Long = &HBC 'Windows 2000：对于任何国家/地区，是“,”键
Public Const VK_OEM_MINUS As Long = &HBD 'Windows 2000：对于任何国家/地区，是“-”键
Public Const VK_OEM_PERIOD As Long = &HBE 'Windows 2000：对于任何国家/地区，是“.”键
Public Const VK_OEM_PLUS As Long = &HBB 'Windows 2000：对于任何国家/地区，是“+”键



Public MyhWnd As Long, uVirtKey As Long
