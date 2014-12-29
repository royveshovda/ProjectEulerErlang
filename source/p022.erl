-module (p022).
-export ([run/0]).

run() ->
    {ok, Device} = file:open("../Problems/p022_names.txt", [read]),
    Raw = file:read_line(Device),
    file:close(Device),
    Tokens = string:tokens(Raw,","),
    [string:trim(X, both, "\"") || X <- Tokens].
    %TODO: Read file
    %TODO: Sort names from file
    %TODO: Rank names
    %TODO: Sum all
    %alphabetical_value("COLIN").

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