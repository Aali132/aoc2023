let sum=0

while read input ; do
  winning=$(cut -d '|' -f 1 <<< $input)
  winning=$(cut -d ':' -f 2 <<< $winning)
  mynumbers=$(cut -d '|' -f 2 <<< $input)

  let points=1

  for win in $winning ; do
    if grep -qw $win <<< $mynumbers ; then
      let points=$points*2
    fi
  done

  let points=$points/2
  let sum=$sum+$points
done

echo $sum
