-module (solver_level_11_server).

-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).
-export([start_link/0, stop/0,
        solve/1]).

start_link() -> gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

init([]) -> {ok, {}}.

stop() -> gen_server:cast(?MODULE, stop).

solve(N) -> gen_server:call(?MODULE, {solve, N}, 120000).

handle_call({solve, N}, _From, State) ->
    Result = case N of
                251 -> p251:solve();
                252 -> p252:solve();
                253 -> p253:solve();
                254 -> p254:solve();
                255 -> p255:solve();
                256 -> p256:solve();
                257 -> p257:solve();
                258 -> p258:solve();
                259 -> p259:solve();
                260 -> p260:solve();
                261 -> p261:solve();
                262 -> p262:solve();
                263 -> p263:solve();
                264 -> p264:solve();
                265 -> p265:solve();
                266 -> p266:solve();
                267 -> p267:solve();
                268 -> p268:solve();
                269 -> p269:solve();
                270 -> p270:solve();
                271 -> p271:solve();
                272 -> p272:solve();
                273 -> p273:solve();
                274 -> p274:solve();
                275 -> p275:solve();
                _ -> not_available
            end,
    {reply, Result, State}.


handle_cast(stop, State) ->
    {stop, normal, State};

handle_cast(_Msg, State) -> {noreply, State}.
handle_info(_Msg, State) -> {noreply, State}.
terminate(_Reason, _State) -> ok.
code_change(_OldVersion, State, _Extra) -> {ok, State}.