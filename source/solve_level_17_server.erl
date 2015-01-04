-module (solve_level_17_server).

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
                401 -> p401:solve();
                402 -> p402:solve();
                403 -> p403:solve();
                404 -> p404:solve();
                405 -> p405:solve();
                406 -> p406:solve();
                407 -> p407:solve();
                408 -> p408:solve();
                409 -> p409:solve();
                410 -> p410:solve();
                411 -> p411:solve();
                412 -> p412:solve();
                413 -> p413:solve();
                414 -> p414:solve();
                415 -> p415:solve();
                416 -> p416:solve();
                417 -> p417:solve();
                418 -> p418:solve();
                419 -> p419:solve();
                420 -> p420:solve();
                421 -> p421:solve();
                422 -> p422:solve();
                423 -> p423:solve();
                424 -> p424:solve();
                425 -> p425:solve();
                _ -> not_available
            end,
    {reply, Result, State}.


handle_cast(stop, State) ->
    {stop, normal, State};

handle_cast(_Msg, State) -> {noreply, State}.
handle_info(_Msg, State) -> {noreply, State}.
terminate(_Reason, _State) -> ok.
code_change(_OldVersion, State, _Extra) -> {ok, State}.