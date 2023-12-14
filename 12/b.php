<?php
  $sum = 0;
  
	while(fscanf(STDIN, "%s %s", $seq1, $groups1) == 2) {
	  $seq = $seq1;
	  $groups = $groups1;
	  
	  for($i = 1; $i < 5; $i++) {
	    $seq = $seq . "?" . $seq1;
	    $groups = $groups . "," . $groups1;
	  }
	  
	  $group_array = explode(",", $groups);
	  $seq = $seq . ".";
	  
	  $num_groups = count($group_array);
	  $seqlen = strlen($seq);
	  
	  $longest = array_fill(0, $seqlen+1, 0);
	  
	  for($i = 0; $i < $seqlen; $i++) {
      if($seq[$i] != ".") {
        $longest[$i + 1] = $longest[$i] + 1;
      }
	  }
	  
	  $dyn = array_fill(0, $num_groups+1, array_fill(0, $seqlen+1, 0));
	  
	  $dyn[0][0] = 1;
	  
	  for($i = 0; $i < $seqlen; $i++) {
	    if($seq[$i] == "#") {
	      break;
	    }
	    
	    $dyn[0][$i+1] = 1;
	  }
	  
	  for($i = 0; $i < $num_groups; $i++) {
	    for($j = 0; $j < $seqlen; $j++) {
	      if($seq[$j] != "#") {
	        $group = $group_array[$i];
	        
	        $dyn[$i+1][$j+1] = $dyn[$i+1][$j] + ($group <= $longest[$j] ? $dyn[$i][$j - $group] : 0);
	      }
	    }
	  }
	  
	  $sum = $sum + $dyn[$num_groups][$seqlen];
	}
	
	echo $sum;
?>
