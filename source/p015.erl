-module (p015).
-export ([run/0]).

%Correct: 137846528820

run() ->
    calculate(20,20).

calculate(X,Y) ->
    trunc(factorial(X+Y) / (factorial(X) * factorial(Y))).

factorial(1) ->
    1;
factorial(N) ->
    N* factorial(N-1).