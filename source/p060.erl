-module (p060).
-export ([solve/0]).
-import (helper, [to_digits/1, assemble_number/1]).

solve() ->
    prime_server:start_link(20000),
    Primes = prime_server:sieve(20000),
    Pair_candidates = [{A,B}|| A <- Primes, B <- Primes, B>A],
    Pairs = lists:filter(fun({A,B}) -> is_pair(A,B) end, Pair_candidates),
    length(Pairs).
    %is_pair(7,109).

is_pair(A,B) ->
	As = to_digits(A),
	Bs = to_digits(B),
	AB = assemble_number(As ++ Bs),
	BA = assemble_number(Bs ++ As),
	prime_server:is_prime(AB) andalso prime_server:is_prime(BA).
