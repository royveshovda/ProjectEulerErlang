-module (p037).
-export ([solve/0]).
-import (calculator, [to_digits/1, assemble_number/1]).

%%Link: https://projecteuler.net/problem=37
%% Correct: 748317

solve() ->
    prime_server:start_link(800000),
    Primes = prime_server:sieve(800000),
    Above10 = lists:filter(fun(X) -> X > 10 end, Primes),
    Results = lists:filter(fun(X) -> is_valid(X) end, Above10),
    prime_server:stop(),
    lists:sum(Results).
    
is_valid(N) ->
    Ds = to_digits(N),
    L = check_left(Ds),
    R = check_right(Ds),
    L and R.

check_left([_|[]]) -> true;
check_left([_|Digits]) ->
    N = assemble_number(Digits),
    case prime_server:is_prime(N) of
        false -> false;
        true -> check_left(Digits)
    end.

check_right([Digit])->
    prime_server:is_prime(Digit);
check_right(Digits) ->
    [_|Raw] = lists:reverse(Digits),
    Ds = lists:reverse(Raw),
    N = assemble_number(Ds),
    case prime_server:is_prime(N) of
        false -> false;
        true -> check_right(Ds)
    end.