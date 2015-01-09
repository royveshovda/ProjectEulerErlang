-module (p060).
-export ([solve/0]).
-import (helper, [to_digits/1, assemble_number/1]).

solve() ->
    Filename = "p060_test.data",
    Pairs = get_pairs(Filename),
    Ns = get_all_numbers(Pairs),
    length(Ns).
    

    %7
    %1237
    %C1 = {7,1237},

    %2341
    %C2 = {7, 2341},
    %C3 = {1237, 2341},

    %12409
    %C4 = {7, 12409},
    %C5 = {1237, 12409},
    %C6 = {2341, 12409}

    %18433
    %C7 = {7, 18433},
    %C8 = {1237, 18433},
    %C9 = {2341, 18433},
    %C10 = {12409, 18433}
get_all_numbers(Pairs) ->
    Ns = lists:foldl(fun({A,B}, Acc) -> [A,B|Acc] end, [], Pairs),
    lists:usort(Ns).

get_pairs(Filename) ->
    case filelib:is_file(Filename) of
        true ->
            {ok, Data} = file:read_file(Filename),
            binary_to_term(Data);
        false ->
            Pairs = generate_pairs(),
            Data = term_to_binary(Pairs),
            ok = file:write_file(Filename, Data),
            Pairs
    end.



generate_pairs() ->
    prime_server:start_link(20000),
    Primes = prime_server:sieve(20000),
    Pair_candidates = [{A,B}|| A <- Primes, B <- Primes, B>A],
    lists:filter(fun({A,B}) -> is_pair(A,B) end, Pair_candidates).

is_pair(A,B) ->
	As = to_digits(A),
	Bs = to_digits(B),
	AB = assemble_number(As ++ Bs),
	BA = assemble_number(Bs ++ As),
	prime_server:is_prime(AB) andalso prime_server:is_prime(BA).
