-module (p044).
-export ([solve/0]).

%% Correct: 5482660

solve() ->
    [P|Ps] = get_pentagons(2400),
    find_diff(P, Ps, 1000000000).

find_diff(_, [], Diff) -> Diff;
find_diff(J, Ps, Diff) ->
    Ks = lists:filter(fun(K) -> lists:member(J+K, Ps) andalso lists:member(K-J, Ps) end, Ps),
    Diff1 = lists:foldl(fun(K, D) ->
                            case abs(J-K) < D of
                                true -> abs(J-K);
                                false -> D
                            end
                        end, Diff, Ks),
    find_diff(hd(Ps), tl(Ps), Diff1).

get_pentagons(N) ->
    [get_pentagon(X) || X <- lists:seq(1,N)].

get_pentagon(N) -> 
    N*(3*N-1) div 2.