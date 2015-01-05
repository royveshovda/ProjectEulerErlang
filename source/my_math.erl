-module (my_math).
-export ([
            pow/2,
            factorial/1,
            is_palindrome/1,
            gcd/1, gcd/2,
            lcm/1, lcm/2,
            powerset/1,
            fib/1,
            fib_generator/0,
            d/1,
            modpow/3,
            totient/1,
            floor/1,
            ceiling/1,
            is_pandigital/1,
            proper_divisors/1,
            prime_factors/1,
            prime_factors_mult/1,
            totient_phi_improved/1
        ]).

-define(GOLD_RATIO, (1 + math:sqrt(5)) / 2).

pow(X, N) when is_integer(N), N >= 0 -> pow(X, N, 1);
pow(X, N) when is_integer(N) -> 1 / pow(X, -N, 1);
pow(X, N) when is_float(N) -> math:pow(X, N).

pow(_, 0, P) -> P;
pow(X, N, A) when N rem 2 =:= 0 ->
    pow(X * X, N div 2, A);
pow(X, N, A) -> pow(X, N - 1, A * X).

factorial(N) ->
    factorial(N, 1).

factorial(0, F) -> F;
factorial(1, F) -> F;
factorial(X, F) -> factorial(X-1, F*X).

is_palindrome(N) when is_integer(N) ->
    is_palindrome(integer_to_list(N));
is_palindrome(L) ->
    L =:= lists:reverse(L).

%% Euler's Algorithm
gcd(A, 0) -> A;
%gcd(A, B) when A < 0 orelse B < 0 -> gcd(abs(A), abs(B));
%gcd(A, B) when A < B -> gcd(B, A);
%gcd(A, B) -> gcd(B, A - B * (A div B)).
gcd(A, B) -> gcd(B, A rem B).

%% gcd(A, B, C) = gcd( gcd(a,b), c)
gcd([A, B | L]) ->
    lists:foldl(fun(X, Acc) -> gcd(X, Acc) end, gcd(A, B), L).

lcm(A, B) ->
    A * B div gcd(A, B).
%% lcm(A, B, C) = lcm( lcm(a,b), c)
lcm([A, B | L]) ->
    lists:foldl(fun(X, Acc) -> lcm(X, Acc) end, lcm(A, B), L).


%% powerset of [1,2,3] => [[], [1], [2], [3], [1,2], [1,3], [2,3], [1,2,3]]
powerset(L) ->
    N = length(L),
    Max = trunc(math:pow(2,N)),
    [[lists:nth(Pos+1,L) || Pos <- lists:seq(0,N-1),
                                I band (1 bsl Pos) =/= 0]
            || I <- lists:seq(0,Max-1)].

%% restricted divisor function
d(N) -> lists:sum(proper_divisors(N)).

proper_divisors(N) -> [ X || X <- lists:seq(1, N-1), N rem X =:= 0].

%% returns the Nth fibonacci number where
%% {F1, 1}, {F2, 1}, {F3, 2}, {F4, 3},...
fib(Nth) ->
    round((math:pow(?GOLD_RATIO, Nth) - math:pow(( 1 - ?GOLD_RATIO ), Nth)) / math:sqrt(5)).

fib_generator() ->
    fib_generator(0, 1, 1).
fib_generator(A, B, N) ->
    [{N,B} | fun() -> fib_generator(B, A+B, N+1) end ].

%% finds C in the equation C ≡ B^E rem M
modpow(B, E, M) ->
    modpow(B, E, M, 1).
modpow(_B, E, _M, R) when E =< 0 -> R;
modpow(B, E, M, R) ->
    R1 = case E band 1 =:= 1 of
            true -> (R * B) rem M;
            false -> R
        end,
modpow( (B*B) rem M, E bsr 1, M, R1).

floor(X) ->
    T = erlang:trunc(X),
    case (X - T) of
        Neg when Neg < 0 -> T - 1;
        Pos when Pos > 0 -> T;
        _ -> T
    end.

ceiling(X) ->
    T = erlang:trunc(X),
    case (X - T) of
        Neg when Neg < 0 -> T;
        Pos when Pos > 0 -> T + 1;
        _ -> T
    end.

is_pandigital(N) when length(N) =:= 9 ->
    lists:all(fun(D) -> lists:member(D, N) end, lists:seq($1, $9));
is_pandigital(_) -> false.

% Euler's phi-function
totient(1) -> 1;
totient(N) ->
    case primes:is_prime(N) of
        false ->
            Factors = primes:prime_factors(N),
            round(lists:foldl(fun({P, _C}, Acc) -> Acc * (1 - ( 1 / P ) ) end, N, Factors));
        true ->
            N-1
    end.

%% ==============================================================================
%% @doc
%% P37 (**) Calculate Euler's totient function phi(m) (improved).
%%
%% See problem P34 for the definition of Euler's totient function. If the list
%% of the prime factors of a number M is known in the form of problem P36 then
%% the function phi(m) can be efficiently calculated as follows: Let ((p1 m1)
%% (p2 m2) (p3 m3) ..) be the list of prime factors (and their multiplicities)
%% of a given number M. Then phi(m) can be calculated with the following formula:
%%
%% phi(m) = (p1-1) * p1 ** (m1-1) * (p2-1) * p2 ** (m2-1) * (p3-1) * p3 ** (m3-1) * ...
%%
%% Note that a ** b stands for the b'th power of a.
%% @end
%% ==============================================================================
-spec totient_phi_improved(N) -> M when
    N :: pos_integer(),
    M :: pos_integer().
totient_phi_improved(N) when is_integer(N),
    N > 0 ->
    Mapper = fun([H|T]) -> (H-1) * math:pow(H,hd(T)-1) end,
    trunc(lists:foldl(fun(X, Prod) -> X * Prod end,
    1,
    lists:map(Mapper, prime_factors_mult(N)))).

%% =========================================================================
%% @doc
%% P36 (**) Determine the prime factors of a given positive integer (2).
%%
%% Construct a list containing the prime factors and their multiplicity.
%% @end
%%
%% Example:
%% > (prime-factors-mult 315)
%% > ((3 2) (5 1) (7 1))
%%
%% Hint: The problem is similar to problem P13.
%% =========================================================================
%%
%% Actually, the problem is more similar to Problem P11, but in P11 the results
%% are returned in the opposite order from which we are seeking. In other words,
%% we could implement something like:
%%
%% prime_factors_mult(N) -> encode( prime_factors(N) ).
%%
%% But the result would be something like:
%%
%% > prime_factors_mult(315)
%% > [[2,3], [1,5], [1,7]]
%%
%% In other words, each sublist would be in the reverse order from what we are
%% seeking. Instead, let's just define our own anonymous fun, similar to that in
%% P11, but which returns the elements in the proper order:
%%
-spec prime_factors_mult(N) -> List when
    N :: pos_integer(),
    List :: [term | List].

prime_factors_mult(N) when is_integer(N), N > 1 ->
    %%
    %% The "Encode" fun defined here is essentially P11,
    %% just tweaked to fit our requirements here:
    %%
    Encode = fun([H|T], [], Acc, Func) -> Func(T, [H,1], Acc, Func);
                ([H|T], [H,M], Acc, Func) -> Func(T, [H,M+1], Acc, Func);
                ([H|T], A, Acc, Func) -> Func(T, [H,1], [A] ++ Acc, Func);
                ([], A, Acc, _Func) -> lists:reverse([A] ++ Acc)
            end,
Encode( prime_factors(N), [], [], Encode ).

%% ========================================================================
%% @doc
%% P35 (**) Determine the prime factors of a given positive integer.
%%
%% Construct a flat list containing the prime factors in ascending order.
%% @end
%%
%% Example:
%% > (prime-factors 315)
%% > (3 3 5 7)
%% ========================================================================
%%
%% The following is a simple, "naive" algorithm for finding the prime factors
%% of (comparatively) small integers. For larger integers, an algorithm like
%% the quadratic sieve, invented by Carl Pomerance in 1981, would be more
%% effective. QS is a faster, effective procedure for calculating prime factors
%% for numbers up to (roughly) 100 digits in length.
%%
-spec prime_factors(N) -> [N] when
    N :: pos_integer().

prime_factors(N) when is_integer(N), N > 1 ->
    %% seperate 2 out as a special factor, so we can increment more efficiently
    PrimeFactorsIter = fun(_, M, Acc, _Func) when (M =:= 0) or (M =:= 1) -> Acc;
                    (2, M, Acc, Func) when M rem 2 =:= 0 ->
                        Func(2, M div 2, Acc ++ [2], Func);
                    (2, M, Acc, Func) when M rem 2 =/= 0 ->
                        Func(3, M, Acc, Func);
                    (D, M, Acc, Func) when M rem D =:= 0 ->
                        Func(D, M div D, Acc ++ [D], Func);
                    (D, M, Acc, Func) when M rem D =/= 0 ->
                        Func(D+2, M, Acc, Func)
        end,
    PrimeFactorsIter(2, N, [], PrimeFactorsIter).