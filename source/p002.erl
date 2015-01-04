-module (p002).
-export ([solve/0]).

solve() ->
    fibonachi_below(4000000).
    
fibonachi_below(Max) ->
    fibonachi(1,2, 0, Max).

fibonachi(_P1, _P2, Sum, Max) when _P2 >= Max ->
    Sum;
fibonachi(P1, P2, Sum, Max) ->
    P3 = P1 + P2,
    New_sum = sum(P2, Sum),
    fibonachi(P2, P3, New_sum, Max).

sum(N, Sum) ->
    if
        (N rem 2 == 0) -> Sum + N;
        true -> Sum
    end.

