let sum=0
let index=0
declare -a cards

while read input ; do
  winning=$(cut -d '|' -f 1 <<< $input)
  winning=$(cut -d ':' -f 2 <<< $winning)
  mynumbers=$(cut -d '|' -f 2 <<< $input)

  let points=0
  declare -i numcards=${cards[$index]}
  let numcards=$numcards+1

  for win in $winning ; do
    if grep -qw $win <<< $mynumbers ; then
      let points=$points+1
    fi
  done
  
  for newcard in $(seq 1 $points) ; do
    let ni=index+$newcard
    let cards[$ni]=${cards[$ni]}+$numcards
  done

  let sum=$sum+$numcards
  let index=$index+1
done

echo $sum
