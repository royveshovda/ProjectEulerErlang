-module (p025).
-export ([run/0]).

%% Correct: 4782

run()->
    fib(1,1,2,pow(10,999)).
    
fib(_A, _B, Index, _Limit) when _B >= _Limit ->
    Index;
fib(A, B, Index, Limit) ->
    C = A + B,
    fib(B, C, Index+1, Limit).
    
pow(X, N) when is_integer(N), N >= 0 -> pow(X, N, 1);
pow(X, N) when is_integer(N) -> 1 / pow(X, -N, 1);
pow(X, N) when is_float(N) -> math:pow(X, N).

pow(_, 0, P) -> P;
pow(X, N, A) when N rem 2 =:= 0 ->
    pow(X * X, N div 2, A);
pow(X, N, A) -> pow(X, N - 1, A * X).