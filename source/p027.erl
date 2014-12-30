-module (p027).
-export ([run/0]).

%% Correct: -59231

run() ->
    As = lists:seq(-999,999),
    Bs = lists:seq(-999,999),
    Lengths = [{A,B,sequence_of_primes(A,B)} || A <- As, B <- Bs],
    find_max(Lengths, {0,0,0}).

find_max([],{A,B,_}) ->
    A*B;
find_max([{A1,B1,L1}|Tail], {_Am,_Bm,_Lm}) when L1 > _Lm ->
    find_max(Tail, {A1,B1,L1});
find_max([{_A1,_B1,_L1}|Tail], {Am,Bm,Lm}) when _L1 =< Lm ->
    find_max(Tail, {Am,Bm,Lm}).

sequence_of_primes(A,B) ->
    sequence_of_primes(A,B,0).

sequence_of_primes(A,B,N) ->
    Value = (N*N) + (A*N) + B,
    Is_prime = is_prime(Value),
    if
        Is_prime == true -> sequence_of_primes(A,B,N+1);
        true -> N
    end.


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