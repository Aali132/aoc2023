gets stdin line

set steps [split $line ","]

set sum 0

for {set n 0} {$n < [llength $steps]} {incr n} {
  set str [lindex $steps $n]
  set hash 0
  
  set label ""
  set oper ""
  set focal 0
  
  foreach char [split $str ""] {
    scan $char %c ord
    
    if {$ord > 0x60} {
      set label $label$char
      set hash [expr (($hash + $ord) * 17) % 256]
    } elseif {$ord == 0x3D} {
      set oper "="
    } elseif {$ord == 0x2D} {
      set oper "-"
    } else {
      set focal [expr $ord-0x30]
    }
  }
  
  if {$oper == "="} {
    set index -1
    set focals($label) $focal
    
    if {[info exists boxes($hash)]} {
      set index [lsearch -exact $boxes($hash) $label]
    }
    
    if {$index == -1} {
      lappend boxes($hash) $label
    }
  }
  
  if {$oper == "-"} {
    if {[info exists boxes($hash)]} {
      set index [lsearch -exact $boxes($hash) $label]
      set boxes($hash) [lreplace $boxes($hash) $index $index]
    }
  }
}

for {set box 0} {$box < 256} {incr box} {
  if {[info exists boxes($box)]} {
    for {set n 0} {$n < [llength $boxes($box)]} {incr n} {
      set lbl [lindex $boxes($box) $n]
      set focal $focals($lbl)
      set power [expr ($box+1)*($n+1)*$focal]
      
      set sum [expr $sum+$power]
    }
  }
}

puts $sum
