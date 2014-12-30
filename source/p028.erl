-module (p028).
-export ([run/0]).

%% Correct: 669171001

run() ->
    spiral(1001,0).

%Sum of the Nth corners:
% SN = N**2 + (N**2 - (N - 1)) + (N**2 - 2*(N-1)) + (N**2 - 3*(N-1))
% SN = 4*(N**2) - 6*(N-1)
spiral(1, Acc) -> Acc + 1;
spiral(N, Acc) ->
    spiral(N-2, Acc + sum(N)).

sum(N)->
    4*N*N - 6*N + 6.