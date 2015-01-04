-module (p056).
-export ([solve/0]).
-import (my_math, [pow/2]).
-import (helper, [to_digits/1]).

%%Link: https://projecteuler.net/problem=56
%% Correct: 972

solve() ->
    Candidates = [ digital_sum(pow(A, B)) || A <- lists:seq(1,99), B <- lists:seq(1,99) ],
    lists:max(Candidates).

digital_sum(N) ->
    Ds = to_digits(N),
    lists:sum(Ds).
    %lists:foldl(fun(D, Acc) -> (D-$0) + Acc end, 0, integer_to_list(N)).