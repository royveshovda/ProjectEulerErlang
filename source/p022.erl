-module (p022).
-export ([run/0]).

%% Correct: 871198282

run() ->
    Filename = "../Problems/p022_names.txt",
    Names = open_file(Filename),
    Sorted_list = lists:sort(Names),
    Indexed = apply_index(Sorted_list,1,[]),
    Weighted = lists:map(fun({V,I}) -> {V,I, alphabetical_value(V)} end, Indexed),
    Scored = lists:map(fun({V,I,W}) -> {V,I,W,I*W} end, Weighted),
    lists:foldl(fun({_,_,_,S}, Sum) -> Sum + S end, 0, Scored).

apply_index([], _Index, Acc) ->
    lists:reverse(Acc);
apply_index([Head|Tail], Index, Acc) ->
    Elem = {Head, Index},
    apply_index(Tail, Index+1, [Elem|Acc]).


open_file(Filename) ->
    {ok, Device} = file:open(Filename, [read]),
    {ok, Raw} = file:read_line(Device),
    file:close(Device),
    Tokens = string:tokens(Raw,","),
    [string:strip(X, both, $") || X <- Tokens].    

alphabetical_value(String) ->
    L = string:len(String),
    C = [string:substr(String, I,1) || I <- lists:seq(1,L)],
    lists:sum([alphabetical_value_for_char(X) || X <- C]).

alphabetical_value_for_char(C) ->
    if
        C == "A" -> 1;
        C == "B" -> 2;
        C == "C" -> 3;
        C == "D" -> 4;
        C == "E" -> 5;
        C == "F" -> 6;
        C == "G" -> 7;
        C == "H" -> 8;
        C == "I" -> 9;
        C == "J" -> 10;
        C == "K" -> 11;
        C == "L" -> 12;
        C == "M" -> 13;
        C == "N" -> 14;
        C == "O" -> 15;
        C == "P" -> 16;
        C == "Q" -> 17;
        C == "R" -> 18;
        C == "S" -> 19;
        C == "T" -> 20;
        C == "U" -> 21;
        C == "V" -> 22;
        C == "W" -> 23;
        C == "X" -> 24;
        C == "Y" -> 25;
        C == "Z" -> 26;
        true -> 0
    end.