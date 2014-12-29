-module (p021).
-export ([run/0]).

run() ->
    L = lists:seq(1,10000),
    F = fun(X) -> is_amicable(X) end,
    Numbers = lists:filter(F, L),
    %[{X, sum_of_factors(X)} || X <- Numbers].
    lists:sum(Numbers).
    %Numbers.

is_amicable(N) ->
    Pair_candidate = sum_of_factors(N),
    (sum_of_factors(Pair_candidate) == N) and (Pair_candidate =/= N).

sum_of_factors(N) ->
    F = factors(N),
    lists:sum(F) - N.

factors(N) ->
    [I || I <- lists:seq(1,trunc(N/2)), N rem I == 0]++[N].