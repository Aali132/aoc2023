open String
open List

let deopt lst = filter_map (fun x -> x) lst;;
let readinput() = deopt (map int_of_string_opt (split_on_char ' ' (read_line())));;

let times = readinput();;
let distances = readinput();;

let range a b = init (b - a) ((+) a);;

let result t x = x * (t - x);;

let outcomes t = map (fun x -> result t x) (range 1 t);;

let countwins (t, d) = length (filter (fun x -> x > d) (outcomes t));;

print_string (string_of_int (fold_left ( * ) 1 (map countwins (combine times distances))))
