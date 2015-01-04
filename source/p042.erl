-module (p042).
-export ([solve/0]).
-import (helper, [alphabetical_value/1]).

%%Link: https://projecteuler.net/problem=42
%% Correct: 162

solve() ->
	Filename = "data/p042_words.txt",
	Names = open_file(Filename),
	Values = lists:map(fun(X) -> alphabetical_value(X) end, Names),
	Max = lists:max(Values),
	Ts = get_triangles_below(Max),
	Triangle_words = lists:filter(fun(X) -> lists:member(X,Ts) end, Values),
	length(Triangle_words).

open_file(Filename) ->
    {ok, Device} = file:open(Filename, [read]),
    {ok, Raw} = file:read_line(Device),
    file:close(Device),
    Tokens = string:tokens(Raw,","),
    [string:strip(X, both, $") || X <- Tokens].

get_triangles_below(Max) ->
	get_triangles_below(1,Max,[]).

get_triangles_below(N,Max,Acc) ->
	T = get_triangle(N),
	if
		T>Max -> Acc;
		T=<Max -> get_triangles_below(N+1,Max,[T|Acc])
	end.

get_triangle(N) -> 
	trunc(1/2*N*(N+1)).