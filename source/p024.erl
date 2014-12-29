-module (p024).
-export([run/0]).

%%Correct: 2783915460

run() ->
    L = [0,1,2,3,4,5,6,7,8,9],
    Perms = permute(L),
    Number = lists:nth(1000000,Perms),
    assemble_number(Number).
    
permute([]) -> [[]];
permute(L) -> [[X|Y] || X<-L, Y<-permute(L--[X])].

assemble_number(L) ->
    L10 = lists:nth(1,L) * 1000000000,
    L9 = lists:nth(2,L) * 100000000,
    L8 = lists:nth(3,L) * 10000000,
    L7 = lists:nth(4,L) * 1000000,
    L6 = lists:nth(5,L) * 100000,
    L5 = lists:nth(6,L) * 10000,
    L4 = lists:nth(7,L) * 1000,
    L3 = lists:nth(8,L) * 100,
    L2 = lists:nth(9,L) * 10,
    L1 = lists:nth(10,L) * 1,
    L10+L9+L8+L7+L6+L5+L4+L3+L2+L1.

%% TODO: Improve:
% Explaining in my words again:
% Permutations of n digits = n!
% 1,000,000 = 9! * 2 + 8! * 6 + 7! * 6 + 6! * 2 + 5! * 5 + 4! * 1 + 3! * 2 + 2! * 2
% Digits: 0123456789
% 9! completed twice. Hence 0 and 1 for first place have been consumed. Hence it is 2 now.
% 2 013456789
% 8! completed 6 times. Hence 0, 1, 3, 4, 5, 6 are consumed for second place. Hence it is 8 now.
% 28 01345679
% With same logic repeated...
% 1 millionth combination would be 2783915460.