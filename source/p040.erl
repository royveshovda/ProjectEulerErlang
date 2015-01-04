-module (p040).
-export ([solve/0]).

solve() ->
	N = onenum(),
	t(1,N)*t(10,N)*t(100,N)*t(1000,N)*t(10000,N)*t(100000,N)*t(1000000,N).

onenum() -> lists:flatten(lists:map(fun(X) -> integer_to_list(X) end, lists:seq(1,400000))).
	
t(N,L) -> lists:nth(N,L) - 48.