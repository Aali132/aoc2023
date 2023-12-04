Public Module Program
  Const Size = 140

  Dim grid(Size,Size) As Char
  
  Private Function Check(x As Integer, y As Integer) As Boolean
    If x < 0 Or x > Size-1
      Return False
    End If
    
    If y < 0 Or y > Size-1
      Return False
    End If
    
    If Char.IsDigit(grid(x,y)) Or grid(x,y) = "."c
      Return False
    End If
    
    Return True
  End Function
  
	Public Sub Main(args() As string)
	  Dim sum = 0
	  
		For y As Integer = 0 To Size-1
		  Dim tmp() As Char
		  tmp = Console.ReadLine().ToCharArray
		  
		  For x As Integer = 0 To Size-1
		    grid(x,y) = tmp(x)
	    Next
		Next
  
    For y As Integer = 0 To Size-1
      Dim inNum = False
      Dim isPart = False
      Dim num As Integer = 0
      
      For x As Integer = 0 To Size-1
        If Char.IsDigit(grid(x,y))
          If inNum = False
            Dim tmp(3) As Char
            
            For o As Integer = 0 To 2
              If x + o < Size
                tmp(o) = grid(x+o,y)
              End If
            Next
            
            num = Math.Floor(Val(new String(tmp)))
          End If
          
          inNum = True
          
          If Check(x-1,y) Or Check(x+1,y) Or Check(x,y-1) Or Check(x,y+1)
            isPart = True
          End If

          If Check(x-1,y-1) Or Check(x+1,y+1) Or Check(x-1,y+1) Or Check(x+1,y-1)
            isPart = True
          End If
        Else
          If inNum
            If isPart
              sum = sum + num
              isPart = False
            End If
            inNum = False
          End If
        End If
      Next
      
      If inNum
        If isPart
          sum = sum + num
        End If
      End If
    Next
    
    Console.Write(sum)
	End Sub
End Module
