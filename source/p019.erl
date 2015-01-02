-module (p019).
-export ([solve/0]).

%%Link: https://projecteuler.net/problem=19
%% Solution: 171

solve() ->
    check_date(1901,1,0).

check_date(2001,1, Sundays) ->
    Sundays;
check_date(Year, Month, Sundays) when Month == 12 ->
    New_sundays = check_count(Year, Month, Sundays),
    check_date(Year+1, 1, New_sundays);
check_date(Year, Month , Sundays) ->
    New_sundays = check_count(Year, Month, Sundays),
    check_date(Year, Month+1, New_sundays).

check_count(Year, Month, Current) ->
    Day = calendar:day_of_the_week(Year, Month, 1),
    if
        Day == 7 -> Current+1;
        true -> Current
    end.