-module (p060).
-export ([solve/0]).
-import (helper, [to_digits/1, assemble_number/1]).

solve() ->
    Map = get_sets_as_map(),
    Ns = maps:keys(Map),
    Cs = lists:map(fun(N) -> check(Map, [N]) end, Ns),
    Results = lists:filter(fun(L) -> length(L) > 0 end, Cs),
    Values = lists:map(fun(L) -> lists:flatten(L) end, Results),
    lists:min(lists:map(fun(L) -> lists:sum(L) end, Values)).

check(_, Acc) when length(Acc) >= 5 -> Acc;
check(Map, Acc) ->
    Sets = lists:map(fun(N) -> maps:get(N,Map) end, Acc),
    Potensials = sets:intersection(Sets),
    case sets:size(Potensials) of
        0 -> [];
        _ ->
            Cs = sets:to_list(Potensials),
            New_candidates = lists:map(fun(N) -> lists:sort([N|Acc]) end, Cs),
            Lists = lists:map(fun(L) -> check(Map, L) end, New_candidates),
            lists:usort(lists:filter(fun(L) -> length(L) > 0 end, Lists))
    end.

get_sets_as_map() ->
    Pairs = generate_pairs(),
    Candidates = generate_sets(Pairs),
    maps:from_list(Candidates).
    
generate_sets(Pairs) ->
    Ns = get_all_numbers(Pairs),
    lists:map(fun(N) -> {N, get_set(N, Pairs)} end, Ns).
  
get_set(N,Pairs) ->
    get_set(N, Pairs, []).

get_set(_N, [], Acc) ->
    sets:from_list(lists:sort(Acc));
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
