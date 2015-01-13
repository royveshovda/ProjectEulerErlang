-module (p065).
-export ([solve/0]).
-import (helper, [to_digits/1]).

solve() ->
    D = 1,
    N = 2,
    Result = calc(2,D,N),
    digit_sum(Result).

calc(101, _D, N) -> N;
calc(I, D, N) when (I rem 3 == 0) ->
    C = trunc (2 * (I / 3)),
    N_next = C * N + D,
    calc(I+1, N, N_next);
calc(I, D, N) when (I rem 3 /= 0) ->
    C = 1,
    N_next = (C * N) + D,
    calc(I+1, N, N_next).

digit_sum(N) ->
    D = to_digits(N),
    lists:sum(D).