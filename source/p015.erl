-module (p015).
-export ([solve/0]).
-import (my_math, [factorial/1]).

solve() ->
    calculate(20,20).

calculate(X,Y) ->
    trunc(factorial(X+Y) / (factorial(X) * factorial(Y))).