-module (common).
-export ([benchmark/1]).

%% Usage: common:benchmark(fun() -> pXXX:run() end).
benchmark(F) ->
    statistics(runtime),
    statistics(wall_clock),
    Result = F(),
    {_, Time1} = statistics(runtime),
    {_, Time2} = statistics(wall_clock),
    U1 = Time1 * 1000,
    U2 = Time2 * 1000,
    io:format("Code time=~p (~p) microseconds~n",
    [U1,U2]),
    Result.