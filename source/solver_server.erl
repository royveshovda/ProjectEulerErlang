-module (solver_server).

-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).
-export([start_link/0, stop/0,
        solve/1, solve_with_benchmark/1, solve_all/0, solve_all/1]).

-define(TIMEOUT, 5000000).

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

solve(N) ->
    gen_server:call(?MODULE, {solve, N}, ?TIMEOUT).

solve_with_benchmark(N) ->
    common:benchmark_with_result(fun() -> gen_server:call(?MODULE, {solve, N}, ?TIMEOUT) end).    

get_problems(Type) ->
    Problems = [
        %1-9
        {1,fast},
        {2,fast},
        {3,fast},
        {4,fast},
        {5,medium},
        {6,fast},
        {7,fast},
        {8,fast},
        {9,slow},

        %10-19
        {10,medium},
        {11,fast},
        {12,fast},
        {13,fast},
        {14,slow},
        {15,fast},
        {16,fast},
        {17,fast},
        {18,fast},
        {19,fast},

        %20-29
        {20,fast},
        {21,medium},
        {22,fast},
        {23,medium},
        {24,medium},
        {25,fast},
        {26,fast},
        {27,medium},
        {28,fast},
        {29,fast},

        %30-39
        {30,fast},
        {31,fast},
        {32,fast},
        {33,fast},
        {34,medium},
        {35,medium},
        {36,fast},
        {37,medium},
        {38,fast},
        {39,slow},

        %40-49
        {40,fast},
        {41,medium},
        {42,fast},
        {43,medium},
        {44,medium},
        {45,fast},
        {46,medium},
        {47,slow},
        {48,fast},
        {49,fast},

        %50-59
        {50,medium},
        {51,medium},
        {52,fast},
        {53,fast},
        {54,fast},
        {55,fast},
        {56,fast},
        {57,fast},
        {58,fast},
        {59,medium},

        %60-69
        {60,slow},
        %{61,unknown},
        %{62,unknown},
        {63,fast},
        %{64,unknown},
        %{65,unknown},
        %{66,unknown},
        {67,fast},
        %{68,unknown},
        {69,fast},

        %70-79
        %{70,unknown},
        {71,fast},
        {72,slow},
        {73, medium},
        %{74,unknown},
        %{75,unknown},
        %{76,unknown},
        %{77,unknown},
        %{78,unknown},
        {79,fast},

        %80-89
        %{80,unknown},
        %{81,unknown},
        %{82,unknown},
        %{83,unknown},
        %{84,unknown},
        %{85,unknown},
        %{86,unknown},
        %{87,unknown},
        %{88,unknown},
        %{89,unknown},

        %90-99
        %{90,unknown},
        %{91,unknown},
        %{92,unknown},
        %{93,unknown},
        %{94,unknown},
        %{95,unknown},
        %{96,unknown},
        {97,medium},
        %{98,unknown},
        {99,fast}

    ],
    case Type of
        all -> Problems;
        X -> lists:filter(fun({_,T}) -> T == X end, Problems)
    end.

solve_all(Type) ->
    start_link(),
    Problems = get_problems(Type),
    Results = lists:map(fun({X,_}) -> {X,solve_with_benchmark(X)} end, Problems),
    stop(),
    print_results_with_benchmark(Results).

solve_all() ->
    solve_all(all).

print_results_with_benchmark([]) -> ok;
print_results_with_benchmark([{N, {Result, Runtime}}|Rest]) ->
    io:format("Problem ~p : ~p (~p microseconds)~n",[N,Result,Runtime]),
    print_results_with_benchmark(Rest).

%print_results([]) -> ok;
%print_results([{N, Result}|Rest]) ->
%    io:format("Problem ~p : ~p~n",[N,Result]),
%    print_results(Rest).

handle_call({solve, N}, _From, State) ->
    Level = get_level(N),
    Result = case Level of
                1 -> solver_level_1_server:solve(N, ?TIMEOUT);
                2 -> solver_level_2_server:solve(N, ?TIMEOUT);
                3 -> solver_level_3_server:solve(N, ?TIMEOUT);
                4 -> solver_level_4_server:solve(N, ?TIMEOUT);
                5 -> solver_level_5_server:solve(N, ?TIMEOUT);
                6 -> solver_level_6_server:solve(N, ?TIMEOUT);
                7 -> solver_level_7_server:solve(N, ?TIMEOUT);
                8 -> solver_level_8_server:solve(N, ?TIMEOUT);
                9 -> solver_level_9_server:solve(N, ?TIMEOUT);
                10 -> solver_level_10_server:solve(N, ?TIMEOUT);
                11 -> solver_level_11_server:solve(N, ?TIMEOUT);
                12 -> solver_level_12_server:solve(N, ?TIMEOUT);
                13 -> solver_level_13_server:solve(N, ?TIMEOUT);
                14 -> solver_level_14_server:solve(N, ?TIMEOUT);
                15 -> solver_level_15_server:solve(N, ?TIMEOUT);
                16 -> solver_level_16_server:solve(N, ?TIMEOUT);
                17 -> solver_level_17_server:solve(N, ?TIMEOUT);
                18 -> solver_level_18_server:solve(N, ?TIMEOUT);
                19 -> solver_level_19_server:solve(N, ?TIMEOUT);
                20 -> solver_level_20_server:solve(N, ?TIMEOUT);
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