Public Module Program
  Const Size = 140

  Dim grid(Size,Size) As Char
  Dim gears(Size,Size,2) As Integer
  
  Private Function CheckGear(x As Integer, y As Integer, num As Integer) As Integer
    If x < 0 Or x > Size-1
      Return 0
    End If
    
    If y < 0 Or y > Size-1
      Return 0
    End If
    
    If grid(x,y) = "*"c
      If gears(x,y,0) = 0
        gears(x,y,0) = num
        Return 0
      Else If gears(x,y,0) <> num
        grid(x,y) = "."c
        Return gears(x,y,0) * num
      End If
    End If
    
    Return 0
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
          
          sum = sum + CheckGear(x-1,y,num)
          sum = sum + CheckGear(x+1,y,num)
          sum = sum + CheckGear(x,y-1,num)
          sum = sum + CheckGear(x,y+1,num)
          sum = sum + CheckGear(x-1,y-1,num)
          sum = sum + CheckGear(x+1,y-1,num)
          sum = sum + CheckGear(x-1,y+1,num)
          sum = sum + CheckGear(x+1,y+1,num)
          
          inNum = True
        Else
          inNum = False
        End If
      Next
    Next
    
    Console.Write(sum)
	End Sub
End Module
