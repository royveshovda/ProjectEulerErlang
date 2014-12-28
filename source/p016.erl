-module (problem016).
-export ([run/0]).

%% Solution: 1366

run() ->
    S = get_number(),
    D = get_digits(S),
    lists:sum(D).

get_digits(S) ->
    L = string:len(S),
    I = lists:seq(1,L),
    S_with_rest = [string:to_integer(string:substr(S,X,1)) || X <- I],
    [X || {X,_} <- S_with_rest].

get_number() ->
    I = trunc(math:pow(2,1000)),
    integer_to_list(I).