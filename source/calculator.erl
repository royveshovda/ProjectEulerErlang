-module (calculator).
-export ([pow/2, to_digits/1, factorial/1, assemble_number/1, permute/1, alphabetical_value/1]).

pow(X, N) when is_integer(N), N >= 0 -> pow(X, N, 1);
pow(X, N) when is_integer(N) -> 1 / pow(X, -N, 1);
pow(X, N) when is_float(N) -> math:pow(X, N).

pow(_, 0, P) -> P;
pow(X, N, A) when N rem 2 =:= 0 ->
    pow(X * X, N div 2, A);
pow(X, N, A) -> pow(X, N - 1, A * X).

to_digits(N) ->
    to_digits(N, []).
to_digits(0, Acc) ->
    Acc;
to_digits(N, Acc) ->
    to_digits(N div 10, [N rem 10|Acc]).

factorial(1) ->
    1;
factorial(N) ->
    N* factorial(N-1).

permute([]) -> [[]];
permute(L) -> [[X|Y] || X<-L, Y<-permute(L--[X])].

assemble_number(L) ->
    assemble_number(L,length(L)-1,0).

assemble_number([], _, Acc) ->
    Acc;
assemble_number([H|T],Multiplier, Acc) ->
    New_acc = Acc + (H * pow(10,Multiplier)),
    assemble_number(T, Multiplier-1, New_acc).

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