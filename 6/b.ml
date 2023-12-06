open String
open List
open Float

let readinput() = float_of_string (String.concat "" (tl (split_on_char ' ' (read_line()))));;

let time = readinput();;
let distance = readinput();;

let xf = sub (div time 2.0) (sqrt (sub ((div time 2.0)**2.0) (add distance 1.0)))
let x = int_of_float (ceil xf);;

let ti = int_of_float time;;

print_string (string_of_int ((ti+1) - x * 2))
