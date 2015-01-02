-module (p049).
-export ([solve/0]).
-import (calculator, [to_digits/1, permute/1, assemble_number/1]).

%% Correct: 296962999629

solve() ->
    prime_server:start_link(10000),
    Primes = prime_server:sieve(9999),
    Candidates_raw = lists:filter(fun(X) -> X > 999 end, Primes),
    Candidates = lists:filter(fun(X) -> (X /= 1487) and (X /= 4817) and (X /= 8147) end, Candidates_raw),
    Candidates_with_digits = lists:map(fun(X) -> {X, sorted_digits(X)} end, Candidates),
    Groups = create_candidate_groups(Candidates_with_digits,[]),
    Matches = lists:map(fun(G) -> check_group(G) end, Groups),
    [{A,_},{B,_},{C,_}] = lists:flatten(lists:filter(fun(G) -> G /= [] end, Matches)),
    As = to_digits(A),
    Bs = to_digits(B),
    Cs = to_digits(C),
    Match = As ++ Bs ++ Cs,
    Ans = assemble_number(Match),
    prime_server:stop(),
    Ans.

permute_3(L) ->
    [[X,Y,Z] || X <- L, Y <- L--[X], Z <- L--[X]--[Y]]. 

create_candidate_groups([], Groups) -> Groups;
create_candidate_groups([{N, Ds}| Rest], Groups) ->
    {Perms, Non_perms} = lists:partition(fun({_, Digits}) -> Digits == Ds end, Rest ),
    case length(Perms) < 2 of
        true -> create_candidate_groups(Non_perms, Groups);
        false ->
            Group = [{N, Ds}| Perms],
            create_candidate_groups(Non_perms, [Group|Groups])
    end.

check_group(Group) ->
    Permutations = permute_3(Group),
    Ordered = lists:filter(fun([A,B,C]) -> (A < B) and (B < C) end, Permutations),
    lists:filter(fun([{Na,_},{Nb,_},{Nc,_}]) -> (Nb-Na) == (Nc-Nb) end, Ordered).

sorted_digits(N) ->
    Ds = to_digits(N),
    lists:sort(Ds).