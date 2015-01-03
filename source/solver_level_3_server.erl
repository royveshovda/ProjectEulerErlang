-module (solver_level_3_server).

-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).
-export([start_link/0, stop/0,
        solve/1]).

start_link() -> gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

init([]) -> {ok, {}}.

stop() -> gen_server:cast(?MODULE, stop).

solve(N) -> gen_server:call(?MODULE, {solve, N}, 500000).

handle_call({solve, N}, _From, State) ->
    Result = case N of
                51 -> p051:solve();
                52 -> p052:solve();
                53 -> p053:solve();
                54 -> p054:solve();
                55 -> p055:solve();
                56 -> p056:solve();
                57 -> p057:solve();
                58 -> p058:solve();
                59 -> p059:solve();
                60 -> p060:solve();
                61 -> p061:solve();
                62 -> p062:solve();
                63 -> p063:solve();
                64 -> p064:solve();
                65 -> p065:solve();
                66 -> p066:solve();
                67 -> p067:solve();
                68 -> p068:solve();
                69 -> p069:solve();
                70 -> p070:solve();
                71 -> p071:solve();
                72 -> p072:solve();
                73 -> p073:solve();
                74 -> p074:solve();
                75 -> p075:solve();
                _ -> not_available
            end,
    {reply, Result, State}.


handle_cast(stop, State) ->
    {stop, normal, State};

handle_cast(_Msg, State) -> {noreply, State}.
handle_info(_Msg, State) -> {noreply, State}.
terminate(_Reason, _State) -> ok.
code_change(_OldVersion, State, _Extra) -> {ok, State}.