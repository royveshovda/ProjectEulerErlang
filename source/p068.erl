-module (p068).
-export ([solve/0]).
-import (helper, [permute/1]).

%% Inspired from https://github.com/jzellner/eulererlang/blob/master/euler68.erl

solve() ->
	PotentialSolutions =
	[[{A,B,C},{D,C,E},{F,E,G},{H,G,I},{J,I,B}] ||
	[A,B,C,D,E,F,G,H,I,J] <- permute(lists:seq(1,10)),
	A + B + C =:= D + C + E,
	A + B + C =:= F + E + G,
	A + B + C =:= H + G + I,
	A + B + C =:= J + I + B,
	%% must be 'named' from lowest number clockwise
	A =< D, A =< F, A =< H, A =< J,
	%% 16 digits means 10 can't be an inner number
	(A =:= 10) or (D =:= 10) or (F =:= 10) or (H =:= 10) or (J =:= 10)
	],
	[Answer|_] = lists:reverse(PotentialSolutions),
	L = lists:foldl(fun({A,B,C}, Acc) ->
				Acc ++ [io_lib:format("~p",[A]) ++ io_lib:format("~p",[B])++io_lib:format("~p",[C])] end, [], Answer),
	L2 = lists:flatten(L),
	list_to_integer(L2).