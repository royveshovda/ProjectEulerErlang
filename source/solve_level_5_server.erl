-module (solve_level_5_server).

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
                101 -> p101:solve();
                102 -> p102:solve();
                103 -> p103:solve();
                104 -> p104:solve();
                105 -> p105:solve();
                106 -> p106:solve();
                107 -> p107:solve();
                108 -> p108:solve();
                109 -> p109:solve();
                110 -> p110:solve();
                111 -> p111:solve();
                112 -> p112:solve();
                113 -> p113:solve();
                114 -> p114:solve();
                115 -> p115:solve();
                116 -> p116:solve();
                117 -> p117:solve();
                118 -> p118:solve();
                119 -> p119:solve();
                120 -> p120:solve();
                121 -> p121:solve();
                122 -> p122:solve();
                123 -> p123:solve();
                124 -> p124:solve();
                125 -> p125:solve();
                _ -> not_available
            end,
    {reply, Result, State}.


handle_cast(stop, State) ->
    {stop, normal, State};

handle_cast(_Msg, State) -> {noreply, State}.
handle_info(_Msg, State) -> {noreply, State}.
terminate(_Reason, _State) -> ok.
code_change(_OldVersion, State, _Extra) -> {ok, State}.