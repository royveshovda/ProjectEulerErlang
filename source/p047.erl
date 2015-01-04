-module (p047).
-export ([solve/0]).

solve() ->
    prime_server:start_link(200000),
    Ans = find(2*3*5*7, 4, 0),
    prime_server:stop(),
    Ans.

find(X, Cnt, Cnt) -> X-Cnt;
find(X, Cnt, Fnd) ->
    case prime_server:count_factors(X) =:= Cnt of
        true ->
            find(X+1, Cnt, Fnd+1);
        false ->
            find(X+1, Cnt, 0)
    end.