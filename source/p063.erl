-module (p063).
-export ([solve/0]).
-import (calculator, [pow/2]).

%%Link: https://projecteuler.net/problem=63
%% Correct: 49

solve() ->
    length([ 1 || X <- lists:seq(1,10),Y <- lists:seq(1,22),
        length(integer_to_list(pow(X,Y))) == Y ]).