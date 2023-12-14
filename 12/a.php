<?php
  function simplify($seq) {
    $index = 0;
    $ingroup = false;
    
    for($i = 0; $i < strlen($seq); $i++) {
      if($seq[$i] == ".") {
        if($ingroup) {
          $seq[$index++] = ".";
          $ingroup = false;
        }
      } else {
        $seq[$index++] = "#";
        $ingroup = true;
      }
    }
    
    if(!$ingroup) {
      $index--;
    }
    
    return substr($seq, 0, $index);
  }

  function check_all($seq, $target, $count) {
    $first = strpos($seq, "?");
    
    if($first === false) {
      if($count > 0) {
        return 0;
      }
      
      return simplify($seq) === $target ? 1 : 0;
    } else {
      if($count > 0) {
        $s1 = $seq;
        $s1[$first] = '#';
        $s2 = $seq;
        $s2[$first] = '.';
        
        return check_all($s1, $target, $count-1) + check_all($s2, $target, $count);
      } else {
        $seq[$first] = ".";
        
        return check_all($seq, $target, 0);
      }
    }
  }
  
  $sum = 0;
  
	while(fscanf(STDIN, "%s %s", $seq, $groups) == 2) {
	  $groups = explode(",", $groups);
	  
	  $count = 0;
	  $target = "";
	  
	  foreach ($groups as $group) {
	    $g = intval($group);
	    $count += $g;
	    
	    if($target != "") {
	      $target = $target . ".";
	    }
	    
	    $target = $target . str_repeat("#", $g);
	  }
	  
	  $count = $count - substr_count($seq, "#");
	  
	  $sum = $sum + check_all($seq, $target, $count);
	}
	
	echo $sum;
?>
