-module (p055).
-export ([solve/0]).

%% Borrowed from https://github.com/jamesaimonetti/ProjectEuler
%%Link: https://projecteuler.net/problem=55
%% Correct: 249

-define(MAX_ITERATIONS, 50).

solve() ->
    length(lists:filter(fun is_lychrel/1, lists:seq(1,10000))).
    is_lychrel(N) -> is_lychrel(rev_add(N), 0).
    is_lychrel(_N, ?MAX_ITERATIONS) -> true;
    is_lychrel(N, I) ->
    case my_math:is_palindrome(N) of
        true -> false;
        false -> is_lychrel(rev_add(N), I+1)
    end.

rev_add(N) ->
    N2 = list_to_integer(lists:reverse(integer_to_list(N))),
    N+N2.