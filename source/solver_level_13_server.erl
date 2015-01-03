-module (solver_level_13_server).

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
                301 -> p301:solve();
                302 -> p302:solve();
                303 -> p303:solve();
                304 -> p304:solve();
                305 -> p305:solve();
                306 -> p306:solve();
                307 -> p307:solve();
                308 -> p308:solve();
                309 -> p309:solve();
                310 -> p310:solve();
                311 -> p311:solve();
                312 -> p312:solve();
                313 -> p313:solve();
                314 -> p314:solve();
                315 -> p315:solve();
                316 -> p316:solve();
                317 -> p317:solve();
                318 -> p318:solve();
                319 -> p319:solve();
                320 -> p320:solve();
                321 -> p321:solve();
                322 -> p322:solve();
                323 -> p323:solve();
                324 -> p324:solve();
                325 -> p325:solve();
                _ -> not_available
            end,
    {reply, Result, State}.


handle_cast(stop, State) ->
    {stop, normal, State};

handle_cast(_Msg, State) -> {noreply, State}.
handle_info(_Msg, State) -> {noreply, State}.
terminate(_Reason, _State) -> ok.
code_change(_OldVersion, State, _Extra) -> {ok, State}.