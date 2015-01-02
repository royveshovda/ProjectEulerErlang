-module (p037).
-export ([run/0]).
-import (calculator, [to_digits/1, assemble_number/1, is_prime/1, primes_below/1]).

%% Correct: 748317

run() ->
    Primes = primes_below(800000),
    Above10 = lists:filter(fun(X) -> X > 10 end, Primes),
    Results = lists:filter(fun(X) -> is_valid(X) end, Above10),
    lists:sum(Results).
    
is_valid(N) ->
    Ds = to_digits(N),
    L = check_left(Ds),
    R = check_right(Ds),
    L and R.

check_left([_|[]]) -> true;
check_left([_|Digits]) ->
    N = assemble_number(Digits),
    case is_prime(N) of
        false -> false;
        true -> check_left(Digits)
    end.

check_right([Digit])->
    is_prime(Digit);
check_right(Digits) ->
    [_|Raw] = lists:reverse(Digits),
    Ds = lists:reverse(Raw),
    N = assemble_number(Ds),
    case is_prime(N) of
        false -> false;
        true -> check_right(Ds)
    end.