-module (p073).
-export([solve/0]).
-import (my_math, [gcd/2]).

solve() ->
	length(genlist()).

genlist() ->
	O = lists:seq(1,12000),
	[ N / D || N <- O, D <- O, N < D, gcd(N,D) =:= 1, N/D > 1/3, N/D < 1/2 ].