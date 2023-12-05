read_integers(Line, Skip) ->
  StrNumbers = lists:nthtail(Skip, re:split(string:strip(Line, right, 10), "\s+", [notempty])),
  lists:map(fun erlang:list_to_integer/1, lists:map(fun erlang:binary_to_list/1, StrNumbers)).

read_until_empty() -> 
  case io:get_line("") of
  eof -> [];
  "\n" -> [];
  Line -> [read_integers(Line,0) | read_until_empty()]
  end.

read_section() -> 
  _ = io:get_line(""),
  read_until_empty().

read_all_sections() -> 
  case read_section() of
  [] -> [];
  S -> [S | read_all_sections()]
  end.

read_input() -> 
  Seed = read_integers(io:get_line(""), 1),
  _ = io:get_line(""),
  { Seed, read_all_sections() }.

apply_map(Num, []) -> Num;
apply_map(Num, [M|Map]) ->
  [Dstart, Sstart, Range] = M,
  if
    (Num >= Sstart) and (Num < Sstart+Range) -> Num - Sstart + Dstart;
    true -> apply_map(Num,Map)
  end.

map_seed(Seed, []) -> Seed;
map_seed(Seed, [M|Maps]) -> map_seed(apply_map(Seed, M), Maps).
  
main(_) -> 
  shell:strings(false),
  { Seeds, Maps } = read_input(),
  MapFun = fun(S) -> map_seed(S, Maps) end,
  io:fwrite("~w~n", [lists:min(lists:map(MapFun, Seeds))]).
