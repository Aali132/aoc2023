var grid: [[Character]] = []

while let line = readLine() {
  grid.append(Array(line))
}

let width = grid[0].count
let height = grid.count

var sum = 0

for x in 0...width-1 {
  var load = height
  
  for y in 0...height-1 {
    if grid[y][x] == "O" {
      sum += load
      load -= 1
    } else if grid[y][x] == "#" {
      load = height - y - 1
    }
  }
}

print(sum)
