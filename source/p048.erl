-module (p048).
-export ([run/0]).

%% Correct: 9110846700

run() ->
    Ns = lists:seq(1,1000),
    Products = lists:map(fun(X) -> pow(X,X) end, Ns),
    Solution = lists:sum(Products),
    Digits = integer_to_list(Solution),
    Length = length(Digits),
    list_to_integer(lists:sublist(Digits, Length-9,10)).

pow(X, N) when is_integer(N), N >= 0 -> pow(X, N, 1);
pow(X, N) when is_integer(N) -> 1 / pow(X, -N, 1);
pow(X, N) when is_float(N) -> math:pow(X, N).

pow(_, 0, P) -> P;
pow(X, N, A) when N rem 2 =:= 0 ->
    pow(X * X, N div 2, A);
pow(X, N, A) -> pow(X, N - 1, A * X).