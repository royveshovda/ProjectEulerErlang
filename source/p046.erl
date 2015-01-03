-module (p046).
-export ([solve/0]).

%%Link: https://projecteuler.net/problem=46
%% Correct: 5777

solve() ->
    prime_server:start_link(10000),
    Odds = odds(3, prime_server:sieve(9999)),
    Ans = first(Odds),
    prime_server:stop(),
    Ans.

first({O, N}) ->
    case is_goldbach(O) of
        true -> first(N());
        false -> O
    end.

odds(Odd, Primes) ->
    case lists:member(Odd, Primes) of
        true ->
            odds(Odd+2, Primes);
        false ->
            { Odd, fun() -> odds(Odd+2, Primes) end}
    end.

is_goldbach(N) ->
    Primes = prime_server:sieve(N),
    is_goldbach(N, Primes, [ X*X*2 || X <- lists:seq(1, N-2) ] ).

is_goldbach(_, [], _) -> false;
is_goldbach(N, [P|Ps], Sqrs) ->
    case length([ X || X <- Sqrs, P+X =:= N ]) > 0 of
        true -> true;
        false -> is_goldbach(N, Ps, Sqrs)
    end.