-module (p071).
-export ([solve/0]).
-import (my_math, [gcd/2]).

%% Inspired from: http://www.mathblog.dk/project-euler-71-proper-fractions-ascending-order/

solve() ->
    Denominators = lists:seq(2,1000000),
    Pairs = lists:map(fun(D) -> {calculate_nominator(D), D} end, Denominators),
    With_value = lists:map(fun({N,D}) -> {N/D,N,D} end, Pairs),
    {_Value, Nom, _Denom} = lists:max(With_value),
    Nom.

calculate_nominator(Denominator) ->
    A = 3,
    B = 7,
    Nom = ((A * Denominator) -1) / B,
    trunc(Nom).