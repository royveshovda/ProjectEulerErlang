-module (p048).
-export ([run/0]).
-import (calculator, [pow/2]).
%% Correct: 9110846700

run() ->
    Ns = lists:seq(1,1000),
    Products = lists:map(fun(X) -> pow(X,X) end, Ns),
    Solution = lists:sum(Products),
    Digits = integer_to_list(Solution),
    Length = length(Digits),
    list_to_integer(lists:sublist(Digits, Length-9,10)).