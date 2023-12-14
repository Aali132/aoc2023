galaxies = {}

width = 0
height = 0

expandcols = {}
expandrows = {}

cols = {}
rows = {}

y = 1

for line in io.read("*a"):gmatch("[^\r\n]+") do
  x = 1
  
  for c in line:gmatch"." do
    if c == "#" then
      galaxy = { ["x"] = x, ["y"] = y }
      table.insert(galaxies, galaxy)
      
      expandcols[x] = 1
      expandrows[y] = 1
    end
    
    x = x + 1
  end
  
  y = y + 1
end

width = x-1
height = y-1

expandx = 1

for x = 1,width do
  cols[x] = expandx
  
  if expandcols[x] == nil then
    expandx = expandx + 1
  end
  
  expandx = expandx + 1
end

expandy = 1

for y = 1,height do
  rows[y] = expandy
  
  if expandrows[y] == nil then
    expandy = expandy + 1
  end
  
  expandy = expandy + 1
end

sum = 0

for g1 = 1,#galaxies do
  for g2 = g1+1,#galaxies do
    x1 = cols[galaxies[g1]["x"]]
    y1 = rows[galaxies[g1]["y"]]
    x2 = cols[galaxies[g2]["x"]]
    y2 = rows[galaxies[g2]["y"]]
    
    dist = math.abs(x1 - x2) + math.abs(y1 - y2)
    
    sum = sum + dist
  end
end

print(sum)
