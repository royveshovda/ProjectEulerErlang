-module (p009).
-export ([solve/0]).

solve() ->
    As = lists:seq(1,332),
    Bs = lists:seq(2,666),
    Cs = lists:seq(333,997),
    [{P, _A, _B, _C}] = [{A*B*C,A,B,C} || A<-As, B<-Bs, C<-Cs, check_order(A,B,C), check_pythagoras(A,B,C), check_sum(A,B,C)],
    P.

check_order(A, B, C) ->
    B1 = A < B,
    B2 = B < C,
    B1 and B2.

check_pythagoras(A, B, C) ->
    C * C == (A * A) + (B * B).

check_sum(A, B, C) ->
    1000 == A + B +C.