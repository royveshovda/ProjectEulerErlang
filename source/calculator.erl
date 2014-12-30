-module (calculator).
-export ([pow/2, get_digits/1, factorial/1, is_prime/1, assemble_number/1, permute/1]).

pow(X, N) when is_integer(N), N >= 0 -> pow(X, N, 1);
pow(X, N) when is_integer(N) -> 1 / pow(X, -N, 1);
pow(X, N) when is_float(N) -> math:pow(X, N).

pow(_, 0, P) -> P;
pow(X, N, A) when N rem 2 =:= 0 ->
    pow(X * X, N div 2, A);
pow(X, N, A) -> pow(X, N - 1, A * X).

get_digits(N) ->
    Digits = integer_to_list(N),
    L = string:len(Digits),
    I = lists:seq(1,L),
    S_with_rest = [string:to_integer(string:substr(Digits,X,1)) || X <- I],
    [X || {X,_} <- S_with_rest].

factorial(1) ->
    1;
factorial(N) ->
    N* factorial(N-1).

is_prime(N) when N < 0 ->
    false;
is_prime(2) -> true;
is_prime(N) ->
    N rem 2 =/= 0 andalso is_prime(N, 3, math:sqrt(N)).

is_prime(_, Div, Sqrt) when Div > Sqrt ->
    true;
is_prime(N, Div, Sqrt) ->
    case N rem Div =:= 0 of
        true -> false;
        _ -> is_prime(N, Div + 2, Sqrt)
    end.

permute([]) -> [[]];
permute(L) -> [[X|Y] || X<-L, Y<-permute(L--[X])].

assemble_number(L) ->
    assemble_number(L,length(L)-1,0).

assemble_number([], _, Acc) ->
    Acc;
assemble_number([H|T],Multiplier, Acc) ->
    New_acc = Acc + (H * pow(10,Multiplier)),
    assemble_number(T, Multiplier-1, New_acc).