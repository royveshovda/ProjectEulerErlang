-module (p022).
-export ([solve/0]).
-import (helper, [alphabetical_value/1]).

solve() ->
    Filename = "data/p022_names.txt",
    Names = open_file(Filename),
    Sorted_list = lists:sort(Names),
    Indexed = apply_index(Sorted_list,1,[]),
    Weighted = lists:map(fun({V,I}) -> {V,I, alphabetical_value(V)} end, Indexed),
    Scored = lists:map(fun({V,I,W}) -> {V,I,W,I*W} end, Weighted),
    lists:foldl(fun({_,_,_,S}, Sum) -> Sum + S end, 0, Scored).

apply_index([], _Index, Acc) ->
    lists:reverse(Acc);
apply_index([Head|Tail], Index, Acc) ->
    Elem = {Head, Index},
    apply_index(Tail, Index+1, [Elem|Acc]).

open_file(Filename) ->
    {ok, Device} = file:open(Filename, [read]),
    {ok, Raw} = file:read_line(Device),
    file:close(Device),
    Tokens = string:tokens(Raw,","),
    [string:strip(X, both, $") || X <- Tokens].