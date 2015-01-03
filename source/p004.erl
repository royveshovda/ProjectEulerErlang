-module (p004).
-export ([solve/0]).

%%Link: https://projecteuler.net/problem=4
%%Correct: 906609

solve() ->
    Candidates = [X*Y || X <- lists:seq(100, 999), Y <- lists:seq(100, 999), calculator:is_palindrome(X*Y)],
    lists:max(Candidates).