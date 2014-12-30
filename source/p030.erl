-module (p030).
-export ([run/0]).
-import (calculator, [pow/2, get_digits/1]).

%% Correct: 443839

run() ->
    Candidates = lists:seq(2,500000),
    Powers = lists:filter(fun(X) -> check(X) end, Candidates),
    lists:sum(Powers).

check(N) ->
    Digits = get_digits(N),
    N == lists:sum([pow(X,5) || X <- Digits]).