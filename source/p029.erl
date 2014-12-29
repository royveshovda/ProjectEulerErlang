-module (p029).
-export ([run/0]).

%% Correct: 9183

run() ->
    As = lists:seq(2,100),
    Bs = lists:seq(2,100),
    Raw = [pow(A,B) || A <- As, B <- Bs],
    Distinct = lists:usort(Raw),
    length(Distinct).

pow(X, N) when is_integer(N), N >= 0 -> pow(X, N, 1);
pow(X, N) when is_integer(N) -> 1 / pow(X, -N, 1);
pow(X, N) when is_float(N) -> math:pow(X, N).

pow(_, 0, P) -> P;
pow(X, N, A) when N rem 2 =:= 0 ->
    pow(X * X, N div 2, A);
pow(X, N, A) -> pow(X, N - 1, A * X).