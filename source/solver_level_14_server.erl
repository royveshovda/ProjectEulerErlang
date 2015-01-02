-module (solver_level_14_server).

-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).
-export([start_link/0, stop/0,
        solve/1]).

start_link() -> gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

init([]) -> {ok, {}}.

stop() -> gen_server:cast(?MODULE, stop).

solve(N) -> gen_server:call(?MODULE, {solve, N}, 120000).

handle_call({solve, N}, _From, State) ->
    Result = case N of
                326 -> p326:solve();
                327 -> p327:solve();
                328 -> p328:solve();
                329 -> p329:solve();
                330 -> p330:solve();
                331 -> p331:solve();
                332 -> p332:solve();
                333 -> p333:solve();
                334 -> p334:solve();
                335 -> p335:solve();
                336 -> p336:solve();
                337 -> p337:solve();
                338 -> p338:solve();
                339 -> p339:solve();
                340 -> p340:solve();
                341 -> p341:solve();
                342 -> p342:solve();
                343 -> p343:solve();
                344 -> p344:solve();
                345 -> p345:solve();
                346 -> p346:solve();
                347 -> p347:solve();
                348 -> p348:solve();
                349 -> p349:solve();
                350 -> p350:solve();
                _ -> not_available
            end,
    {reply, Result, State}.


handle_cast(stop, State) ->
    {stop, normal, State};

handle_cast(_Msg, State) -> {noreply, State}.
handle_info(_Msg, State) -> {noreply, State}.
terminate(_Reason, _State) -> ok.
code_change(_OldVersion, State, _Extra) -> {ok, State}.