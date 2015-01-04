-module (solve_level_16_server).

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
                376 -> p376:solve();
                377 -> p377:solve();
                378 -> p378:solve();
                379 -> p379:solve();
                380 -> p380:solve();
                381 -> p381:solve();
                382 -> p382:solve();
                383 -> p383:solve();
                384 -> p384:solve();
                385 -> p385:solve();
                386 -> p386:solve();
                387 -> p387:solve();
                388 -> p388:solve();
                389 -> p389:solve();
                390 -> p390:solve();
                391 -> p391:solve();
                392 -> p392:solve();
                393 -> p393:solve();
                394 -> p394:solve();
                395 -> p395:solve();
                396 -> p396:solve();
                397 -> p397:solve();
                398 -> p398:solve();
                399 -> p399:solve();
                400 -> p400:solve();
                _ -> not_available
            end,
    {reply, Result, State}.


handle_cast(stop, State) ->
    {stop, normal, State};

handle_cast(_Msg, State) -> {noreply, State}.
handle_info(_Msg, State) -> {noreply, State}.
terminate(_Reason, _State) -> ok.
code_change(_OldVersion, State, _Extra) -> {ok, State}.