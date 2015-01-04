-module (p079).
-export ([solve/0]).

%% Inspired from https://github.com/jamesaimonetti/ProjectEuler

solve() ->
    {ok, IoDevice} = file:open("data/p079_keylog.txt", [read]),
    String = process(IoDevice, []),
    list_to_integer(String).

process(IoDevice, L) ->
    case file:read_line(IoDevice) of
        {ok, [N1, N2, N3 | _Rest]} ->
            process(IoDevice, update([N1, N2, N3], L));
        eof -> L;
            {error, R} -> io:format("Error reading from file: ~w~n", [R]),
        undefined
    end.

update(L, []) -> L;
update([], L) -> L;
update([H | T], L) ->
    case lists:member(H, L) of
        % split the list so hd(TailL) =:= H
        true -> {HeadL, TailL} = lists:splitwith(fun(N) -> N =/= H end, L),
            update(H, T, HeadL, TailL);
        false -> update(T, lists:reverse([H | L]))
    end.

% h exists as hd(TailL)
update(_H, [], HeadL, TailL) -> update([], lists:flatten([HeadL | TailL]));
update(H, [N | T], HeadL, TailL) ->
    case lists:member(N, HeadL) of
        true -> % if N is in HeadL, and since N comes after H, swap N and H
            update(T, new_list(H, N, HeadL, TailL));
        false -> % if N is not in HeadL, reconstruct the list and evaluate from N
            update([N|T], lists:flatten([HeadL | TailL]))
    end.

%% HeadL = [...B...], TailL = [A...]
new_list(A, B, HeadL, [A | TailL]) ->
    % Left = [...], Right = [B...]
    {Left, Right} = lists:splitwith(fun(N) -> N =/= B end, HeadL),
    lists:flatten([Left, A, tl(Right), B | TailL]).