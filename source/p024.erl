-module (p024).
-export([solve/0]).
-import (calculator, [permute/1, assemble_number/1]).

%%Link: https://projecteuler.net/problem=24
%%Correct: 2783915460

solve() ->
    L = [0,1,2,3,4,5,6,7,8,9],
    Perms = permute(L),
    Number = lists:nth(1000000,Perms),
    assemble_number(Number).

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