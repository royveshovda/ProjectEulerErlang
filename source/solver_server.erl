-module (solver_server).

-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).
-export([start_link/0, stop/0,
        solve/1, solve_all/0]).

start_link() ->
    solver_level_1_server:start_link(),
    solver_level_2_server:start_link(),
    solver_level_3_server:start_link(),
    solver_level_4_server:start_link(),
    solver_level_5_server:start_link(),
    solver_level_6_server:start_link(),
    solver_level_7_server:start_link(),
    solver_level_8_server:start_link(),
    solver_level_9_server:start_link(),
    solver_level_10_server:start_link(),
    solver_level_11_server:start_link(),
    solver_level_12_server:start_link(),
    solver_level_13_server:start_link(),
    solver_level_14_server:start_link(),
    solver_level_15_server:start_link(),
    solver_level_16_server:start_link(),
    solver_level_17_server:start_link(),
    solver_level_18_server:start_link(),
    solver_level_19_server:start_link(),
    solver_level_20_server:start_link(),
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

init([]) -> {ok, {}}.

stop() ->
    solver_level_1_server:stop(),
    solver_level_2_server:stop(),
    solver_level_3_server:stop(),
    solver_level_4_server:stop(),
    solver_level_5_server:stop(),
    solver_level_6_server:stop(),
    solver_level_7_server:stop(),
    solver_level_8_server:stop(),
    solver_level_9_server:stop(),
    solver_level_10_server:stop(),
    solver_level_11_server:stop(),
    solver_level_12_server:stop(),
    solver_level_13_server:stop(),
    solver_level_14_server:stop(),
    solver_level_15_server:stop(),
    solver_level_16_server:stop(),
    solver_level_17_server:stop(),
    solver_level_18_server:stop(),
    solver_level_19_server:stop(),
    solver_level_20_server:stop(),
    gen_server:cast(?MODULE, stop).

solve(N) -> gen_server:call(?MODULE, {solve, N}, 120000).

solve_all() ->
    start_link(),
    L1 = lists:seq(1,25),
    L2 = lists:seq(1,37) ++ [41,48,49],
    L3 = [67],
    L4 = [97],
    L5 = [],
    L6 = [],
    L7 = [],
    L8 = [],
    L9 = [],
    L10 = [],
    L11 = [],
    L12 = [],
    L13 = [],
    L14 = [],
    L15 = [],
    L16 = [],
    L17 = [],
    L18 = [],
    L19 = [],
    L20 = [],
    
    All = L1 ++ L2 ++ L3 ++ L4 ++ L5 ++ L6 ++ L7 ++ L8 ++ L9 ++ L10 ++
         L11 ++ L12 ++ L13 ++ L14 ++ L15 ++ L16 ++ L17 ++ L18 ++ L19 ++ L20,
    Results = lists:map(fun(X) -> {X,solve(X)} end, All),
    stop(),
    print_results(Results).

print_results([]) -> ok;
print_results([{N, Result}|Rest]) ->
    io:format("Problem ~p : ~p~n",[N,Result]),
    print_results(Rest).


handle_call({solve, N}, _From, State) ->
    Level = get_level(N),
    Result = case Level of
                1 -> solver_level_1_server:solve(N);
                2 -> solver_level_2_server:solve(N);
                3 -> solver_level_3_server:solve(N);
                4 -> solver_level_4_server:solve(N);
                5 -> solver_level_5_server:solve(N);
                6 -> solver_level_6_server:solve(N);
                7 -> solver_level_7_server:solve(N);
                8 -> solver_level_8_server:solve(N);
                9 -> solver_level_9_server:solve(N);
                10 -> solver_level_10_server:solve(N);
                11 -> solver_level_11_server:solve(N);
                12 -> solver_level_12_server:solve(N);
                13 -> solver_level_13_server:solve(N);
                14 -> solver_level_14_server:solve(N);
                15 -> solver_level_15_server:solve(N);
                16 -> solver_level_16_server:solve(N);
                17 -> solver_level_17_server:solve(N);
                18 -> solver_level_18_server:solve(N);
                19 -> solver_level_19_server:solve(N);
                20 -> solver_level_20_server:solve(N);
                _ -> not_available
            end,
    {reply, Result, State}.

get_level(L) ->
    if
        (L >= 1) and (L =< 25) -> 1;
        (L >= 26) and (L =< 50) -> 2;
        (L >= 51) and (L =< 75) -> 3;
        (L >= 76) and (L =< 100) -> 4;
        (L >= 101) and (L =< 125) -> 5;
        (L >= 126) and (L =< 150) -> 6;
        (L >= 151) and (L =< 175) -> 7;
        (L >= 176) and (L =< 200) -> 8;
        (L >= 201) and (L =< 225) -> 9;
        (L >= 226) and (L =< 250) -> 10;
        (L >= 251) and (L =< 275) -> 11;
        (L >= 276) and (L =< 300) -> 12;
        (L >= 301) and (L =< 325) -> 13;
        (L >= 326) and (L =< 350) -> 14;
        (L >= 351) and (L =< 375) -> 15;
        (L >= 376) and (L =< 400) -> 16;
        (L >= 401) and (L =< 425) -> 17;
        (L >= 426) and (L =< 450) -> 18;
        (L >= 451) and (L =< 475) -> 19;
        (L >= 476) and (L =< 500) -> 20;
        true -> 0
    end.

handle_cast(stop, State) ->
    {stop, normal, State};

handle_cast(_Msg, State) -> {noreply, State}.
handle_info(_Msg, State) -> {noreply, State}.
terminate(_Reason, _State) -> ok.
code_change(_OldVersion, State, _Extra) -> {ok, State}.