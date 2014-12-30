-module (p025).
-export ([run/0]).
-import (calculator, [pow/2]).

%% Correct: 4782

run()->
    fib(1,1,2,pow(10,999)).
    
fib(_A, _B, Index, _Limit) when _B >= _Limit ->
    Index;
fib(A, B, Index, Limit) ->
    C = A + B,
    fib(B, C, Index+1, Limit).