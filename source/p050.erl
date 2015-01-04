-module (p050).
-export ([solve/0]).

-define(MAX_PRIME, 1000000).

%% Inspired from https://github.com/jamesaimonetti/ProjectEuler

solve() ->
    Ps = primes:lazy_sieve(),
    S = 0, % the current running sum
    C = 0, % the current count of primes in the S
    RemIdx = 1, % position of the next prime to take off the back
    Ans = 0, % the Prime
    MaxC = 0, % the Count
    MaxP = round(?MAX_PRIME / (6*math:log(?MAX_PRIME))),
    find(Ps, S, C, RemIdx, Ans, MaxC, MaxP).

find([{P, _Nth} | _Ps], _S, _C, _RemIdx, Ans, _MaxC, MaxP) when P > MaxP -> Ans;
find(_, S, _, _, Ans, _, _) when S < 0 -> Ans;
find([{P,_N} | Ps], S, C, RemIdx, Ans, MaxC, MaxP) when S < ?MAX_PRIME ->
    case primes:is_prime(S) andalso C > MaxC of
        true -> find(Ps(), S+P, C+1, RemIdx, S, C, MaxP);
        false -> case find_aux(S, C, RemIdx, Ans, MaxC) of
            {true, NewAns, NewMaxC} -> find(Ps(), S+P, C+1, RemIdx, NewAns, NewMaxC, MaxP);
            false -> find(Ps(), S+P, C+1, RemIdx, Ans, MaxC, MaxP)
        end
    end;
find(Ps, S, C, RemIdx, Ans, MaxC, MaxP) ->
    NewS = S - primes:nth(RemIdx),
find(Ps, NewS, C-1, RemIdx+1, Ans, MaxC, MaxP).

find_aux(_S, 0, _RemIdx, _Ans, _MaxC) -> false;
find_aux(_S, C, _RemIdx, _Ans, MaxC) when C =< MaxC -> false;
find_aux(S, C, RemIdx, Ans, MaxC) ->
    NewS = S - primes:nth(RemIdx),
    NewC = C-1,
    case primes:is_prime(NewS) andalso NewC > MaxC of
        true -> { true, NewS, NewC};
        false -> find_aux(NewS, NewC, RemIdx+1, Ans, MaxC)
    end.