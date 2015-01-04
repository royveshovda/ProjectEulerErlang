-module (p023).
-export ([solve/0]).

solve() ->
    Max = 28123,
    Candidates = lists:seq(1,Max),
    Abundant = lists:filter(fun(X) -> is_abundant(X) end, Candidates),
    Sums = [A+B|| A <- Abundant, B <- Abundant],
    Limited = lists:filter(fun(X) -> X =< Max end, Sums),
    Distinct = lists:usort(Limited),
    All = lists:sum(Candidates),
    Abundants = lists:sum(Distinct),
    Result = All - Abundants,
    Result.

is_abundant(N) ->
    sum_of_factors(N) > N.

sum_of_factors(N) ->
    F = factors(N),
    lists:sum(F) - N.

factors(N) ->
    [I || I <- lists:seq(1,trunc(N/2)), N rem I == 0]++[N].