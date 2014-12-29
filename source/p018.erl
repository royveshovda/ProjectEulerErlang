-module (p018).
-export ([run/0]).

%% Correct: 1074

run() ->
    Tree = get_tree(),
    Current = lists:nth(15, Tree),
    build(Tree, Current,15,15).

build([[Root]|_], Current , 2, _) ->
    Root + max(lists:nth(1,Current), lists:nth(2,Current));
build(Tree, Current, Level, Depth) ->
    Next = lists:nth(Level-1, Tree),
    Length = length(Next),
    Next_Current = [lists:nth(X, Next) + max(lists:nth(X,Current), lists:nth(X+1,Current)) || X <- lists:seq(1,Length)],
    io:format("~p~n", [Next_Current]),
    build(Tree, Next_Current,Level-1, Depth).

get_tree() ->
    Rows =
        [[75],
        [95, 64],
        [17, 47, 82],
        [18, 35, 87, 10],
        [20, 4, 82, 47, 65],
        [19, 1, 23, 75, 3, 34],
        [88, 2, 77, 73, 7, 63, 67],
        [99, 65, 4, 28, 6, 16, 70, 92],
        [41, 41, 26, 56, 83, 40, 80, 70, 33],
        [41, 48, 72, 33, 47, 32, 37, 16, 94, 29],
        [53, 71, 44, 65, 25, 43, 91, 52, 97, 51, 14],
        [70, 11, 33, 28, 77, 73, 17, 78, 39, 68, 17, 57],
        [91, 71, 52, 38, 17, 14, 91, 43, 58, 50, 27, 29, 48],
        [63, 66, 4, 68, 89, 53, 67, 30, 73, 16, 69, 87, 40, 31],
        [ 4, 62, 98, 27, 23, 9, 70, 98, 73, 93, 38, 53, 60, 4, 23]],
    Rows.