Attribute VB_Name = "ValueConvert"

                                                                                    '进制转换模块ValueConvert
Option Explicit
'二进制对应十六进制的映射表★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
Private Type Hex2Bin
    HexStr As String
    BinStr As String
End Type
Dim HBtable(0 To 15) As Hex2Bin
Private Function InitTable()
    Dim i As Integer
    '十六进制
    For i = 0 To 9
        HBtable(i).HexStr = i
    Next i
    HBtable(10).HexStr = "A"
    HBtable(11).HexStr = "B"
    HBtable(12).HexStr = "C"
    HBtable(13).HexStr = "D"
    HBtable(14).HexStr = "E"
    HBtable(15).HexStr = "F"
    '二进制
    HBtable(0).BinStr = "0000"
    HBtable(1).BinStr = "0001"
    HBtable(2).BinStr = "0010"
    HBtable(3).BinStr = "0011"
    HBtable(4).BinStr = "0100"
    HBtable(5).BinStr = "0101"
    HBtable(6).BinStr = "0110"
    HBtable(7).BinStr = "0111"
    HBtable(8).BinStr = "1000"
    HBtable(9).BinStr = "1001"
    HBtable(10).BinStr = "1010"
    HBtable(11).BinStr = "1011"
    HBtable(12).BinStr = "1100"
    HBtable(13).BinStr = "1101"
    HBtable(14).BinStr = "1110"
    HBtable(15).BinStr = "1111"
End Function

'二进制对应十六进制的映射表★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★

'十进制->二进制★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
Public Function Dec2Bin(dec As String)
    Dim rest As Integer, remainder As String
    
    
    If dec <> 0 Then
        Do While CStr(dec) <> 1
            rest = DivisionWithoutCut(dec)
            remainder = remainder & rest
        Loop
        rest = DivisionWithoutCut(dec)
        remainder = remainder & rest
        remainder = StringReverse(remainder)
        Dec2Bin = remainder
    Else
        Dec2Bin = 0
    End If
End Function

'不切断除法                         被除数(除数默认是2)
Public Function DivisionWithoutCut(ByRef dividend As String)
    Dim remainder As String
    remainder = CStr(dividend Mod 10)
    If remainder = 0 Or remainder = 2 Or remainder = 4 Or remainder = 6 Or remainder = 8 Then
        dividend = CStr(CStr(dividend) / 2)
        DivisionWithoutCut = 0
    Else
        dividend = CStr((CStr(dividend) - 1) / 2)
        DivisionWithoutCut = 1
    End If
End Function
'字符串翻转
Public Function StringReverse(str As String)
    Dim newStr As String
    Dim length As Integer, i As Integer, j As Integer
    
    length = Len(str)
    For i = length To 1 Step -1
        newStr = newStr & Mid(str, i, 1)
    Next i
    StringReverse = newStr
End Function
'十进制->二进制★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★

'二进制->十进制★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
Public Function Bin2Dec(bin As String)
    '获取位数
    '用位数做循环计数
    '取第一位,accumulate=x*2^i-1
    Dim LenOfBit As Integer
    Dim accum As Long, count As Long
    Dim i As Integer
    LenOfBit = Len(bin) - 1
    For i = 0 To LenOfBit - 1
        count = CStr(Mid(bin, LenOfBit - i, 1))
        accum = count * 2 ^ i + accum
    Next i
    Bin2Dec = CStr(accum)
End Function
'二进制->十进制★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★




'十进制->十六进制★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
Public Function Dec2Hex(dec As String)
    '将十进制先转换为二进制再将二进制转换为十六进制
    Dim temp As String
    temp = Dec2Bin(dec)
    Dec2Hex = Bin2Hex(temp)
End Function
'十进制->十六进制★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★


'十六进制->十进制
Public Function Hex2Dec(hex As String)
    '将十六进制先转换为二进制，再将二进制转换为十进制
    Dim temp As String
    temp = Hex2Bin(hex)
    Hex2Dec = Bin2Dec(temp)
End Function


'二进制->十六进制★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
Public Function Bin2Hex(bin As String)
    Dim LenOfBit As Integer
    Dim i As Integer, j As Integer
    Dim remant As Integer
    Dim temp As String, accum As String
    Call InitTable
    LenOfBit = Len(bin)
    
    If LenOfBit < 4 Then
        For i = 1 To 4 - LenOfBit
            bin = "0" & bin
        Next i
        
        For i = 0 To 15
            If HBtable(i).BinStr = bin Then
                Bin2Hex = HBtable(i).HexStr
            End If
        Next i
    ElseIf LenOfBit = 4 Then
        For i = 0 To 15
            If HBtable(i).BinStr = bin Then
                Bin2Hex = HBtable(i).HexStr
            End If
        Next i
    ElseIf LenOfBit > 4 Then
        remant = LenOfBit Mod 4
        remant = 4 - remant
        
        For i = 1 To remant
            bin = "0" & bin
        Next i
        
        LenOfBit = Len(bin)
        remant = LenOfBit / 4
        
        For i = 1 To remant
            temp = Mid(bin, 4 * i - 3, 4)
            For j = 0 To 15
                If HBtable(j).BinStr = temp Then
                    accum = accum & HBtable(j).HexStr
                End If
            Next j
        Next i
    End If
    Bin2Hex = accum
End Function
'二进制->十六进制★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★

'十六进制->二进制
Public Function Hex2Bin(hex As String)
    '将每个十六进制数映射为对应的四位二进制即可
    Dim accum As String, temp As String
    Dim i As Integer, j As Integer
    Dim LenOfHex As Integer
    
    For i = 1 To LenOfHex
        temp = Mid(hex, i, 1)
        For j = 0 To 15
            If HBtable(j).HexStr = temp Then
                accum = accum & HBtable(j).BinStr
            End If
        Next j
    Next i
    
    Hex2Bin = accum
End Function
