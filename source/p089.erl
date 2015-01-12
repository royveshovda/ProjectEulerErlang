-module (p089).
-export ([solve/0]).

solve() ->
    Filename = "data/p089_roman.txt",
    Lines = open_file(Filename),
    Parsed = lists:map(fun(L) -> match(L) end, Lines),

    Diff = lists:map(fun({N,L}) -> (L - length(print(N))) end, Parsed),
    lists:sum(Diff).

open_file(Filename) ->
    case file:read_file(Filename) of
        {ok, Binary} ->
            string:tokens(erlang:binary_to_list(Binary), "\r\n");
        {error, _} ->
            "caught error"
    end.

test1() ->
    {1,1} = match("I"),
    {2,2} = match("II"),
    {3,3} = match("III"),
    {4,4} = match("IIII"),
    {5,1} = match("V"),
    {12,12} = match("IIIIIIIIIIII"),
    {4,2} = match("IV"),
    {10,1} = match("X"),
    {9,2} = match("IX"),
    {50,1} = match("L"),
    {40,2} = match("XL"),
    {100,1} = match("C"),
    {90,2} = match("XC"),
    {400,2} = match("CD"),
    {500,1} = match("D"),
    {1000,1} = match("M"),
    {900,2} = match("CM"),

    {49,13} = match("XXXXIIIIIIIII"),
    {49,9} = match("XXXXVIIII"),
    {49,6} = match("XXXXIX"),
    {49,11} = match("XLIIIIIIIII"),
    {49,7} = match("XLVIIII"),
    {49,4} = match("XLIX"),
    ok.

test2() ->
    "I" = print(1),
    "II" = print(2),
    "IV" = print(4),
    "V" = print(5),
    "VI" = print(6),
    "VII" = print(7),
    "VIII" = print(8),
    "IX" = print(9),
    "X" = print(10),
    "XI" = print(11),
    "XXIV" = print(24),
    "XL" = print(40),
    "L" = print(50),
    "XLIX" = print(49),
    
    "XC" = print(90),
    "C" = print(100),
    "CD" = print(400),
    "D" = print(500),
    "CM" = print(900),
    "M" = print(1000),
    "MDCVI" = print(1606),
    4 = length(print(49)),
    ok.

print(N) ->
    print(N,[]).

print(0, S) ->
    S;
print(N, S) when N >= 1000 ->
    print(N-1000, S ++ "M");
print(N, S) when N >= 900 ->
    print(N-900, S ++ "CM");
print(N, S) when N >= 500 ->
    print(N-500, S ++ "D");
print(N, S) when N >= 400 ->
    print(N-400, S ++ "CD");
print(N, S) when N >= 100 ->
    print(N-100, S ++ "C");
print(N, S) when N >= 90 ->
    print(N-90, S ++ "XC");
print(N, S) when N >= 50 ->
    print(N-50, S ++ "L");
print(N, S) when N >= 40 ->
    print(N-40, S ++ "XL");
print(N, S) when N >= 10 ->
    print(N-10, S ++ "X");
print(9, S) ->
    print(0, S ++ "IX");
print(N, S) when N >= 5 ->
    print(N-5, S ++ "V");
print(4, S) ->
    print(0, S ++ "IV");
print(N, S) when N > 0 ->
    print(N-1, S ++ "I").


match(S) ->
    match(S,0,0).

match([], Acc, NumberOfLetters) ->
    {Acc, NumberOfLetters};
match([$C,$M|Rest], Acc, NumberOfLetters) ->
    match(Rest, Acc+900, NumberOfLetters+2);
match([$M|Rest], Acc, NumberOfLetters) ->
    match(Rest, Acc+1000, NumberOfLetters+1);
match([$C,$D|Rest], Acc, NumberOfLetters) ->
    match(Rest, Acc+400, NumberOfLetters+2);
match([$D|Rest], Acc, NumberOfLetters) ->
    match(Rest, Acc+500, NumberOfLetters+1);
match([$X,$C|Rest], Acc, NumberOfLetters) ->
    match(Rest, Acc+90, NumberOfLetters+2);
match([$C|Rest], Acc, NumberOfLetters) ->
    match(Rest, Acc+100, NumberOfLetters+1);
match([$X,$L|Rest], Acc, NumberOfLetters) ->
    match(Rest, Acc+40, NumberOfLetters+2);
match([$L|Rest], Acc, NumberOfLetters) ->
    match(Rest, Acc+50, NumberOfLetters+1);
match([$I,$X|Rest], Acc, NumberOfLetters) ->
    match(Rest, Acc+9, NumberOfLetters+2);
match([$X|Rest], Acc, NumberOfLetters) ->
    match(Rest, Acc+10, NumberOfLetters+1);
match([$I,$V|Rest], Acc, NumberOfLetters) ->
    match(Rest, Acc+4, NumberOfLetters+2);
match([$V|Rest], Acc, NumberOfLetters) ->
    match(Rest, Acc+5, NumberOfLetters+1);
match([$I|Rest], Acc, NumberOfLetters) ->
    match(Rest, Acc+1, NumberOfLetters+1).