-module (p036).
-export ([solve/0]).

%%Link: https://projecteuler.net/problem=36
%% Correct: 872187

solve() ->
    Candidates = lists:seq(1,1000000),
    Pals = lists:filter(fun(X) -> is_2_base_palindrome(X) end, Candidates),
    lists:sum(Pals).

is_2_base_palindrome(N) ->
    
    case is_palindrome(N) of
        false -> false;
        true ->
            S = int_to_bits(N),
            is_palindrome(S)
    end.

int_to_bits(N) ->
    [S] = io_lib:format("~.2B", [N]),
    S.

is_palindrome(N) when is_integer(N) ->
    Rev = list_to_integer(lists:reverse(integer_to_list(N))),
    Rev == N;
is_palindrome(S) ->
    S == lists:reverse(S).
