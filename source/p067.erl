-module (p067).
-export ([solve/0]).
-import (p018, [evaluate/1]).

%%Link: https://projecteuler.net/problem=67
%% Correct: 7273

solve() ->
    Filename = "data/p067_triangle.txt",
    p018:evaluate(Filename).