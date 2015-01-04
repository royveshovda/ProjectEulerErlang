-module (p048).
-export ([solve/0]).
-import (my_math, [pow/2]).

solve() ->
    Ns = lists:seq(1,1000),
    Products = lists:map(fun(X) -> pow(X,X) end, Ns),
    Solution = lists:sum(Products),
    Digits = integer_to_list(Solution),
    Length = length(Digits),
    list_to_integer(lists:sublist(Digits, Length-9,10)).