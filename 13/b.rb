pattern = []
sum = 0

def hamming(a, b)
  (a^b).to_s(2).count("1")
end

def find_reflection(pattern)
  mirror = 0
  
  for y in 0...pattern.length-1 do
    score = 0
    ys = y
    
    for ym in y+1..pattern.length do
      if(ym == pattern.length || ys < 0)
        break
      end
      
      score = score + hamming(pattern[ys], pattern[ym])
      
      if(score > 1)
        break
      end
      
      ys = ys - 1
    end
    
    if(score == 1)
      mirror = y + 1
      break
    end
  end
  
  mirror
end

loop do
  line = gets
  
  if(!line || line == "\n")
    rows = pattern.map { |row| row.join().to_i(2) }
    cols = pattern.transpose().map { |col| col.join().to_i(2) }
    
    vmirror = find_reflection(rows)
    hmirror = find_reflection(cols)
    
    sum = sum + vmirror * 100
    sum = sum + hmirror
    
    pattern = []
  else
    pattern.push(line.chomp.gsub(".","0").gsub("#","1").split(""))
  end
  
  if(!line)
    break
  end
end

p(sum)
