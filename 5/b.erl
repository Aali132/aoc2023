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

parse_seed_ranges([]) -> [];
parse_seed_ranges([S1|Seed]) -> parse_seed_ranges(S1,Seed).
parse_seed_ranges(S1,[S2|Seed]) -> [{ S1,S1+S2-1 } | parse_seed_ranges(Seed)].

read_input() -> 
  Seed = parse_seed_ranges(read_integers(io:get_line(""), 1)),
  _ = io:get_line(""),
  { Seed, read_all_sections() }.

apply_map({Start,End}, []) -> [{Start,End}];
apply_map({Start,End}, [M|Map]) ->
  [Dstart, Sstart, Range] = M,
  if
    (Start >= Sstart) and (End < Sstart+Range) -> [{Start - Sstart + Dstart,End - Sstart + Dstart}];
    (End < Sstart) -> apply_map({Start,End},Map);
    (Start >= Sstart+Range) -> apply_map({Start,End},Map);
    (Start >= Sstart) and (End >= Sstart+Range) -> [{Start - Sstart + Dstart,Dstart + Range-1} | apply_map({Sstart+Range,End},Map)];
    (Start < Sstart) and (End < Sstart+Range) -> [{Dstart,End - Sstart + Dstart} | apply_map({Start,Sstart-1},Map)];
    true -> [{Dstart,Dstart+Range} | (apply_map({Start,Sstart-1},Map) ++ apply_map({Sstart+Range-1,End},Map))]
  end.

map_seed(Seed, []) -> [Seed];
map_seed(Seed, [M|Maps]) ->
  ApplyFun = fun(S) -> apply_map(S, M) end,
  map_seed(lists:flatten(lists:map(ApplyFun, Seed)), Maps).

main(_) -> 
  { Seeds, Maps } = read_input(),
  MapFun = fun(S) -> map_seed(S, Maps) end,
  { Start, _ } = lists:min(lists:flatten(MapFun(Seeds))),
  io:fwrite("~w~n", [Start]).
