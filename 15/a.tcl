gets stdin line

set steps [split $line ","]

set sum 0

for {set n 0} {$n < [llength $steps]} {incr n} {
  set str [lindex $steps $n]
  set hash 0
  
  foreach char [split $str ""] {
    scan $char %c ord
    
    set hash [expr (($hash + $ord) * 17) % 256]
  }
  
  set sum [expr $sum + $hash]
}

puts $sum
