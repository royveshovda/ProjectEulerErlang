-module (solve_level_20_server).

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
                476 -> p476:solve();
                477 -> p477:solve();
                478 -> p478:solve();
                479 -> p479:solve();
                480 -> p480:solve();
                481 -> p481:solve();
                482 -> p482:solve();
                483 -> p483:solve();
                484 -> p484:solve();
                485 -> p485:solve();
                486 -> p486:solve();
                487 -> p487:solve();
                488 -> p488:solve();
                489 -> p489:solve();
                490 -> p490:solve();
                491 -> p491:solve();
                492 -> p492:solve();
                493 -> p493:solve();
                494 -> p494:solve();
                495 -> p495:solve();
                496 -> p496:solve();
                497 -> p497:solve();
                498 -> p498:solve();
                499 -> p499:solve();
                500 -> p500:solve();
                _ -> not_available
            end,
    {reply, Result, State}.


handle_cast(stop, State) ->
    {stop, normal, State};

handle_cast(_Msg, State) -> {noreply, State}.
handle_info(_Msg, State) -> {noreply, State}.
terminate(_Reason, _State) -> ok.
code_change(_OldVersion, State, _Extra) -> {ok, State}.