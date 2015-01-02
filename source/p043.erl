-module (p043).
-export ([solve/0]).
-import (calculator, [assemble_number/1, permute/1]).

%%Link: https://projecteuler.net/problem=43
%% Correct: 16695334890

solve() ->
	Candidates = permute(lists:seq(0,9)),
	Results = lists:filter(fun(X) -> check(X) end, Candidates),
	Numbers = lists:map(fun(Ds) -> assemble_number(Ds) end, Results),
	lists:sum(Numbers).

%% Faster to check the biggest numbers first
check(Digits) ->
	Checks = [{8,17},{7,13},{6,11},{5,7},{4,5},{3,3},{2,2}],
	lists:foldl(fun({Start, Divisor}, Acc) -> check_single(Digits,Start,Divisor,Acc) end,true,Checks).

check_single(_Digits, _Start, _Divisor, false) -> false;
check_single(Digits, Start, Divisor, Acc) ->
	Acc and (assemble_number(lists:sublist(Digits,Start,3)) rem Divisor == 0).