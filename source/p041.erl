-module (p041).
-export ([run/0]).
-import (calculator, [get_digits/1, assemble_number/1, is_prime/1, permute/1]).

%% Correct: 7652413

run() ->
    find_below(9).

find_below(Limit) ->
    L = lists:seq(1,Limit),
    Candidates = permute(L),
    Numbers = lists:map(fun(X) -> calculator:assemble_number(X) end, Candidates),
    Primes = lists:filter(fun(X) -> calculator:is_prime(X) end, Numbers),
    Length = length(Primes),
    if
        Length > 0 -> 
            lists:max(lists:filter(fun(X) -> is_pan_digital(X) end, Primes));
        Length == 0 ->
            find_below(Limit-1)
    end.

is_pan_digital(N) ->
    Ns = get_digits(N),
    Length = length(Ns),
    lists:usort(Ns) == lists:seq(1,Length).