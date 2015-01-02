-module (p067).
-export ([solve/0]).
-import (p018, [evaluate/1]).

%% Correct: 7273

solve() ->
    Filename = "../Problems/p067_triangle.txt",
    p018:evaluate(Filename).