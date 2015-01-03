-module (solver_level_15_server).

-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).
-export([start_link/0, stop/0,
        solve/1]).

start_link() -> gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

init([]) -> {ok, {}}.

stop() -> gen_server:cast(?MODULE, stop).

solve(N) -> gen_server:call(?MODULE, {solve, N}, 500000).

handle_call({solve, N}, _From, State) ->
    Result = case N of
                351 -> p351:solve();
                352 -> p352:solve();
                353 -> p353:solve();
                354 -> p354:solve();
                355 -> p355:solve();
                356 -> p356:solve();
                357 -> p357:solve();
                358 -> p358:solve();
                359 -> p359:solve();
                360 -> p360:solve();
                361 -> p361:solve();
                362 -> p362:solve();
                363 -> p363:solve();
                364 -> p364:solve();
                365 -> p365:solve();
                366 -> p366:solve();
                367 -> p367:solve();
                368 -> p368:solve();
                369 -> p369:solve();
                370 -> p370:solve();
                371 -> p371:solve();
                372 -> p372:solve();
                373 -> p373:solve();
                374 -> p374:solve();
                375 -> p375:solve();
                _ -> not_available
            end,
    {reply, Result, State}.


handle_cast(stop, State) ->
    {stop, normal, State};

handle_cast(_Msg, State) -> {noreply, State}.
handle_info(_Msg, State) -> {noreply, State}.
terminate(_Reason, _State) -> ok.
code_change(_OldVersion, State, _Extra) -> {ok, State}.