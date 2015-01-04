-module (solve_level_19_server).

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
                451 -> p451:solve();
                452 -> p452:solve();
                453 -> p453:solve();
                454 -> p454:solve();
                455 -> p455:solve();
                456 -> p456:solve();
                457 -> p457:solve();
                458 -> p458:solve();
                459 -> p459:solve();
                460 -> p460:solve();
                461 -> p461:solve();
                462 -> p462:solve();
                463 -> p463:solve();
                464 -> p464:solve();
                465 -> p465:solve();
                466 -> p466:solve();
                467 -> p467:solve();
                468 -> p468:solve();
                469 -> p469:solve();
                470 -> p470:solve();
                471 -> p471:solve();
                472 -> p472:solve();
                473 -> p473:solve();
                474 -> p474:solve();
                475 -> p475:solve();
                _ -> not_available
            end,
    {reply, Result, State}.


handle_cast(stop, State) ->
    {stop, normal, State};

handle_cast(_Msg, State) -> {noreply, State}.
handle_info(_Msg, State) -> {noreply, State}.
terminate(_Reason, _State) -> ok.
code_change(_OldVersion, State, _Extra) -> {ok, State}.