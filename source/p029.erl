-module (p029).
-export ([run/0]).
-import (calculator, [pow/2]).

%% Correct: 9183

run() ->
    As = lists:seq(2,100),
    Bs = lists:seq(2,100),
    Raw = [pow(A,B) || A <- As, B <- Bs],
    Distinct = lists:usort(Raw),
    length(Distinct).