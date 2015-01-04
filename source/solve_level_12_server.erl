-module (solve_level_12_server).

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
                276 -> p276:solve();
                277 -> p277:solve();
                278 -> p278:solve();
                279 -> p279:solve();
                280 -> p280:solve();
                281 -> p281:solve();
                282 -> p282:solve();
                283 -> p283:solve();
                284 -> p284:solve();
                285 -> p285:solve();
                286 -> p286:solve();
                287 -> p287:solve();
                288 -> p288:solve();
                289 -> p289:solve();
                290 -> p290:solve();
                291 -> p291:solve();
                292 -> p292:solve();
                293 -> p293:solve();
                294 -> p294:solve();
                295 -> p295:solve();
                296 -> p296:solve();
                297 -> p297:solve();
                298 -> p298:solve();
                299 -> p299:solve();
                300 -> p300:solve();
                _ -> not_available
            end,
    {reply, Result, State}.


handle_cast(stop, State) ->
    {stop, normal, State};

handle_cast(_Msg, State) -> {noreply, State}.
handle_info(_Msg, State) -> {noreply, State}.
terminate(_Reason, _State) -> ok.
code_change(_OldVersion, State, _Extra) -> {ok, State}.