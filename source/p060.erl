-module (p060).
-export ([solve/0]).
-import (helper, [to_digits/1, assemble_number/1]).

solve() ->
    Filename_pairs = "p060_pairs.data",
    Filename_sets = "p060_sets.data",
    {Pairs, Candidate_sets} = get_data(Filename_pairs, Filename_sets),
    %Valid_sets = lists:filter(fun(S) -> verify_set(S, Pairs) end, Candidate_sets),
    %Sets_with_sum = lists:map(fun(L) -> {lists:sum(L), L} end, Valid_sets),
    %{S,_} = lists:min(Sets_with_sum),
    %S.
    length(Candidate_sets).

verify_set([A,B,C,D,E], Pairs) ->
    Checks = [{A,B},{A,C},{A,D},{A,E},{B,C},{B,D},{B,E},{C,D},{C,E},{D,E}],
    Results = lists:map(fun(S) -> lists:member(S,Pairs) end, Checks),
    R = lists:foldl(fun(R, Acc) -> (Acc and R) end, true, Results),
    if
    	R == true ->
    		io:format("~p, ~p, ~p, ~p, ~p",[A,B,C,D,E]);
    	true -> ok
    end,
    R.

get_data(Filename_pairs, Filename_sets) ->
    case file:read_file_info(Filename_sets) of
        {ok,_} ->
            {ok, Binary} = file:read_file(Filename_sets),
            binary_to_term(Binary);
        _ ->

            Pairs = get_pairs(Filename_pairs),
            Candidates = generate_set_candidates(Pairs),
            Data = {Pairs, Candidates},
            Binary = term_to_binary(Data),
            ok = file:write_file(Filename_sets, Binary),
            Data
    end.

get_pairs(Filename) ->
	case file:read_file_info(Filename) of
        {ok,_} ->
            {ok, Binary} = file:read_file(Filename),
            binary_to_term(Binary);
        _ ->
            Pairs = generate_pairs(),
            Binary = term_to_binary(Pairs),
            ok = file:write_file(Filename, Binary),
            Pairs
   	end.

generate_set_candidates(Pairs) ->
    Ns = get_all_numbers(Pairs),
    %io:format("Numbers: ~p~n", [length(Ns)]),
    Set_candidates = permute_5(Ns, Pairs),
    %Set_candidates = get_permutations(Ns),
    Internal_sorted = lists:map(fun(L) -> lists:sort(L) end, Set_candidates),
    lists:usort(Internal_sorted).
  
permute_5(L, Pairs) ->
    [[A,B,C,D,E] || A <- L, B <- L--[A], C <- L--[A]--[B], D <- L--[A]--[B]--[C], E <- L--[A]--[B]--[C]--[D], verify_set([A,B,C,D,E],Pairs)].

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
