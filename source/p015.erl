-module (p015).
-export ([run/0]).
-import (calculator, [factorial/1]).

%Correct: 137846528820

run() ->
    calculate(20,20).

calculate(X,Y) ->
    trunc(factorial(X+Y) / (factorial(X) * factorial(Y))).