-module (p003).
-export ([run/0]).

%%Correct: 6857

run() ->
    max_factor(600851475143,2,2).

max_factor(Number, Factor, Max) when Factor > Number ->
    Max;
max_factor(Number, Factor, _) when (Number rem Factor) == 0 ->
    max_factor(trunc(Number / Factor), Factor, Factor);
max_factor(Number, Factor, Max) ->
    max_factor(Number, Factor + 1, Max).