-module (p062).
-export ([solve/0]).
-import (helper, [to_digits/1]).

solve() ->
    Min = 4642, % 12 digits
    Max = 9999, % 12 digits
    Ns = lists:seq(Min,Max),
    Candidates = lists:map(fun(N) -> {N,lists:sort(to_digits(cube(N)))} end, Ns),
    Counts = lists:map(fun({N, Perm}) -> {N, get_permutations(Perm, Candidates)} end, Candidates),
    Results = lists:filter(fun({_N,C}) -> C == 5 end, Counts),
    {N,_C} = lists:min(Results),
    cube(N).

get_permutations(Perm, Candidates) ->
    Numbers = lists:filter(fun({_,P}) -> P == Perm end, Candidates),
    length(Numbers).
    
cube(N) ->
    N*N*N.