-module (p018).
-export ([solve/0, evaluate/1]).

solve() ->
    Filename = "data/p018_triangle.txt",
    evaluate(Filename).

evaluate(Filename) ->
    Tree = open_file(Filename),
    build(Tree).

build(Tree) ->
    Levels = length(Tree),
    Current = lists:nth(Levels, Tree),
    build(Tree, Current,Levels,Levels).

build([[Root]|_], Current , 2, _) ->
    Root + max(lists:nth(1,Current), lists:nth(2,Current));
build(Tree, Current, Level, Depth) ->
    Next = lists:nth(Level-1, Tree),
    Length = length(Next),
    Next_Current = [lists:nth(X, Next) + max(lists:nth(X,Current), lists:nth(X+1,Current)) || X <- lists:seq(1,Length)],
    build(Tree, Next_Current,Level-1, Depth).

open_file(Filename) ->
    {ok, Device} = file:open(Filename, [read]),
    Result = file:read_line(Device),
    Lines = read_lines(Device, Result, []),
    file:close(Device),
    Lines.

read_lines(Device, {ok, Data}, Acc) ->
    Trimmed = string:strip(Data, right, $\n),
    Splitted = string:tokens(Trimmed, " "),
    Ints = lists:map(fun(X) -> {I,_} = string:to_integer(X), I end, Splitted),
    Result = file:read_line(Device),
    read_lines(Device, Result, [Ints|Acc]);
read_lines(_Device, eof, Acc) ->
    lists:reverse(Acc).