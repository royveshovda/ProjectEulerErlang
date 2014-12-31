-module (p020).
-export ([run/0]).
-import (calculator, [to_digits/1, factorial/1]).

%% Solution: 648

run() ->
    N = factorial(100),
    D = to_digits(N),
    lists:sum(D).