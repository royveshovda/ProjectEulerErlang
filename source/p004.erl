-module (p004).
-export ([solve/0]).

solve() ->
    Candidates = [X*Y || X <- lists:seq(100, 999), Y <- lists:seq(100, 999), my_math:is_palindrome(X*Y)],
    lists:max(Candidates).