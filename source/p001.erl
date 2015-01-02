-module (p001).
-export([solve/0]).

%%Link: https://projecteuler.net/problem=1
%%Correct: 233168

solve() ->
    sum(999, 0).

sum(0, Acc) ->
    Acc;
sum(N, Acc) ->
    if
        ((N rem 5) =:= 0) -> sum(N-1, Acc+N);
        ((N rem 3) =:= 0) -> sum(N-1, Acc+N);
        true -> sum((N-1), Acc)
    end.