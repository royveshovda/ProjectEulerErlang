-module (p054).
-export ([solve/0]).

%% Link: https://projecteuler.net/problem=54
%% Correct: ??

solve() ->
    Line = "8C TS KC 9H 4S 7D 2S 5D 3S AC",
    string:tokens(Line, " ").
    %Card = "8C",
    %parse_card(Card).


    %H1 = lists:sort([{5,hearts},{5,clubs}, {6,spades}, {7,spades}, {13,diamonds}]),
    %H2 = lists:sort([{2,clubs},{3,spades}, {8,spades}, {8,diamonds}, {10,diamonds}]),
    %is_hand1_winner(H1, H2).

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


is_hand1_winner(H1,H2) ->
    H1_sorted = lists:sort(H1),
    H2_sorted = lists:sort(H2),
    R1 = get_rank_for_hand(H1_sorted),
    R2 = get_rank_for_hand(H2_sorted),
    print_rank(R1),
    print_rank(R2),
    case R1 == R2 of
        false ->
            R1 >= R2;
        true ->
            %%TODO: This is wrong. Needs to consider highest card, not sum
            Sum1 = lists:foldl(fun({V,_S}, Acc) -> Acc + V end, 0, H1_sorted),
            erlang:display(Sum1),
            Sum2 = lists:foldl(fun({V,_S}, Acc) -> Acc + V end, 0, H2_sorted),
            erlang:display(Sum2),
            Sum1 >= Sum2
    end.


print_rank(Rank) ->
    case Rank of
        1 -> erlang:display("You have nothing");
        2 -> erlang:display("One pair");
        3 -> erlang:display("Two pairs");
        4 -> erlang:display("Three of a kind");
        5 -> erlang:display("Straight");
        6 -> erlang:display("Flush");
        7 -> erlang:display("Full house");
        8 -> erlang:display("Four of a kind");
        9 -> erlang:display("Straight flush");
        10 -> erlang:display("Royal stright flush")
    end.

get_rank_for_hand(Hand) ->
    case is_royal_flush(Hand) of
        true -> 10;
        false ->
            case is_straight_flush(Hand) of
                true -> 9;
                false ->
                    case is_four_of_a_kind(Hand) of
                        true -> 8;
                        false ->
                            case is_full_house(Hand) of
                                true -> 7;
                                false ->
                                    case is_flush(Hand) of
                                        true -> 6;
                                        false -> 
                                            case is_straight(Hand) of
                                                true -> 5;
                                                false ->
                                                    case is_three_of_a_kind(Hand) of
                                                        true -> 4;
                                                        false ->
                                                            case is_two_pairs(Hand) of
                                                                true -> 3;
                                                                false ->
                                                                    case is_one_pair(Hand) of
                                                                        true -> 2;
                                                                        false -> 1 % Only high cards
                                                                    end
                                                            end
                                                    end
                                            end
                                    end
                            end
                    end

            end
    end.

% Rank 10
is_royal_flush([{V1, S1}, {V2, S2}, {V3, S3}, {V4, S4}, {V5, S5}]) ->
    case is_same_suit(S1,S2,S3,S4,S5) of
        false -> false;
        true -> 
            V1 == 10 andalso
            V2 == 11 andalso
            V3 == 12 andalso
            V4 == 13 andalso
            V5 == 14
    end.

%   Rank 9
is_straight_flush([{V1, S1}, {V2, S2}, {V3, S3}, {V4, S4}, {V5, S5}]) ->
    case is_same_suit(S1,S2,S3,S4,S5) of
        false -> false;
        true -> 
            V1 == V2 + 1 andalso
            V2 == V3 + 1 andalso
            V3 == V4 + 1 andalso
            V4 == V5 + 1
    end.

%   Rank 8
is_four_of_a_kind([{V1, _S1}, {V2, _S2}, {V3, _S3}, {V4, _S4}, {V5, _S5}]) ->
    ((V1 == V2) and (V1 == V3) and (V1 == V4)) or
    ((V2 == V3) and (V2 == V4) and (V2 == V5)). 

%   Rank 7
is_full_house([{V1, _S1}, {V2, _S2}, {V3, _S3}, {V4, _S4}, {V5, _S5}]) ->
    ((V1 == V2) and (V1 == V3) and (V4 == V5)) or
    ((V1 == V2) and (V3 == V4) and (V3 == V5)).

%   Rank 6
is_flush([{_V1, S1}, {_V2, S2}, {_V3, S3}, {_V4, S4}, {_V5, S5}]) ->
    is_same_suit(S1,S2,S3,S4,S5).

%   Rank 5
is_straight([{V1, _S1}, {V2, _S2}, {V3, _S3}, {V4, _S4}, {V5, _S5}]) ->
    (V2 == (V1 + 1)) and
    (V3 == (V2 + 1)) and
    (V4 == (V3 + 1)) and
    (V5 == (V4 + 1)).

%   Rank 4
is_three_of_a_kind([{V1, _S1}, {V2, _S2}, {V3, _S3}, {V4, _S4}, {V5, _S5}]) ->
    ((V1 == V2) and (V1 == V3)) or
    ((V2 == V3) and (V2 == V4)) or
    ((V3 == V4) and (V3 == V5)).

%   Rank 3
is_two_pairs([{V1, _S1}, {V2, _S2}, {V3, _S3}, {V4, _S4}, {V5, _S5}]) ->
    ((V1 == V2) and (V3 == V4)) or
    ((V1 == V2) and (V4 == V5)) or
    ((V2 == V3) and (V4 == V5)).

%   Rank 2
%   One Pair: Two cards of the same value.
is_one_pair([{V1, _S1}, {V2, _S2}, {V3, _S3}, {V4, _S4}, {V5, _S5}]) ->
    (V1 == V2) or 
    (V2 == V3) or 
    (V3 == V4) or 
    (V4 == V5).

is_same_suit(S1, S2, S3, S4, S5) ->
    S1 == S2 andalso
    S1 == S3 andalso
    S1 == S4 andalso
    S1 == S5.