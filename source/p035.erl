-module (p035).
-export ([run/0]).
-import (calculator, [to_digits/1, assemble_number/1, is_prime/1]).

%% Correct: 55

run() ->
    Primes = prime_below(1000000),
    Circulars = lists:filter(fun(X) -> all_rotation_prime(X) end, Primes),
    length(Circulars).

all_rotation_prime(N) ->
    Rs = rotations(N),
    length(Rs) == length(lists:filter(fun(X) -> is_prime(X) end, Rs)).

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

prime_below(1) -> 2;
prime_below(Max) -> prime(3,Max,[2]).

prime(N, Max, Acc) ->
    case is_prime(N, math:sqrt(N), Acc) of
        true ->
            case N > Max of
                true ->
                    Acc;
                false -> prime(N + 2, Max, Acc ++ [N])
            end;
        _ -> prime(N + 2, Max, Acc)
    end.

is_prime(_, _, []) -> true;
is_prime(N, Sqrt, [H|T]) ->
    case (H > Sqrt) of
        true -> true;
        _ -> (N rem H =/= 0) andalso is_prime(N, Sqrt, T)
    end.