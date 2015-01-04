-module (p034).
-export ([solve/0]).

solve() ->
    Max = 2540160,
    Candidates = lists:seq(3, Max),
    Factorials = digit_factorials(),
    lists:sum(lists:filter(fun(X) -> check(X, Factorials) end, Candidates)).

check(N, Factorials) ->
    N == number_to_facsum(N,Factorials,0).
    
number_to_facsum(0, _, Acc) ->
    Acc;
number_to_facsum(N, Factorials, Acc) ->
    number_to_facsum(N div 10, Factorials, array:get(N rem 10, Factorials) + Acc).

digit_factorials() ->
    A1 = array:set(0, 1, array:new(10)),
    lists:foldl(fun(X, Acc) -> array:set(X, X * array:get(X - 1, Acc), Acc) end, A1, lists:seq(1, 9)).