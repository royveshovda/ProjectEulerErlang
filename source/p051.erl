-module (p051).
-export ([solve/0]).
-import (helper, [to_digits/1, assemble_number/1]).

solve() ->
    prime_server:start_link(),
    L1 = lists:seq(11,999,2),
    List = lists:filter(fun(N) -> (N rem 5 /= 0) end, L1),
    Candidates = lists:map(fun(N) -> get_candidates(N) end, List),
    [[Result]] = lists:filter(fun(L) -> length(L) > 0 end, Candidates),
    lists:min(Result).

get_candidates(N) when N =< 100 ->
    Ds = to_digits(N),
    C1 = get_p1_below_100(Ds),
    C2 = get_p2_below_100(Ds),
    C3 = get_p3_below_100(Ds),
    C4 = get_p4_below_100(Ds),
    Candidates = [C1,C2,C3,C4],
    Expanded = lists:map(fun(Cs) -> check_candidates(Cs) end, Candidates),
    lists:filter(fun(L) -> length(L) > 0 end,Expanded);
get_candidates(N) when N > 100 ->
    Ds = to_digits(N),
    C1 = get_p1_above_100(Ds),
    C2 = get_p2_above_100(Ds),
    C3 = get_p3_above_100(Ds),
    C4 = get_p4_above_100(Ds),
    C5 = get_p5_above_100(Ds),
    C6 = get_p6_above_100(Ds),
    C7 = get_p7_above_100(Ds),
    C8 = get_p8_above_100(Ds),
    C9 = get_p9_above_100(Ds),
    C10 = get_p10_above_100(Ds),
    Candidates = [C1,C2,C3,C4,C5,C6,C7,C8,C9,C10],
    Expanded = lists:map(fun(Cs) -> check_candidates(Cs) end, Candidates),
    lists:filter(fun(L) -> length(L) > 0 end,Expanded).

check_candidates(Cs) ->
    Primes = lists:filter(fun(N) -> prime_server:is_prime(N) end, Cs),
    if
        length(Primes) == 8 -> lists:sort(Primes);
        true -> []
    end.

get_p1_below_100([D1,D2]) ->
    Ns = lists:seq(0,9),
    M = lists:map(fun(N) -> [D1,N,N,N,D2] end, Ns),
    lists:map(fun(L) -> assemble_number(L) end, M).

get_p2_below_100([D1,D2]) ->
    Ns = lists:seq(0,9),
    M = lists:map(fun(N) -> [N,D1,N,N,D2] end, Ns),
    List = lists:map(fun(L) -> assemble_number(L) end, M),
    lists:filter(fun(N) -> N > 9999 end, List).

get_p3_below_100([D1,D2]) ->
    Ns = lists:seq(0,9),
    M = lists:map(fun(N) -> [N,N,D1,N,D2] end, Ns),
    List = lists:map(fun(L) -> assemble_number(L) end, M),
    lists:filter(fun(N) -> N > 9999 end, List).

get_p4_below_100([D1,D2]) ->
    Ns = lists:seq(0,9),
    M = lists:map(fun(N) -> [N,N,N,D1,D2] end, Ns),
    List = lists:map(fun(L) -> assemble_number(L) end, M),
    lists:filter(fun(N) -> N > 9999 end, List).


get_p1_above_100([D1,D2,D3]) ->
    Ns = lists:seq(0,9),
    M = lists:map(fun(N) -> [D1,D2,N,N,N,D3] end, Ns),
    lists:map(fun(L) -> assemble_number(L) end, M).

get_p2_above_100([D1,D2,D3]) ->
    Ns = lists:seq(0,9),
    M = lists:map(fun(N) -> [D1,N,D2,N,N,D3] end, Ns),
    lists:map(fun(L) -> assemble_number(L) end, M).

get_p3_above_100([D1,D2,D3]) ->
    Ns = lists:seq(0,9),
    M = lists:map(fun(N) -> [D1,N,N,D2,N,D3] end, Ns),
    lists:map(fun(L) -> assemble_number(L) end, M).

get_p4_above_100([D1,D2,D3]) ->
    Ns = lists:seq(0,9),
    M = lists:map(fun(N) -> [D1,N,N,N,D2,D3] end, Ns),
    lists:map(fun(L) -> assemble_number(L) end, M).

get_p5_above_100([D1,D2,D3]) ->
    Ns = lists:seq(0,9),
    M = lists:map(fun(N) -> [N,D1,D2,N,N,D3] end, Ns),
    List = lists:map(fun(L) -> assemble_number(L) end, M),
    lists:filter(fun(N) -> N > 99999 end, List).

get_p6_above_100([D1,D2,D3]) ->
    Ns = lists:seq(0,9),
    M = lists:map(fun(N) -> [N,D1,N,D2,N,D3] end, Ns),
    List = lists:map(fun(L) -> assemble_number(L) end, M),
    lists:filter(fun(N) -> N > 99999 end, List).

get_p7_above_100([D1,D2,D3]) ->
    Ns = lists:seq(0,9),
    M = lists:map(fun(N) -> [N,D1,N,N,D2,D3] end, Ns),
    List = lists:map(fun(L) -> assemble_number(L) end, M),
    lists:filter(fun(N) -> N > 99999 end, List).

get_p8_above_100([D1,D2,D3]) ->
    Ns = lists:seq(0,9),
    M = lists:map(fun(N) -> [N,N,D1,D2,N,D3] end, Ns),
    List = lists:map(fun(L) -> assemble_number(L) end, M),
    lists:filter(fun(N) -> N > 99999 end, List).

get_p9_above_100([D1,D2,D3]) ->
    Ns = lists:seq(0,9),
    M = lists:map(fun(N) -> [N,N,D1,N,D2,D3] end, Ns),
    List = lists:map(fun(L) -> assemble_number(L) end, M),
    lists:filter(fun(N) -> N > 99999 end, List).

get_p10_above_100([D1,D2,D3]) ->
    Ns = lists:seq(0,9),
    M = lists:map(fun(N) -> [N,N,N,D1,D2,D3] end, Ns),
    List = lists:map(fun(L) -> assemble_number(L) end, M),
    lists:filter(fun(N) -> N > 99999 end, List).
