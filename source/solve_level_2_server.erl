-module (solve_level_2_server).

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
                25 -> p025:solve();
                26 -> p026:solve();
                27 -> p027:solve();
                28 -> p028:solve();
                29 -> p029:solve();
                30 -> p030:solve();
                31 -> p031:solve();
                32 -> p032:solve();
                33 -> p033:solve();
                34 -> p034:solve();
                35 -> p035:solve();
                36 -> p036:solve();
                37 -> p037:solve();
                38 -> p038:solve();
                39 -> p039:solve();
                40 -> p040:solve();
                41 -> p041:solve();
                42 -> p042:solve();
                43 -> p043:solve();
                44 -> p044:solve();
                45 -> p045:solve();
                46 -> p046:solve();
                47 -> p047:solve();
                48 -> p048:solve();
                49 -> p049:solve();
                50 -> p050:solve();
                _ -> not_available
            end,
    {reply, Result, State}.


handle_cast(stop, State) ->
    {stop, normal, State};

handle_cast(_Msg, State) -> {noreply, State}.
handle_info(_Msg, State) -> {noreply, State}.
terminate(_Reason, _State) -> ok.
code_change(_OldVersion, State, _Extra) -> {ok, State}.