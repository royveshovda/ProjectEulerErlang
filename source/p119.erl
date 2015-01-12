-module (p119).
-export ([solve/0]).
-import (my_math, [pow/2]).
-import (helper, [to_digits/1]).

solve() ->
    Cs = lists:seq(2,400),
    R1 = lists:map(fun(C) -> expand(C) end, Cs),
    R2 = lists:flatten(R1),
    Results = lists:sort(R2),
    lists:nth(30,Results).

expand(X) ->
    Ys = lists:seq(2,50),
    Cs = lists:filter(fun(Y) -> check(X,Y) end, Ys),
    lists:map(fun(Y) -> pow(X,Y) end, Cs).

check(X,Y) ->
    V = pow(X,Y),
    digit_sum(V) == X.

digit_sum(N) ->
    D = to_digits(N),
    lists:sum(D).