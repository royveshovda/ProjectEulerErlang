-module (solve_level_1_server).

-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).
-export([start_link/0, stop/0,
        solve/1, solve/2]).

-define(TIMEOUT, 500000).

start_link() -> gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

init([]) -> {ok, {}}.

stop() -> gen_server:cast(?MODULE, stop).

solve(N) -> solve(N, ?TIMEOUT).

solve(N, Timeout) -> gen_server:call(?MODULE, {solve, N}, Timeout).

handle_call({solve, N}, _From, State) ->
    Result = case N of
                1 -> p001:solve();
                2 -> p002:solve();
                3 -> p003:solve();
                4 -> p004:solve();
                5 -> p005:solve();
                6 -> p006:solve();
                7 -> p007:solve();
                8 -> p008:solve();
                9 -> p009:solve();
                10 -> p010:solve();
                11 -> p011:solve();
                12 -> p012:solve();
                13 -> p013:solve();
                14 -> p014:solve();
                15 -> p015:solve();
                16 -> p016:solve();
                17 -> p017:solve();
                18 -> p018:solve();
                19 -> p019:solve();
                20 -> p020:solve();
                21 -> p021:solve();
                22 -> p022:solve();
                23 -> p023:solve();
                24 -> p024:solve();
                25 -> p025:solve();
                _ -> not_available
            end,
    {reply, Result, State}.


handle_cast(stop, State) ->
    {stop, normal, State};

handle_cast(_Msg, State) -> {noreply, State}.
handle_info(_Msg, State) -> {noreply, State}.
terminate(_Reason, _State) -> ok.
code_change(_OldVersion, State, _Extra) -> {ok, State}.