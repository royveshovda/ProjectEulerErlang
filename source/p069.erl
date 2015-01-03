-module (p069).
-export ([solve/0]).

%% Borrowed from https://github.com/jamesaimonetti/ProjectEuler
%%Link: https://projecteuler.net/problem=69
%% Correct: 510510

solve() ->
    lists:foldl(fun(P, Prod) when Prod * P > 1000000 -> Prod;
                (P, Prod) -> Prod * P
                end, 1, primes:queue(100)).