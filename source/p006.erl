-module (problem006).
-export ([run/0]).

%%Correct: 25164150

%%Sum of i where i from 1 to n = n * (n+1)/2 = 5050
%%Sum of 1^2 where i from 1 to n = n(n+1)(2n+1)/6 = 338350
%%Result = 5050^2 - 338350 = 25164150

run() ->
    N = 100,
    S1 = N * (N+1) / 2,
    S2 = N * (N+1) * (2*N+1) / 6,
    S = (S1*S1) - S2,
    S.

    %%L = lists:seq(1,N),
    %%Sum_of_squares = lists:sum([X*X || X <- L]),
    %%Sum = lists:sum(L),
    %%Square_of_sum = Sum*Sum,
    %%Square_of_sum - Sum_of_squares.
