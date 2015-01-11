-module (p060).
-export ([solve/0]).
-import (helper, [to_digits/1, assemble_number/1]).

solve() ->
    Filename_pairs = "p060_pairs.data",
    Filename_sets = "p060_sets.data",
    Map = get_sets_as_map(Filename_pairs, Filename_sets),
    %Ns = maps:keys(Map),

    S3 = maps:get(3,Map),
    S7 = maps:get(7,Map),
    S673 = maps:get(673,Map),
    Si = sets:intersection([S3,S7,S673]),
    sets:to_list(Si).

    %TODO: Loop through all numbers, and try tu build intersections of size 5 or more

    %Map -> {N,Set}

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

get_sets_as_map(Filename_pairs, Filename_sets) ->
    case file:read_file_info(Filename_sets) of
        {ok,_} ->
            {ok, Binary} = file:read_file(Filename_sets),
            {_Pairs, Candidates} = binary_to_term(Binary),
            maps:from_list(Candidates);
        _ ->

            Pairs = get_pairs(Filename_pairs),
            Candidates = generate_sets(Pairs),
            Data = {Pairs, Candidates},
            Binary = term_to_binary(Data),
            ok = file:write_file(Filename_sets, Binary),
            maps:from_list(Candidates)
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

generate_sets(Pairs) ->
    Ns = get_all_numbers(Pairs),
    lists:map(fun(N) -> {N, get_set(N, Pairs)} end, Ns).
  
get_set(N,Pairs) ->
    get_set(N, Pairs, []).

get_set(_N, [], Acc) ->
    sets:from_list(lists:sort(Acc));
    %lists:sort(Acc);
get_set(N, [{N,B}|Rest], Acc) ->
    get_set(N, Rest, [B|Acc]);
get_set(N, [{A,N}|Rest], Acc) ->
    get_set(N, Rest, [A|Acc]);
get_set(N, [{_A,_B}|Rest], Acc) ->
    get_set(N, Rest, Acc).

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
