-module (p067).
-export ([solve/0]).
-import (p018, [evaluate/1]).

solve() ->
    Filename = "data/p067_triangle.txt",
    p018:evaluate(Filename).