-module (p039).
-export ([solve/0]).

%% Correct: 840

solve() ->
	Results = lists:map(fun(X) -> {expand(X),X} end, lists:seq(120,1000)),
	{_,Result} = lists:max(Results),
	Result.

expand(P) ->
	length([{A,B,C} || C <- lists:seq(1, trunc(P/2)),
				B <- lists:seq(1, C-1),
				A <- lists:seq(1, B),
				(A+B+C) == P,
				(C*C =:= (A*A) + (B*B))]).