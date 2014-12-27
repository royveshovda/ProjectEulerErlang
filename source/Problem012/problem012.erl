-module (problem012).
-export ([run/0]).

run() ->
    %next_step(1,0,0).
    check(6 ).

check(N) ->
    Sum = trunc(N*(N+1)/2).
    %F = factors(Sum),
    %Length = length(F),
    %next_step(N, Length, Sum).


next_step(_N, Length, Sum) when Length >= 500 ->
    Sum;
next_step(N, Length, _) ->
    io:format   ("~p (~p)~n", [N, Length]),
    check(N*10). 
    

factors(N) ->
    factors(N,N,[]).

factors(_, 1, Factors) ->
    [1|Factors];
factors(Number, Factor, Factors) when Number rem Factor == 0 ->
    factors(Number, Factor-1, [Factor|Factors]);
factors(Number, Factor, Factors) ->
    factors(Number, Factor-1, Factors).