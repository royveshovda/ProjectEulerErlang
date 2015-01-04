-module (p025).
-export ([solve/0]).
-import (my_math, [pow/2]).

%%Link: https://projecteuler.net/problem=25
%% Correct: 4782

solve()->
    fib(1,1,2,pow(10,999)).
    
fib(_A, _B, Index, _Limit) when _B >= _Limit ->
    Index;
fib(A, B, Index, Limit) ->
    C = A + B,
    fib(B, C, Index+1, Limit).