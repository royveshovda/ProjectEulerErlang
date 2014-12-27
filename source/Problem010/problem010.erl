-module (problem010).
-export ([run/0]).

run() ->
    solution(2000000).


solution(N) ->
    prime(3, N, math:sqrt(N), 2, [2]).

prime(N, Max, _, Sum, _) when N >= Max -> Sum;
prime(N, Max, SqrtMax,Sum, Primes) ->
    case is_prime(N, math:sqrt(N), Primes) of
        true ->
            case N < SqrtMax of
                true ->
                    %keep it for testing later numbers for primality
                    prime(N + 2, Max, SqrtMax, Sum + N, Primes++[N]);
                _ ->
                    %no need to use for further tests, so we won't keep it
                    prime(N + 2, Max, SqrtMax, Sum + N, Primes)
            end;
        _ -> prime(N + 2, Max, SqrtMax,Sum, Primes)
    end.


is_prime(_, _, []) -> true;
is_prime(N, Sqrt, [H|T]) ->
    case (H > Sqrt) of
        true -> true;
        _ -> (N rem H =/= 0) andalso is_prime(N, Sqrt, T)
    end.