-module (p017).
-export ([solve/0]).

%% Correct: 21124

solve() ->
    Seq = lists:seq(1,1000),
    Sums = [count(convert(X)) || X <- Seq],
    lists:sum(Sums).

count(S) ->
    length(trim(S,[])).

trim([], Acc) ->
    lists:reverse(Acc);
trim([$\ |T], Acc) ->
    trim(T, Acc);
trim([$-|T], Acc) ->
    trim(T, Acc);
trim([H|T], Acc) ->
    trim(T, [H|Acc]).

convert(0) -> "";
convert(1) -> "one";
convert(2) -> "two";
convert(3) -> "three";
convert(4) -> "four";
convert(5) -> "five";
convert(6) -> "six";
convert(7) -> "seven";
convert(8) -> "eight";
convert(9) -> "nine";
convert(10) -> "ten";
convert(11) -> "eleven";
convert(12) -> "tvelve";
convert(13) -> "thirteen";
convert(14) -> "forteen";
convert(15) -> "fifteen";
convert(16) -> "sixteen";
convert(17) -> "seventeen";
convert(18) -> "eightteen";
convert(19) -> "nineteen";
convert(20) -> "twenty";
convert(N) when (N >= 20) and (N < 30) ->
    "twenty-" ++ convert(N rem 20);
convert(N) when (N >= 30) and (N < 40) ->
    "thirty-" ++ convert(N rem 30);
convert(N) when (N >= 40) and (N < 50) ->
    "forty-" ++ convert(N rem 40);
convert(N) when (N >= 50) and (N < 60) ->
    "fifty-" ++ convert(N rem 50);
convert(N) when (N >= 60) and (N < 70) ->
    "sixty-" ++ convert(N rem 60);
convert(N) when (N >= 70) and (N < 80) ->
    "seventy-" ++ convert(N rem 70);
convert(N) when (N >= 80) and (N < 90) ->
    "eighty-" ++ convert(N rem 80);
convert(N) when (N >= 90) and (N < 100) ->
    "ninety-" ++ convert(N rem 90);
convert(100) ->
    "one hundred";
convert(N) when (N > 100) and (N < 200) ->
    "one hundred and " ++ convert(N rem 100);
convert(200) ->
    "two hundred";
convert(N) when (N > 200) and (N < 300) ->
    "two hundred and " ++ convert(N rem 200);
convert(300) ->
    "three hundred";
convert(N) when (N > 300) and (N < 400) ->
    "three hundred and " ++ convert(N rem 300);
convert(400) ->
    "four hundred";
convert(N) when (N > 400) and (N < 500) ->
    "four hundred and " ++ convert(N rem 400);
convert(500) ->
    "five hundred";
convert(N) when (N > 500) and (N < 600) ->
    "five hundred and " ++ convert(N rem 500);
convert(600) ->
    "six hundred";
convert(N) when (N > 600) and (N < 700) ->
    "six hundred and " ++ convert(N rem 600);
convert(700) ->
    "seven hundred";
convert(N) when (N > 700) and (N < 800) ->
    "seven hundred and " ++ convert(N rem 700);
convert(800) ->
    "eight hundred";
convert(N) when (N > 800) and (N < 900) ->
    "eight hundred and " ++ convert(N rem 800);
convert(900) ->
    "nine hundred";
convert(N) when (N > 900) and (N < 1000) ->
    "nine hundred and " ++ convert(N rem 900);
convert(1000) ->
    "one thousand".

