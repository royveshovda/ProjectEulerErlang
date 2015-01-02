-module (p053).
-export ([solve/0, solve2/0]).
-import (calculator, [factorial/1]).

%%Link: https://projecteuler.net/problem=53
%% Correct: 4075

solve() ->
    Ns = lists:seq(1,100),
    Candidates = [{N,R} || N <- Ns, R <- Ns, N>=R],
    Values = lists:map(fun({N,R}) -> calculate_combinatoric(N,R) end, Candidates),
    Results = lists:filter(fun(N) -> N >= 1000000 end, Values),
    length(Results).

%% Should be working, and be way faster. Bug a bug give a sum of 4475, which is too high
solve2() ->
    Ns = lists:seq(1,100),
    Results = lists:map(fun(X) -> check_N(X,1) end, Ns),
    lists:sum(Results).
    
check_N(N,N) ->
    V = calculate_combinatoric(N,N),
    case V >= 1000000 of
        true -> 1;
        false -> 0
    end;
check_N(N,R) ->
    V = calculate_combinatoric(N,R),
    case V >= 1000000 of
        true -> N-R+1;
        false -> check_N(N,R+1)
    end.

calculate_combinatoric(N,R) ->
    factorial(N) div (factorial(R) * factorial(N-R)).