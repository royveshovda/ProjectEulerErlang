-module (p060).
-export ([solve/0]).
-import (helper, [to_digits/1, assemble_number/1]).

solve() ->
    Filename = "p060_test.data",
    {Pairs, Candidate_sets} = get_data(Filename),
    %Valid_sets = lists:filter(fun(S) -> verify_set(S, Pairs) end, Candidate_sets),
    %Sets_with_sum = lists:map(fun(L) -> {lists:sum(L), L} end, Valid_sets),
    %{S,_} = lists:min(Sets_with_sum),
    %S.
    length(Candidate_sets).

verify_set([A,B,C,D,E], Pairs) ->
    Checks = [{A,B},{A,C},{A,D},{A,E},{B,C},{B,D},{B,E},{C,D},{C,E},{D,E}],
    Results = lists:map(fun(S) -> lists:member(S,Pairs) end, Checks),
    lists:foldl(fun(R, Acc) -> (Acc and R) end, true, Results).

get_data(Filename) ->
    case file:read_file_info(Filename) of
        {ok,_} ->
            {ok, Binary} = file:read_file(Filename),
            binary_to_term(Binary);
        _ ->
            Pairs = generate_pairs(),
            Candidates = generate_set_candidates(Pairs),
            Data = {Pairs, Candidates},
            Binary = term_to_binary(Data),
            ok = file:write_file(Filename, Binary),
            Data
    end.

generate_set_candidates(Pairs) ->
    Ns = get_all_numbers(Pairs),
    %Set_candidates = permute_5(Ns),
    Set_candidates = comb(5,Ns),
    Internal_sorted = lists:map(fun(L) -> lists:sort(L) end, Set_candidates),
    lists:usort(Internal_sorted).
  
permute_5(L) ->
    [[A,B,C,D,E] || A <- L, B <- L--[A], C <- L--[A]--[B], D <- L--[A]--[B]--[C], E <- L--[A]--[B]--[C]--[D]].

comb(0,_) ->
    [[]];
comb(_,[]) ->
    [];
comb(N,[H|T]) ->
    [[H|L] || L <- comb(N-1,T)]++comb(N,T).

get_all_numbers(Pairs) ->
    Ns = lists:foldl(fun({A,B}, Acc) -> [A,B|Acc] end, [], Pairs),
    lists:usort(Ns).

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
