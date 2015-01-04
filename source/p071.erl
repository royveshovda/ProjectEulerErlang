-module (p071).
-export ([solve/0]).
-import (my_math, [gcd/2]).

%% NOT WORKING

solve() ->
	L = genlist(),
	erlang:display("Stage 2"),
	find(L).

find([{A,_},{3,7}|_]) -> A;
find(L) -> find(tl(L)).

genlist() ->
	O = lists:seq(1,1000000),
	Raw = [ {N, D} || N <- O, D <- O, N < D, N/D =< 3/7],
	erlang:display("Stage 1"),
	lists:filter(fun({N,D}) -> gcd(N,D) =:= 1 end, Raw).