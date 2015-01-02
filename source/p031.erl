-module (p031).
-export ([solve/0]).

%%Link: https://projecteuler.net/problem=31
%% Correct: 73682

solve() ->
    count(200, coins()).

count(Amount, Coins) ->
    {N,_C} = count(Amount, Coins, dict:new()),
    N.
 
count(0,_,Cache) ->
    {1,Cache};
count(N,_,Cache) when N < 0 ->
    {0,Cache};
count(_N,[],Cache) ->
    {0,Cache};
count(N,[C|Cs]=Coins,Cache) ->
    case dict:is_key({N,length(Coins)},Cache) of
        true -> 
            {dict:fetch({N,length(Coins)},Cache), Cache};
        false ->
            {N1,C1} = count(N-C,Coins,Cache),
            {N2,C2} = count(N,Cs,C1),
            {N1+N2,dict:store({N,length(Coins)},N1+N2,C2)}
    end.

coins() ->
    [1,2,5,10,20,50,100,200].