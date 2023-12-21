package main

import (
	"fmt"
)

func main() {
  var grid [][]int
  var line string
  
  for func(n int, _ error) int { return n }(fmt.Scanln(&line)) > 0 {
    var row []int
    
    for _, d := range line {
      row = append(row, int(d - '0'))
    }
    
    grid = append(grid, row)
  }
  
  width := len(grid[0])
  height := len(grid)
  
  l := width * height * 10
	
	mincost := make([][][]int, height)
	
  for y := 0; y < height; y++ {
      mincost[y] = make([][]int, width)
      
      for x := 0; x < width; x++ {
        mincost[y][x] = make([]int, 40)
        
        for s := 0; s < 40; s++ {
          mincost[y][x][s] = l
        }
      }
  }
  
  mincost[0][1][0] = grid[0][1]
  mincost[1][0][20] = grid[1][0]
  
  updated := 1
  
  for updated > 0 {
    updated = 0
    
    for y := 0; y < height; y++ {
      for x := 0; x < width; x++ {
        for s := 0; s < 40; s++ {
          best := l
          
          if y > 0 {
            if s == 20 {
              for i := 0; i < 14; i++ {
                v := mincost[y-1][x][i+3]
                
                if i >= 7 {
                  v = mincost[y-1][x][i+6]
                }
                
                if v < best {
                  best = v
                }
              }
            } else if(s > 20 && s < 30) {
              best = mincost[y-1][x][s-1]
            }
          }
          
          if y < height-1 {
            if s == 30 {
              for i := 0; i < 14; i++ {
                v := mincost[y+1][x][i+3]
                
                if i >= 7 {
                  v = mincost[y+1][x][i+6]
                }
                
                if v < best {
                  best = v
                }
              }
            } else if(s > 30) {
              best = mincost[y+1][x][s-1]
            }
          }
          
          if x > 0 {
            if s == 0 {
              for i := 0; i < 14; i++ {
                v := mincost[y][x-1][i+23]
                
                if i >= 7 {
                  v = mincost[y][x-1][i+26]
                }
                
                if v < best {
                  best = v
                }
              }
            } else if(s < 10) {
              best = mincost[y][x-1][s-1]
            }
          }
          
          if x < width-1 {
            if s == 10 {
              for i := 0; i < 14; i++ {
                v := mincost[y][x+1][i+23]
                
                if i >= 7 {
                  v = mincost[y][x+1][i+26]
                }
                
                if v < best {
                  best = v
                }
              }
            } else if(s > 10 && s < 20) {
              best = mincost[y][x+1][s-1]
            }
          }
          
          val := best + grid[y][x]
          
          if val < mincost[y][x][s] {
            mincost[y][x][s] = val
            updated++
          }
        }
      }
    }
  }
  
  mincost[height-1][width-1][0] = l
  mincost[height-1][width-1][1] = l
  mincost[height-1][width-1][2] = l
  mincost[height-1][width-1][20] = l
  mincost[height-1][width-1][21] = l
  mincost[height-1][width-1][22] = l
  
  m := l
  
  for _, e := range mincost[height-1][width-1] {
    if e < m {
      m = e
    }
  }
  
  fmt.Printf("%d\n", m)
}
