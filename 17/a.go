package main

import (
	"fmt"
)

func min(v []int) int {
  m := 1000000000
  
  for _, e := range v {
    if e < m {
      m = e
    }
  }
  
  return m
}

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
	
	mincost := make([][][]int, height)
	
  for y := 0; y < height; y++ {
      mincost[y] = make([][]int, width)
      
      for x := 0; x < width; x++ {
        mincost[y][x] = make([]int, 12)
        
        for s := 0; s < 12; s++ {
          mincost[y][x][s] = 1000000000
          
          if x == 0 && y == 0 {
            mincost[y][x][s] = 0
          }
        }
      }
  }
  
  updated := 1
  
  for updated > 0 {
    updated = 0
    
    for y := 0; y < height; y++ {
      for x := 0; x < width; x++ {
        for s := 0; s < 12; s++ {
          var options []int
          
          if y > 0 {
            if s == 6 {
              options = append(options, mincost[y-1][x][0])
              options = append(options, mincost[y-1][x][1])
              options = append(options, mincost[y-1][x][2])
              options = append(options, mincost[y-1][x][3])
              options = append(options, mincost[y-1][x][4])
              options = append(options, mincost[y-1][x][5])
            } else if(s == 7) {
              options = append(options, mincost[y-1][x][6])
            } else if(s == 8) {
              options = append(options, mincost[y-1][x][7])
            }
          }
          
          if y < height-1 {
            if s == 9 {
              options = append(options, mincost[y+1][x][0])
              options = append(options, mincost[y+1][x][1])
              options = append(options, mincost[y+1][x][2])
              options = append(options, mincost[y+1][x][3])
              options = append(options, mincost[y+1][x][4])
              options = append(options, mincost[y+1][x][5])
            } else if(s == 10) {
              options = append(options, mincost[y+1][x][9])
            } else if(s == 11) {
              options = append(options, mincost[y+1][x][10])
            }
          }
          
          if x > 0 {
            if s == 0 {
              options = append(options, mincost[y][x-1][6])
              options = append(options, mincost[y][x-1][7])
              options = append(options, mincost[y][x-1][8])
              options = append(options, mincost[y][x-1][9])
              options = append(options, mincost[y][x-1][10])
              options = append(options, mincost[y][x-1][11])
            } else if(s == 1) {
              options = append(options, mincost[y][x-1][0])
            } else if(s == 2) {
              options = append(options, mincost[y][x-1][1])
            }
          }
          
          if x < width-1 {
            if s == 3 {
              options = append(options, mincost[y][x+1][6])
              options = append(options, mincost[y][x+1][7])
              options = append(options, mincost[y][x+1][8])
              options = append(options, mincost[y][x+1][9])
              options = append(options, mincost[y][x+1][10])
              options = append(options, mincost[y][x+1][11])
            } else if(s == 4) {
              options = append(options, mincost[y][x+1][3])
            } else if(s == 5) {
              options = append(options, mincost[y][x+1][4])
            }
          }
          
          val := min(options) + grid[y][x]
          
          if val < mincost[y][x][s] {
            mincost[y][x][s] = val
            updated++
          }
        }
      }
    }
  }
  
  fmt.Printf("%d\n", min(mincost[height-1][width-1]))
}
