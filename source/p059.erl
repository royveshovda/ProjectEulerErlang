-module (p059).
-export ([solve/0]).

%% Inspired from https://github.com/jamesaimonetti/ProjectEuler

solve() ->
    {ok, Binary} = file:read_file("data/p059_cipher.txt"),
    Digits = [ list_to_integer(N) || N <- string:tokens(binary_to_list(Binary), ",\r\n") ],

    Keys_applied = lists:map(fun(Key) -> msg(Digits, Key) end, gen_keys(length(Digits))),
    Candidates = lists:filter(fun(Msg) -> is_msg(Msg) end, Keys_applied),
    Result = lists:map(fun(Msg) -> {sum, lists:sum(Msg), msg, Msg} end, Candidates),
    [{sum, S,msg, _Msg}] = Result,
    S.

msg(Digits, Key) -> lists:zipwith(fun(D, K) -> D bxor K end, Digits, Key).

is_msg(Msg) ->
    C1 = lists:all(fun(M) -> M > 31 andalso M < 123 end, Msg),
    C2 = lists:all(fun(M) -> M /= 35 andalso M /= 47 end, Msg), % 35 = #  -- 47 = / --
    C1 and C2.

repeat(Xs, N) -> repeat(Xs, N, []).

repeat(_, 0, L) -> lists:reverse(L);
repeat([X|Xs], N, L) ->
    repeat(lists:flatten([Xs, [X]]), N-1, [X | L]).

gen_keys(Len) ->
    Range = lists:seq($a, $z),
    [ repeat([A, B, C], Len) || A <- Range, B <- Range, C <- Range].