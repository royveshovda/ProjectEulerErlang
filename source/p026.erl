-module (p026).
-export ([solve/0]).

%% Correct: 983

solve() ->
    Candidates = lists:seq(1,1000),
    Lengths = lists:map(fun(X) -> cycle_length(X) end, Candidates),
    lists:max(Lengths) +1.

cycle_length(N)->
    next(10, N, ets:new(lookup, []), 0).

next(0, _, _, _) -> 0;
next(X, D, Tbl, Acc) ->
    Old = ets:lookup(Tbl, {X, D}),
    case Old of
        [] ->
            ets:insert(Tbl, {{X, D}, true}),
            next((X rem D) * 10, D, Tbl, Acc + 1);
        _ -> Acc
    end.