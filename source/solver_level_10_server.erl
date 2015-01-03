-module (solver_level_10_server).

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
                226 -> p226:solve();
                227 -> p227:solve();
                228 -> p228:solve();
                229 -> p229:solve();
                230 -> p230:solve();
                231 -> p231:solve();
                232 -> p232:solve();
                233 -> p233:solve();
                234 -> p234:solve();
                235 -> p235:solve();
                236 -> p236:solve();
                237 -> p237:solve();
                238 -> p238:solve();
                239 -> p239:solve();
                240 -> p240:solve();
                241 -> p241:solve();
                242 -> p242:solve();
                243 -> p243:solve();
                244 -> p244:solve();
                245 -> p245:solve();
                246 -> p246:solve();
                247 -> p247:solve();
                248 -> p248:solve();
                249 -> p249:solve();
                250 -> p100:solve();
                _ -> not_available
            end,
    {reply, Result, State}.


handle_cast(stop, State) ->
    {stop, normal, State};

handle_cast(_Msg, State) -> {noreply, State}.
handle_info(_Msg, State) -> {noreply, State}.
terminate(_Reason, _State) -> ok.
code_change(_OldVersion, State, _Extra) -> {ok, State}.