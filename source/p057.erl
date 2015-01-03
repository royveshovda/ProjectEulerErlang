-module (p057).
-export ([solve/0]).

%% Borrowed from https://github.com/jamesaimonetti/ProjectEuler
%%Link: https://projecteuler.net/problem=57
%% Correct: ??

solve() ->
    {_, _, C} = lists:foldl(fun(_, {N, D, C}) ->
                                {N1, D1} = next(N, D),
                                    case len(N1+D1) > len(D1) of
                                        true -> {N1, D1, C+1};
                                        false -> {N1, D1, C}
                                    end
                                end,
    {1, 2, 0}, lists:seq(1,1000)),
    C.

next(N, D) -> {D, D*2 + N}.

len(N) -> length(integer_to_list(N)).