-module (p026).
-export ([run/0]).

%% Correct: 983

run() ->
    Candidates = lists:seq(1,1000),
    Lengths = lists:map(fun(X) -> cycle_length(X) end, Candidates),
    lists:max(Lengths) +1.
    %cycle_length(6).
    %get_reciprocal(7).

get_reciprocal(N) ->
    Digit = 10 div N,
    Rem = 10 rem N,
    get_reciprocal(Rem, N,[Digit],1).

get_reciprocal(0, _D, Digits,_) ->
    lists:reverse(Digits);
get_reciprocal(_Divisor, _D, Digits,1000) ->
    lists:reverse(Digits);
get_reciprocal(Divisor, D, Digits,Steps) ->
    New = (Divisor*10),
    Digit = New div D,
    Rem = New rem D,
    get_reciprocal(Rem, D, [Digit|Digits], Steps+1).


cycle_length(N)->
    next(10, N, ets:new(lookup, []), 0).

next(0, _, _, _) -> 0;
next(X, D, Tbl, Acc) ->
    Old = ets:lookup(Tbl, {X, D}),
    case Old of
        [] ->
            ets:insert(Tbl, {{X, D}, true}),
            next((X rem D) * 10, D, Tbl, Acc + 1);
        _ -> Acc
    end.