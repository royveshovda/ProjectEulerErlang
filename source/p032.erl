-module (p032).
-export ([run/0]).
-import (calculator, [get_digits/1]).

%% Correct: 45228

run() ->
    As = lists:seq(1, 100),
    Bs = lists:seq(10,4000),
    Cases = [{A,B}|| A <- As, B <- Bs],
    Ordered = lists:filter(fun({A,B}) -> A < B end, Cases),
    Pans = lists:filter(fun({A,B}) -> is_pan_digital_to_9(A,B) end, Ordered),
    lists:sum(lists:usort(lists:map(fun({A,B}) -> A*B end,Pans))).

is_pan_digital_to_9(A,B) ->
    Product = A * B,
    As = get_digits(A),
    Bs = get_digits(B),
    Ps = get_digits(Product),
    Length = length(As) + length(Bs) + length(Ps),
    if
        Length == 9 -> 
            Ds = As ++ Bs ++ Ps,
            lists:usort(Ds) == [1,2,3,4,5,6,7,8,9];
        true -> false
    end.
