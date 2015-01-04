-module (solve_level_6_server).

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
                126 -> p126:solve();
                127 -> p127:solve();
                128 -> p128:solve();
                129 -> p129:solve();
                130 -> p130:solve();
                131 -> p131:solve();
                132 -> p132:solve();
                133 -> p133:solve();
                134 -> p134:solve();
                135 -> p135:solve();
                136 -> p136:solve();
                137 -> p137:solve();
                138 -> p138:solve();
                139 -> p139:solve();
                140 -> p140:solve();
                141 -> p141:solve();
                142 -> p142:solve();
                143 -> p143:solve();
                144 -> p144:solve();
                145 -> p145:solve();
                146 -> p146:solve();
                147 -> p147:solve();
                148 -> p148:solve();
                149 -> p149:solve();
                150 -> p150:solve();
                _ -> not_available
            end,
    {reply, Result, State}.


handle_cast(stop, State) ->
    {stop, normal, State};

handle_cast(_Msg, State) -> {noreply, State}.
handle_info(_Msg, State) -> {noreply, State}.
terminate(_Reason, _State) -> ok.
code_change(_OldVersion, State, _Extra) -> {ok, State}.