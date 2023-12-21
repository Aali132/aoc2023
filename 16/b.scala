import scala.io.StdIn.readLine
import scala.collection.mutable.ArrayBuffer
import scala.collection.mutable.ListBuffer

var lines = ArrayBuffer[String]()
var ok = true
while(ok) {
  val ln = readLine()
  ok = ln != null
  if(ok) lines += ln
}

val width = lines(0).length
val height = lines.length

var starts = ArrayBuffer[(Int,Int,Int,Int)]()

for(x <- 0 to width-1) {
  starts += ((x,0,0,1))
  starts += ((x,height-1,0,-1))
}

for(y <- 0 to height-1) {
  starts += ((0,y,1,0))
  starts += ((width-1,y,-1,0))
}

var result = 0

starts.foreach(start => {
  val visited: Array[Array[Int]] = Array.ofDim[Int](height, width)
  
  var open = ListBuffer[(Int,Int,Int,Int)]()
  
  open += ((start._1,start._2,start._3,start._4))
  
  while(open.length > 0) {
    val curr = open.last
    
    open = open.init
    
    val x = curr._1
    val y = curr._2
    val dx = curr._3
    val dy = curr._4
    
    if(x >= 0 && y >= 0 && x < width && y < height) {
      var dir = 0
      
      if(dx != 0) {
        dir = (dx + 3) / 2
      } else {
        dir = (dy + 3) * 2
      }
      
      if((visited(y)(x) & dir) == 0) {
        visited(y)(x) |= dir
        
        if(lines(y)(x) == '.') {
          open += ((x+dx,y+dy,dx,dy))
        } else if(lines(y)(x) == '-') {
          if(dx == 0) {
            open += ((x+1,y,1,0))
            open += ((x-1,y,-1,0))
          } else {
            open += ((x+dx,y+dy,dx,dy))
          }
        } else if(lines(y)(x) == '|') {
          if(dy == 0) {
            open += ((x,y+1,0,1))
            open += ((x,y-1,0,-1))
          } else {
            open += ((x+dx,y+dy,dx,dy))
          }
        } else if(lines(y)(x) == '/') {
          open += ((x-dy,y-dx,-dy,-dx))
        } else if(lines(y)(x) == '\\') {
          open += ((x+dy,y+dx,dy,dx))
        }
      }
    }
  }
  
  var sum = 0
  
  for( y <- 0 to height-1) {
    for( x <- 0 to width-1) {
      if(visited(y)(x) != 0) {
        sum += 1
      }
    }
  }
  
  result = result.max(sum)
})

println(result)
