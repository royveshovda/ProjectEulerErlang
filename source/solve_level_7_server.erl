-module (solve_level_7_server).

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
                151 -> p151:solve();
                152 -> p152:solve();
                153 -> p153:solve();
                154 -> p154:solve();
                155 -> p155:solve();
                156 -> p156:solve();
                157 -> p157:solve();
                158 -> p158:solve();
                159 -> p159:solve();
                160 -> p160:solve();
                161 -> p161:solve();
                162 -> p162:solve();
                163 -> p163:solve();
                164 -> p164:solve();
                165 -> p165:solve();
                166 -> p166:solve();
                167 -> p167:solve();
                168 -> p168:solve();
                169 -> p169:solve();
                170 -> p170:solve();
                171 -> p171:solve();
                172 -> p172:solve();
                173 -> p173:solve();
                174 -> p174:solve();
                175 -> p175:solve();
                _ -> not_available
            end,
    {reply, Result, State}.


handle_cast(stop, State) ->
    {stop, normal, State};

handle_cast(_Msg, State) -> {noreply, State}.
handle_info(_Msg, State) -> {noreply, State}.
terminate(_Reason, _State) -> ok.
code_change(_OldVersion, State, _Extra) -> {ok, State}.