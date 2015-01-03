-module (p099).
-export ([solve/0]).

%% Borrowed from https://github.com/jamesaimonetti/ProjectEuler
%%Link: https://projecteuler.net/problem=99
%% Correct: 709

solve() ->
    {ok, B} = file:read_file("data/p099_base_exp.txt"),
    Lines = string:tokens(binary_to_list(B), [$\r,$\n]),
    BaseExps = lists:map(fun(S) -> string:tokens(S, ",") end, Lines),
    calculate(0, 0, 1, BaseExps).

calculate(_, MaxLineNo, _, []) -> MaxLineNo;
calculate(MaxVal, MaxLineNo, LineNo, [[Base, Exp] | BEs]) ->
    V = list_to_integer(Exp) * math:log(list_to_integer(Base)),
    case V > MaxVal of
        true -> calculate(V, LineNo, LineNo+1, BEs);
        false -> calculate(MaxVal, MaxLineNo, LineNo+1, BEs)
    end.