-module (p014).
-export ([solve/0]).

%%Link: https://projecteuler.net/problem=14
%%Solution: 837799

solve() ->
    I = lists:seq(1,999999),
    Chains = [build_chain(X) || X <- I],
    find_max(Chains, {0,0}).

find_max([], {Max_start, _Max_length})->
    Max_start;
find_max([{Start, Length}|Tail], {_Max_start, Max_length}) when Length > Max_length ->
    find_max(Tail, {Start, Length});
find_max([{_Start, _Length}|Tail], {Max_start, Max_length}) when _Length =< Max_length ->
    find_max(Tail, {Max_start, Max_length}).

build_chain(Start) ->
    build_chain(Start, Start, [Start]).

build_chain(Start, 1, Chain) ->
    {Start, length(Chain)};
build_chain(Start, Number, Chain) when Number rem 2 == 0 ->
    Next = trunc(Number/2),
    build_chain(Start, Next, [Next|Chain]);
build_chain(Start, Number, Chain) when Number rem 2 /= 0 ->
    Next = 3*Number + 1,
    build_chain(Start, Next, [Next|Chain]).

