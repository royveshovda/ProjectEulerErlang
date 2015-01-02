-module (p027).
-export ([solve/0]).

%% Correct: -59231

solve() ->
    prime_server:start_link(1000000),
    
    As = lists:seq(-999,999),
    Bs = lists:seq(-999,999),
    Lengths = [{A,B,sequence_of_primes(A,B)} || A <- As, B <- Bs],
    Ans = find_max(Lengths, {0,0,0}),
    prime_server:stop(),
    Ans.

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
    Is_prime = prime_server:is_prime(Value),
    if
        Is_prime == true -> sequence_of_primes(A,B,N+1);
        true -> N
    end.