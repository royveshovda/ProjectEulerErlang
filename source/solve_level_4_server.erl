-module (solve_level_4_server).

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
                76 -> p076:solve();
                77 -> p077:solve();
                78 -> p078:solve();
                79 -> p079:solve();
                80 -> p080:solve();
                81 -> p081:solve();
                82 -> p082:solve();
                83 -> p083:solve();
                84 -> p084:solve();
                85 -> p085:solve();
                86 -> p086:solve();
                87 -> p087:solve();
                88 -> p088:solve();
                89 -> p089:solve();
                90 -> p090:solve();
                91 -> p091:solve();
                92 -> p092:solve();
                93 -> p093:solve();
                94 -> p094:solve();
                95 -> p095:solve();
                96 -> p096:solve();
                97 -> p097:solve();
                98 -> p098:solve();
                99 -> p099:solve();
                100 -> p100:solve();
                _ -> not_available
            end,
    {reply, Result, State}.


handle_cast(stop, State) ->
    {stop, normal, State};

handle_cast(_Msg, State) -> {noreply, State}.
handle_info(_Msg, State) -> {noreply, State}.
terminate(_Reason, _State) -> ok.
code_change(_OldVersion, State, _Extra) -> {ok, State}.