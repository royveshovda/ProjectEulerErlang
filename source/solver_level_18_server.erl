-module (solver_level_18_server).

-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).
-export([start_link/0, stop/0,
        solve/1]).

start_link() -> gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

init([]) -> {ok, {}}.

stop() -> gen_server:cast(?MODULE, stop).

solve(N) -> gen_server:call(?MODULE, {solve, N}, 500000).

handle_call({solve, N}, _From, State) ->
    Result = case N of
                426 -> p426:solve();
                427 -> p427:solve();
                428 -> p428:solve();
                429 -> p429:solve();
                430 -> p430:solve();
                431 -> p431:solve();
                432 -> p432:solve();
                433 -> p433:solve();
                434 -> p434:solve();
                435 -> p435:solve();
                436 -> p436:solve();
                437 -> p437:solve();
                438 -> p438:solve();
                439 -> p439:solve();
                440 -> p440:solve();
                441 -> p441:solve();
                442 -> p442:solve();
                443 -> p443:solve();
                444 -> p444:solve();
                445 -> p445:solve();
                446 -> p446:solve();
                447 -> p447:solve();
                448 -> p448:solve();
                449 -> p449:solve();
                450 -> p450:solve();
                _ -> not_available
            end,
    {reply, Result, State}.


handle_cast(stop, State) ->
    {stop, normal, State};

handle_cast(_Msg, State) -> {noreply, State}.
handle_info(_Msg, State) -> {noreply, State}.
terminate(_Reason, _State) -> ok.
code_change(_OldVersion, State, _Extra) -> {ok, State}.