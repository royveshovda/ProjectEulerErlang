-module (p020).
-export ([solve/0]).
-import (helper, [to_digits/1]).
-import (my_math, [factorial/1]).

solve() ->
    N = factorial(100),
    D = to_digits(N),
    lists:sum(D).