-module (p033).
-export ([solve/0]).
-import (helper, [to_digits/1]).

solve() ->
    Candidates = get_candidates(),
    Results_raw = lists:filter(fun(X) -> check(X) end, Candidates),
    Results = lists:map(fun(X) -> decorate(X) end, Results_raw),
    {A,B} = lists:foldl(fun({A,B}, {As,Bs}) -> {As*A,Bs*B} end, {1,1}, Results),
    trunc(B/A).

decorate({_A,[A1,A2],_B,[B1,B2]}) ->
    if
        A1 == B1 -> {A2, B2};
        A1 == B2 -> {A2, B1};
        A2 == B1 -> {A1, B2};
        A2 == B2 -> {A1, B1};
        true -> {0,0}
    end.

check({A,[A1,A2],B,[B1,B2]}) ->
    V = A/B,
    M1 = case A1 == B1 of
            true -> V == A2/B2;
            false -> false
        end,
    M2 = case A1 == B2 of
            true -> V == A2/B1;
            false -> false
        end,
    M3 = case A2 == B1 of
            true -> V == A1/B2;
            false -> false
        end,
    M4 = case A2 == B2 of
            true -> V == A1/B1;
            false -> false
        end,
    M1 or M2 or M3 or M4.

get_candidates() ->
    Ns = lists:filter(fun(A) -> A rem 10 /= 0 end, lists:seq(11,99)),
    Candidates = [{A,B} || A <- Ns, B <- Ns, A < B],
    Expanded = lists:map(fun({A,B}) -> {A,to_digits(A),B,to_digits(B)} end, Candidates),
    lists:filter(fun(X) -> has_same_digits(X) end, Expanded).

has_same_digits({_,[A1,A2],_,[B1,B2]}) ->
    (A1 == B1) or (A1 == B2) or (A2 == B1) or (A2 == B2).