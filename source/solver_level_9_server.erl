-module (solver_level_9_server).

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
                201 -> p201:solve();
                202 -> p202:solve();
                203 -> p203:solve();
                204 -> p204:solve();
                205 -> p205:solve();
                206 -> p206:solve();
                207 -> p207:solve();
                208 -> p208:solve();
                209 -> p209:solve();
                210 -> p210:solve();
                211 -> p211:solve();
                212 -> p212:solve();
                213 -> p213:solve();
                214 -> p214:solve();
                215 -> p215:solve();
                216 -> p216:solve();
                217 -> p217:solve();
                218 -> p218:solve();
                219 -> p219:solve();
                220 -> p220:solve();
                221 -> p221:solve();
                222 -> p222:solve();
                223 -> p223:solve();
                224 -> p224:solve();
                225 -> p225:solve();
                _ -> not_available
            end,
    {reply, Result, State}.


handle_cast(stop, State) ->
    {stop, normal, State};

handle_cast(_Msg, State) -> {noreply, State}.
handle_info(_Msg, State) -> {noreply, State}.
terminate(_Reason, _State) -> ok.
code_change(_OldVersion, State, _Extra) -> {ok, State}.