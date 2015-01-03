-module (p058).
-export ([solve/0]).

%% Borrowed from https://github.com/jamesaimonetti/ProjectEuler
%%Link: https://projecteuler.net/problem=58
%% Correct: 26241

solve() ->
    primes_in_corners(3, 5, 5).

primes_in_corners(NumP, Tot, N) when NumP / Tot < 0.100000000 -> N-2;
primes_in_corners(NumP, Tot, N) ->
    C = N * N,
    Corners =   [C - N+1
                ,C - (2*N) + 2
                ,C - (3*N) + 3
                ],
    Ps = length(lists:filter(fun primes:is_prime/1, Corners)),
    primes_in_corners(NumP+Ps, Tot+4, N+2).