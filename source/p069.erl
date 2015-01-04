-module (p069).
-export ([solve/0]).

%% Inspired from https://github.com/jamesaimonetti/ProjectEuler

solve() ->
    lists:foldl(fun(P, Prod) when Prod * P > 1000000 -> Prod;
                (P, Prod) -> Prod * P
                end, 1, primes:queue(100)).