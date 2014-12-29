-module (p007).
-export ([run/0]).

run() ->
    prime_number(10001).

prime_number(1) -> 2;
prime_number(N) -> prime(3,N-1,[2]).

prime(N, Counter, Acc) ->
    case is_prime(N, math:sqrt(N), Acc) of
        true ->
            case Counter of
                1 ->
                    N;
                _ -> prime(N + 2, Counter - 1, Acc ++ [N])
            end;
        _ -> prime(N + 2, Counter, Acc)
    end.

%Test if divisible by one of the previous primes.
%The list of primes has to be sorted in ascending order.
%We only need to check bellow or equal to sqrt(N)
is_prime(_, _, []) -> true;
is_prime(N, Sqrt, [H|T]) ->
    case (H > Sqrt) of
        true -> true;
        _ -> (N rem H =/= 0) andalso is_prime(N, Sqrt, T)
    end.