pattern = []
sum = 0

def find_reflection(pattern)
  mirror = 0
  
  for y in 0...pattern.length-1 do
    if(pattern[y] == pattern[y+1])
      ys = y - 1
      
      for ym in y+2..pattern.length do
        if(ym == pattern.length || ys < 0)
          mirror = y + 1
          break
        end
        
        if(pattern[ys] != pattern[ym])
          break
        end
        
        ys = ys - 1
      end
      
      if(mirror != 0)
        break
      end
    end
  end
  
  mirror
end

loop do
  line = gets
  
  if(!line || line == "\n")
    rows = pattern.map { |row| row.join }
    cols = pattern.transpose().map { |col| col.join }
    
    vmirror = find_reflection(rows)
    hmirror = find_reflection(cols)
    
    sum = sum + vmirror * 100
    sum = sum + hmirror
    
    pattern = []
  else
    pattern.push(line.chomp.split(""))
  end
  
  if(!line)
    break
  end
end

p(sum)
