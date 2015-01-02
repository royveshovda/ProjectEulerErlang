-module (p020).
-export ([solve/0]).
-import (calculator, [to_digits/1, factorial/1]).

%%Link: https://projecteuler.net/problem=20
%% Solution: 648

solve() ->
    N = factorial(100),
    D = to_digits(N),
    lists:sum(D).