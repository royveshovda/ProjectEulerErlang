-module (p030).
-export ([solve/0]).
-import (helper, [to_digits/1]).
-import (my_math, [pow/2]).

solve() ->
    Candidates = lists:seq(2,500000),
    Powers = lists:filter(fun(X) -> check(X) end, Candidates),
    lists:sum(Powers).

check(N) ->
    Digits = to_digits(N),
    N == lists:sum([pow(X,5) || X <- Digits]).