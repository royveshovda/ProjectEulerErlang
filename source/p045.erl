-module (p045).
-export ([solve/0]).

%% Correct: 1533776805

solve() ->
    Ts = t_list(286),
    Ps = p_list(166),
    Hs = h_list(144),
    next(Ts, Ps, Hs).

next([A|_Ts], [A|_Ps], [A|_Hs]) -> A;
next([T|Ts], [P|Ps], Hs) when T > P ->
    next([T|Ts], Ps(), Hs);
next([T|Ts], Ps, [H|Hs]) when T > H ->
    next([T|Ts], Ps, Hs());
next([_T|Ts], Ps, Hs) ->
    next(Ts(), Ps, Hs).

t_list(N) -> [N * (N+1) div 2 | fun() -> t_list(N+1) end].

p_list(N) -> [N * (3*N-1) div 2 | fun() -> p_list(N+1) end].

h_list(N) -> [N * (2 * N - 1) | fun() -> h_list(N+1) end].