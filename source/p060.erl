-module (p060).
-export ([solve/0]).

solve() ->
    prime_server:start_link(20000),
    Primes = prime_server:sieve(20000),
    Primes.