-module (p007).
-export ([solve/0]).

solve() ->
    prime_server:start_link(200000),
    Ans = prime_server:nth(10001),
    prime_server:stop(),
    Ans.