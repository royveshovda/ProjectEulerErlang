-module (problem003).
-export ([run/0]).

%%Problem: https://projecteuler.net/problem=3
%%Correct: ??

run() ->
    find_factors(600851475143,2,[]).

find_factors(N, F, Acc) when (N / 2 >= F) ->
    if
        (N rem F == 0) -> find_factors(N, F+1, [F|Acc]);
        true -> find_factors(N, F+1, Acc)
    end;
find_factors(N, F, Acc) when (N / 2 < F) ->
    Acc.