-module(p092).
-export([solve/0]).
-import(lists,[filter/2,seq/2]).

solve() ->
	L = [ work(X) || X <- seq(2,9999999) ],
	length(filter(fun(X) -> X end, L)).

work(1) ->
	false;
work(89) ->
	true;
work(N) ->
	work(add_squares([ X - 48 || X <- integer_to_list(N) ])).

add_squares([]) ->
	0;
add_squares([H|T]) ->
	(H * H) + add_squares(T).