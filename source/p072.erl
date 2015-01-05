-module (p072).
-export ([solve/0]).
-import (my_math, [gcd/2, totient/1, totient_phi_improved/1]).

solve() ->
    Limit = 1000000,
    Numbers = lists:seq(2,Limit),
    Totients = lists:map(fun(X) -> totient_phi_improved(X) end, Numbers),
    lists:sum(Totients).