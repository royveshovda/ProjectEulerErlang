-module (p038).
-export ([solve/0]).
-import (helper, [to_digits/1, assemble_number/1]).

solve() ->
	Candidates = lists:map(fun(X) -> {X,expand(X)} end, lists:seq(192,9876)),
	Results = lists:filter(fun({_N,Ds}) -> check(Ds) end, Candidates),
	{_N,Ds} = lists:max(Results),
	assemble_number(Ds).

check(Digits) ->
	lists:sort(Digits) == [1,2,3,4,5,6,7,8,9].

expand(N) -> expand(N,1,[]).

expand(_N,_Level,Digits) when length(Digits) >= 9 ->
	Digits;
expand(N,Level,Digits) ->
	Ds = to_digits(Level * N),
	expand(N, Level+1, Digits ++ Ds).