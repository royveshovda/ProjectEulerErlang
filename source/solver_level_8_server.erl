-module (solver_level_8_server).

-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).
-export([start_link/0, stop/0,
        solve/1]).

start_link() -> gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

init([]) -> {ok, {}}.

stop() -> gen_server:cast(?MODULE, stop).

solve(N) -> gen_server:call(?MODULE, {solve, N}, 500000).

handle_call({solve, N}, _From, State) ->
    Result = case N of
                176 -> p176:solve();
                177 -> p177:solve();
                178 -> p178:solve();
                179 -> p179:solve();
                180 -> p180:solve();
                181 -> p181:solve();
                182 -> p182:solve();
                183 -> p183:solve();
                184 -> p184:solve();
                185 -> p185:solve();
                186 -> p186:solve();
                187 -> p187:solve();
                188 -> p188:solve();
                189 -> p189:solve();
                190 -> p190:solve();
                191 -> p191:solve();
                192 -> p192:solve();
                193 -> p193:solve();
                194 -> p194:solve();
                195 -> p195:solve();
                196 -> p196:solve();
                197 -> p197:solve();
                198 -> p198:solve();
                199 -> p199:solve();
                200 -> p200:solve();
                _ -> not_available
            end,
    {reply, Result, State}.


handle_cast(stop, State) ->
    {stop, normal, State};

handle_cast(_Msg, State) -> {noreply, State}.
handle_info(_Msg, State) -> {noreply, State}.
terminate(_Reason, _State) -> ok.
code_change(_OldVersion, State, _Extra) -> {ok, State}.