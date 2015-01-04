-module (p035).
-export ([solve/0]).
-import (helper, [to_digits/1, assemble_number/1]).

%%Link: https://projecteuler.net/problem=35
%% Correct: 55

solve() ->
    prime_server:start_link(1000000),
    Primes = prime_server:sieve(1000000),
    Circulars = lists:filter(fun(X) -> all_rotation_prime(X) end, Primes),
    Ans = length(Circulars),
    prime_server:stop(),
    Ans.

all_rotation_prime(N) ->
    Rs = rotations(N),
    length(Rs) == length(prime_server:filter_primes(Rs)).

rotations(N) ->
    Digits = to_digits(N),
    Size = length(Digits),
    Splits = lists:seq(2,Size),
    Lists = lists:map(fun(X) -> split(Digits, Size, X) end, Splits),
    lists:map(fun(X) -> assemble_number(X) end, Lists).

split(List, Size, Pos) ->
    Part1 = lists:sublist(List, Pos, Size -Pos+1),
    Part2 = lists:sublist(List, Pos-1),
    Part1 ++ Part2.