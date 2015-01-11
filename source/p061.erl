-module (p061).
-export ([solve/0]).
-import (helper, [to_digits/1, permute/1]).

solve() ->
    {P3s,P4s,P5s,P6s,P7s,P8s} = generate_numbers(150),
    Ps_permutations = lists:map(fun(Perm) -> [P3s|Perm] end, permute([P4s,P5s,P6s,P7s,P8s])),
    Sequences = lists:map(fun(Step) -> steps(Step) end, Ps_permutations),
    [[Result]] = lists:filter(fun(S) -> length(S) > 0 end, Sequences),
    sum(Result).

sum([{_,P1,_},{_,P2,_},{_,P3,_},{_,P4,_},{_,P5,_},{_,P6,_},_]) ->
    P1+P2+P3+P4+P5+P6.

steps([SA,SB,SC,SD,SE,SF]) ->
    S1 = lists:map(fun(Step) -> [Step] end, SA),
    S2 = next(SB, S1),
    S3 = next(SC, S2),
    S4 = next(SD, S3),
    S5 = next(SE, S4),
    S6 = next(SF, S5),
    S7 = next(SA, S6),
    lists:filter(fun(S) -> verify_steps(S) end, S7).

verify_steps([{_,P1,_},{_,P2,_},{_,P3,_},{_,P4,_},{_,P5,_},{_,P6,_},{_,P7,_}]) ->
    if
        P1 /= P7 -> false;
        P1 == P7 ->
            length(lists:usort([P1,P2,P3,P4,P5,P6])) == 6
    end.

next(Ps, S1) ->
    S2 = lists:foldl(fun(Seq, Acc) -> Acc ++ expand(Ps, Seq) end, [], S1),
    lists:filter(fun(L) -> length(L) > 0 end, S2).

expand(Ps, [P|_Rest] = Sequence) ->
    Next_steps = find_candidates(P, Ps),
    case length(Next_steps) of
        0 -> [];
        _ ->
            lists:map(fun(Step) -> [Step|Sequence] end, Next_steps)
    end.

find_candidates({_,_,[_,_,C1,D1]}, Ps) ->
    lists:filter(fun({_,_,[A2,B2,_,_]}) -> (A2 == C1) and (B2 == D1) end, Ps).

generate_numbers(Max) ->
    Ps = lists:seq(1,Max),
    P3s_raw = lists:map(fun(N) -> {N, calculate_P3(N)} end, Ps),
    P4s_raw = lists:map(fun(N) -> {N, calculate_P4(N)} end, Ps),
    P5s_raw = lists:map(fun(N) -> {N, calculate_P5(N)} end, Ps),
    P6s_raw = lists:map(fun(N) -> {N, calculate_P6(N)} end, Ps),
    P7s_raw = lists:map(fun(N) -> {N, calculate_P7(N)} end, Ps),
    P8s_raw = lists:map(fun(N) -> {N, calculate_P8(N)} end, Ps),
    P3s = add_digits(limit(P3s_raw)),
    P4s = add_digits(limit(P4s_raw)),
    P5s = add_digits(limit(P5s_raw)),
    P6s = add_digits(limit(P6s_raw)),
    P7s = add_digits(limit(P7s_raw)),
    P8s = add_digits(limit(P8s_raw)),
    {P3s,P4s,P5s,P6s,P7s,P8s}.

limit(L) ->
    lists:filter(fun({_N,P}) -> (P > 999) and (P < 10000) end, L).

add_digits(L) ->
    lists:map(fun({N,P}) -> {N,P,to_digits(P)} end, L).

calculate_P3(N) ->
    trunc(N * (N + 1) / 2).

calculate_P4(N) ->
    N * N.

calculate_P5(N) ->
    trunc(N * ((3 * N) - 1) / 2).

calculate_P6(N) ->
    N * ((2 * N) - 1).

calculate_P7(N) ->
    trunc(N * ((5 * N) - 3) / 2).

calculate_P8(N) ->
    N * ((3 * N) - 2).