-module (p067).
-export ([run/0]).
-import (p018, [evaluate/1]).

%% Correct: 7273

run() ->
    Filename = "../Problems/p067_triangle.txt",
    p018:evaluate(Filename).