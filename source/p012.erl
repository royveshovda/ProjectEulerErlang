-module (p012).
-export ([run/0]).

%% Correct: 76576500

run() ->
    N=500,
    next(2, [2], [1], N).

next(N, [_|DivsT] = CurDivs, [PowersH|PowersT]=CurPowers, Max)->
    {[_|NextDivsT] = NextDivs, [NextPowersH|NextPowersT]= NextPowers} = factor_powers(N + 1),
    Num = case N rem 2 of %we have to subtract 1 from the powers of 2
        0 when PowersH > 1 ->
            num_divisors(CurDivs, [PowersH - 1|PowersT], NextDivs, NextPowers, 1);
        0 ->
            num_divisors(DivsT, PowersT, NextDivs, NextPowers, 1);
        _ when NextPowersH > 1 ->
            num_divisors(CurDivs, CurPowers, NextDivs, [NextPowersH - 1|NextPowersT], 1);
        _ ->
            num_divisors(CurDivs, CurPowers, NextDivsT, NextPowersT, 1)
    end,
    case Num > Max of
        true ->
            {(N*(N+1)) div 2, N, Num};
        _ -> next(N+1, NextDivs, NextPowers, Max)
    end.

num_divisors([], _, [], _, Acc) ->
Acc;
num_divisors([], _, [_|DivT2], [PowH2|PowT2], Acc) ->
    num_divisors([], [], DivT2, PowT2, Acc*(PowH2 + 1));
num_divisors([_|DivT1], [PowH1|PowT1], [], _, Acc) ->
    num_divisors(DivT1, PowT1, [], [], Acc*(PowH1 + 1));
num_divisors([DivH1|DivT1] = Div1, [PowH1|PowT1] = Pow1, [DivH2|DivT2] = Div2, [PowH2|PowT2] = Pow2, Acc) ->
    case true of
        true when DivH1 =:= DivH2 ->
            num_divisors(DivT1, PowT1, DivT2, PowT2, Acc*(PowH1 + PowH2 + 1));
        true when DivH1 > DivH2 ->
            num_divisors(Div1, Pow1, DivT2, PowT2, Acc*(1 + PowH2));
        _ ->
            num_divisors(DivT1, PowT1, Div2, Pow2, Acc*(1 + PowH1))
    end.

%Return the N's prime factors and their powers
factor_powers(N) ->
    {D, P} = factor_powers(N, 2, 0, [], []),
    {lists:reverse(D), lists:reverse(P)}.

factor_powers(N, I, Counter, Acc1, Acc2) when I > (N div 2)->
    case true of
        true when I =:= N -> {[N|Acc1], [Counter + 1 | Acc2]};
        true when Counter > 0 -> {[N|[I|Acc1]], [1|[Counter|Acc2]]};
        _ -> {[N|Acc1], [1|Acc2]}
    end;
factor_powers(N, I, Counter, Acc1, Acc2) ->
    case true of
        true when (N rem I) =:= 0 ->
            factor_powers(N div I, I, Counter + 1, Acc1, Acc2);
        true when Counter > 0 ->
            factor_powers(N, I + 1, 0, [I|Acc1], [Counter|Acc2]);
        _ ->
            factor_powers(N, I + 1, 0, Acc1, Acc2)
    end.