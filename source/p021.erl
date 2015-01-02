-module (p021).
-export ([solve/0]).

%% Correct: 31626

solve() ->
    L = lists:seq(1,10000),
    F = fun(X) -> is_amicable(X) end,
    Numbers = lists:filter(F, L),
    lists:sum(Numbers).

is_amicable(N) ->
    Pair_candidate = sum_of_factors(N),
    (sum_of_factors(Pair_candidate) == N) and (Pair_candidate =/= N).

sum_of_factors(N) ->
    F = factors(N),
    lists:sum(F) - N.

factors(N) ->
    [I || I <- lists:seq(1,trunc(N/2)), N rem I == 0]++[N].