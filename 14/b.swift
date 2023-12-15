var grid: [[Character]] = []

while let line = readLine() {
  grid.append(Array(line))
}

let width = grid[0].count
let height = grid.count

func tilt_north() {
  for x in 0...width-1 {
    var offset = 0
    
    for y in 0...height-1 {
      if grid[y][x] == "O" {
        grid[y][x] = "."
        grid[offset][x] = "O"
        
        offset += 1
      } else if grid[y][x] == "#" {
        offset = y + 1
      }
    }
  }
}

func tilt_west() {
  for y in 0...height-1 {
    var offset = 0
    
    for x in 0...width-1 {
      if grid[y][x] == "O" {
        grid[y][x] = "."
        grid[y][offset] = "O"
        
        offset += 1
      } else if grid[y][x] == "#" {
        offset = x + 1
      }
    }
  }
}

func tilt_south() {
  for x in 0...width-1 {
    var offset = 0
    
    for y in 0...height-1 {
      if grid[height-y-1][x] == "O" {
        grid[height-y-1][x] = "."
        grid[height-offset-1][x] = "O"
        
        offset += 1
      } else if grid[height-y-1][x] == "#" {
        offset = y + 1
      }
    }
  }
}

func tilt_east() {
  for y in 0...height-1 {
    var offset = 0
    
    for x in 0...width-1 {
      if grid[y][width-x-1] == "O" {
        grid[y][width-x-1] = "."
        grid[y][width-offset-1] = "O"
        
        offset += 1
      } else if grid[y][width-x-1] == "#" {
        offset = x + 1
      }
    }
  }
}

var states: [[[Character]]] = []

for _ in 1...200 {
  states.append(grid)
  
  tilt_north()
  tilt_west()
  tilt_south()
  tilt_east()
}

var cycle_length = 0

for i in 0...states.count-1 {
  for j in i...states.count-1 {
    if i != j && states[i] == states[j] {
      cycle_length = j - i
    }
  }
}

var target_state = 1000000000 % cycle_length + cycle_length

grid = states[target_state]

var sum = 0

for x in 0...width-1 {
  var load = height
  
  for y in 0...height-1 {
    if grid[y][x] == "O" {
      sum += height - y
    }
  }
}

print(sum)
