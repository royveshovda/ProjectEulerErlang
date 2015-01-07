-module (p054).
-export ([solve/0]).

solve() ->
    Filename = "data/p054_poker.txt",
    Lines = into_list(Filename),
    %Lines.
    Hands = lists:map(fun(L) -> parse_line(L) end, Lines),
    Winners = lists:map(fun({H1,H2}) -> get_winner(H1,H2) end, Hands),
    length(lists:filter(fun(W) -> W == hand1 end, Winners)).
    
into_list( File ) ->
        {ok, IO} = file:open( File, [read] ),
        into_list( io:get_line(IO, ''), IO, [] ).
 
 
into_list( eof, _IO, Acc ) -> lists:reverse( Acc );
into_list( {error, _Error}, _IO, Acc ) -> lists:reverse( Acc );
into_list( Line, IO, Acc ) -> into_list( io:get_line(IO, ''), IO, [Line | Acc] ).
    

parse_line(Line) ->
    Raw = string:strip(Line,right,$\n),
    Cards = string:tokens(Raw, " "),
    All = lists:map(fun(X) -> parse_card(X) end, Cards),
    H1 = lists:sublist(All,5),
    H2 = lists:sublist(All, 6,5),
    {H1,H2}.

parse_card([Value,Suit]) ->
    {parse_value(Value), parse_suit(Suit)}.

parse_value(V) ->
    case V of
        $2 -> 2;
        $3 -> 3;
        $4 -> 4;
        $5 -> 5;
        $6 -> 6;
        $7 -> 7;
        $8 -> 8;
        $9 -> 9;
        $T -> 10;
        $J -> 11;
        $Q -> 12;
        $K -> 13;
        $A -> 14
    end.

parse_suit(S) ->
    case S of
        $C -> clubs;
        $S -> spades;
        $D -> diamonds;
        $H -> hearts
    end.    

get_winner(H1, H2) ->
    R1 = rank_hand(lists:reverse(lists:sort(H1))),
    R2 = rank_hand(lists:reverse(lists:sort(H2))),
    %io:format("H1: ~p~n", [R1]),
    %io:format("H2: ~p~n", [R2]),
    get_winner_sorted(R1,R2).

get_winner_sorted({R1,_,_}, {R2,_,_}) when R1 > R2 -> hand1;
get_winner_sorted({R1,_,_}, {R2,_,_}) when R1 < R2 -> hand2;
get_winner_sorted({R1,RC1,NRC1}, {R2,RC2,NRC2}) when R1 == R2 ->
    get_winner_same_rank({RC1, NRC1}, {RC2, NRC2}).

get_winner_same_rank({[],[]}, {[],[]}) -> draw; %% Draw
get_winner_same_rank({[{V1,_}|_], _} , {[{V2,_}|_], _}) when V1 > V2 -> hand1;
get_winner_same_rank({[{V1,_}|_], _} , {[{V2,_}|_], _}) when V1 < V2 -> hand2;
get_winner_same_rank({[{V1,_}|RCs1], NRC1} , {[{V2,_}|RCs2], NRC2}) when V1 == V2 ->
    get_winner_same_rank({RCs1, NRC1} , {RCs2, NRC2});
get_winner_same_rank({[], [{V1,_}|_]} , {[], [{V2,_}|_]}) when V1 > V2 -> hand1;
get_winner_same_rank({[], [{V1,_}|_]} , {[], [{V2,_}|_]}) when V1 < V2 -> hand2;
get_winner_same_rank({[], [{V1,_}|NRCs1]} , {[], [{V2,_}|NCRs2]}) when V1 == V2 ->
    get_winner_same_rank({[], NRCs1} , {[], NCRs2}).

% Royal Flush: Rank = 10
rank_hand([{_,S1} = C1, {_,S2}= C2, {_,S3} = C3, {_,S4} = C4, {_,S5} = C5])
            when
                (S1 == S2)
                andalso (S1 == S3)
                andalso (S1 == S4)
                andalso (S1 == S5) ->
    Ranked = [C1, C2, C3, C4, C5],
    Not = [],
    {10, Ranked, Not};

% Straight Flush: Rank = 9
rank_hand([{V1, S1} = C1, {V2, S2}= C2, {V3, S3} = C3, {V4, S4} = C4, {V5, S5} = C5])
            when
                (S1 == S2)
                andalso (S1 == S3)
                andalso (S1 == S4)
                andalso (S1 == S5)
                andalso (V1 == (V2+1))
                andalso (V2 == (V3+1))
                andalso (V3 == (V4+1))
                andalso (V4 == (V5+1)) ->
    Ranked = [C1, C2, C3, C4, C5],
    Not = [],
    {9, Ranked, Not};

% Four of a kind: Rank = 8
rank_hand([{V1,_} = C1, {V2,_}= C2, {V3,_} = C3, {V4,_} = C4, C5])
            when ((V1 == V2) and (V1 == V3) and (V1 == V4)) ->
    Ranked = [C1, C2, C3, C4],
    Not = [C5],
    {8, Ranked, Not};

% Four of a kind: Rank = 8
rank_hand([C1, {V2,_}= C2, {V3,_} = C3, {V4,_} = C4, {V5,_} = C5])
            when ((V2 == V3) and (V2 == V4) and (V2 == V5)) ->
    Ranked = [C2, C3, C4, C5],
    Not = [C1],
    {8, Ranked, Not};

% Full house: Rank = 7
rank_hand([{V1,_} = C1, {V2,_}= C2, {V3,_} = C3, {V4,_} = C4, {V5,_} = C5])
            when ((V1 == V2) and (V1 == V3) and (V4 == V5)) ->
    Ranked = [C1, C2, C3, C4, C5],
    Not = [],
    {7, Ranked, Not};

% Full house: Rank = 7
rank_hand([{V1,_} = C1, {V2,_}= C2, {V3,_} = C3, {V4,_} = C4, {V5,_} = C5])
            when ((V1 == V2) and (V3 == V4) and (V3 == V5)) ->
    Ranked = [C3, C4, C5, C1, C2], % Order very important
    Not = [],
    {7, Ranked, Not};

% Flush: Rank = 6
rank_hand([{_,S1} = C1, {_,S2}= C2, {_,S3} = C3, {_,S4} = C4, {_,S5} = C5])
            when (S1 == S2) andalso (S1 == S3) andalso (S1 == S4) andalso (S1 == S5) ->
    Ranked = [C1, C2, C3, C4, C5],
    Not = [],
    {6, Ranked, Not};

% Straight: Rank = 5
rank_hand([{V1,_} = C1, {V2,_}= C2, {V3,_} = C3, {V4,_} = C4, {V5,_} = C5])
            when
                (V1 == (V2 + 1)) and
                (V2 == (V3 + 1)) and
                (V3 == (V4 + 1)) and
                (V4 == (V5 + 1)) ->
    Ranked = [C1, C2, C3, C4, C5],
    Not = [],
    {5, Ranked, Not};

% Three of a kind: Rank = 4
rank_hand([{V1,_} = C1, {V2,_}= C2, {V3,_} = C3, C4, C5])
            when ((V1 == V2) and (V1 == V3)) ->
    Ranked = [C1, C2, C3],
    Not = [C4, C5],
    {4, Ranked, Not};

% Three of a kind: Rank = 4
rank_hand([C1, {V2,_}= C2, {V3,_} = C3, {V4,_} = C4, C5])
            when ((V2 == V3) and (V2 == V4)) ->
    Ranked = [C2, C3, C4],
    Not = [C1, C5],
    {4, Ranked, Not};

% Three of a kind: Rank = 4
rank_hand([C1, C2, {V3,_} = C3, {V4,_} = C4, {V5,_} = C5])
            when ((V3 == V4) and (V3 == V5)) ->
    Ranked = [C3, C4, C5],
    Not = [C1, C2],
    {4, Ranked, Not};

% Two pairs: Rank = 3
rank_hand([{V1,_} = C1, {V2,_}= C2, {V3,_} = C3, {V4,_} = C4, C5])
            when ((V1 == V2) and (V3 == V4)) ->
    Ranked = [C1, C2, C3, C4],
    Not = [C5],
    {3, Ranked, Not};

% Two pairs: Rank = 3
rank_hand([{V1,_} = C1, {V2,_}= C2, C3, {V4,_} = C4, {V5,_} = C5])
            when ((V1 == V2) and (V4 == V5)) ->
    Ranked = [C1, C2, C4, C5],
    Not = [C3],
    {3, Ranked, Not};

% Two pairs: Rank = 3
rank_hand([C1, {V2,_}= C2, {V3,_} = C3, {V4,_} = C4, {V5,_} = C5])
            when ((V2 == V3) and (V4 == V5)) ->
    Ranked = [C2, C3, C4, C5],
    Not = [C1],
    {3, Ranked, Not};

% One pair: Rank = 2
rank_hand([{V1,_} = C1, {V2,_}= C2, C3, C4, C5])
            when (V1 == V2) ->
    Ranked = [C1, C2],
    Not = [C3, C4, C5],
    {2, Ranked, Not};

% One pair: Rank = 2
rank_hand([C1, {V2,_}= C2, {V3,_} = C3, C4, C5])
            when (V2 == V3) ->
    Ranked = [C2, C3],
    Not = [C1, C4, C5],
    {2, Ranked, Not};

% One pair: Rank = 2
rank_hand([C1, C2, {V3,_} = C3, {V4,_} = C4, C5])
            when (V3 == V4) ->
    Ranked = [C3, C4],
    Not = [C1, C2, C5],
    {2, Ranked, Not};

% One pair: Rank = 2
rank_hand([C1, C2, C3, {V4,_} = C4, {V5,_} = C5])
            when (V4 == V5) ->
    Ranked = [C4, C5],
    Not = [C1, C2, C3],
    {2, Ranked, Not};

% Nothing: Rank = 1
rank_hand(Hand) ->
    Ranked = [],
    Not = Hand,
    {1, Ranked, Not}.