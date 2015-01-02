-module (p052).
-export ([solve/0]).
-import (calculator, [to_digits/1]).

%% Correct: 142857

solve() ->
    check(n_list(2)).

check([N|Ns]) ->
    case is_valid(N) of
        true -> N;
        false -> check(Ns())
    end.

is_valid(N) ->
    D1 = lists:sort(to_digits(N)),
    (D1 == lists:sort(to_digits(N*2)))
        andalso (D1 == lists:sort(to_digits(N*3)))
        andalso (D1 == lists:sort(to_digits(N*4)))
        andalso (D1 == lists:sort(to_digits(N*5)))
        andalso (D1 == lists:sort(to_digits(N*6))).

n_list(N) -> [N | fun() -> n_list(N+1) end].