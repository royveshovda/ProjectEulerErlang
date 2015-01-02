-module (p029).
-export ([solve/0]).
-import (calculator, [pow/2]).

%% Correct: 9183

solve() ->
    As = lists:seq(2,100),
    Bs = lists:seq(2,100),
    Raw = [pow(A,B) || A <- As, B <- Bs],
    Distinct = lists:usort(Raw),
    length(Distinct).