-module (problem020).
-export ([run/0]).

%% Solution: 648

run() ->
    S = get_number(),
    D = get_digits(S),
    lists:sum(D).

get_digits(S) ->
    L = string:len(S),
    I = lists:seq(1,L),
    S_with_rest = [string:to_integer(string:substr(S,X,1)) || X <- I],
    [X || {X,_} <- S_with_rest].

factorial(1) ->
    1;
factorial(N) ->
    N* factorial(N-1).

get_number() ->
    N = factorial(100),
    integer_to_list(N).