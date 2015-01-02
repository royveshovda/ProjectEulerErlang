-module (p005).
-export ([solve/0]).

%%Correct: 232792560

solve() ->
    seek(19, 19).

seek(N, Add) ->
    B2 = N rem 2 == 0,
    B3 = N rem 3 == 0,
    B4 = N rem 4 == 0,
    B5 = N rem 5 == 0,
    B6 = N rem 6 == 0,
    B7 = N rem 7 == 0,
    B8 = N rem 8 == 0,
    B9 = N rem 9 == 0,
    B10 = N rem 10 == 0,
    B11 = N rem 11 == 0,
    B12 = N rem 12 == 0,
    B13 = N rem 13 == 0,
    B14 = N rem 14 == 0,
    B15 = N rem 15 == 0,
    B16 = N rem 16 == 0,
    B17 = N rem 17 == 0,
    B18 = N rem 18 == 0,
    B19 = N rem 19 == 0,
    B20 = N rem 20 == 0,

    B001 = B2 and B3 and B4 and B5 and B6 and B7 and B8 and B9 and B10,
    B002 = B11 and B12 and B13 and B14 and B15 and B16 and B17 and B18 and B19 and B20,
    B = B001 and B002,
    if
        B == true -> N;
        true -> seek(N+Add, Add)
    end.