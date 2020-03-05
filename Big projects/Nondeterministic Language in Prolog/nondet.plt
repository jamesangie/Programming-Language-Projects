:- begin_tests(nondet).
:- include(nondet). % Your file.

% Note: the [nondet] option being passed to each call of test below
% suppresses warnings about choice points; it is not related to our nondet file.

% Assignment
test(assign_x_1, [nondet]) :- mightAssign(assign(x,1),x,1).
test(assign_y_10, [nondet]) :- mightAssign(assign(y,10),y,10).
test(x_unassigned, [nondet]) :-
    \+ mightAssign(assign(y,10),x,0).
% \+ means this is NOT provable

% Sequence
test(assign_x_then_y, [nondet]) :-
    S1 = assign(x,1),
    S2 = assign(y,2),
    S = sequence(S1,S2),
    mightAssign(S,x,1),
    mightAssign(S,y,2).
test(assign_x_twice, [nondet]) :-
    S1 = assign(x,1),
    S2 = assign(x,2),
    S = sequence(S1,S2),
    mightAssign(S,x,2).

% Either
test(assign_x_or_y, [nondet]) :-
    S1 = assign(x,1),
    S2 = assign(y,2),
    S = either(S1,S2),
    mightAssign(S,x,1),
    mightAssign(S,y,2).
test(assign_x_twice, [nondet]) :-
    S1 = assign(x,1),
    S2 = assign(x,2),
    S = either(S1,S2),
    mightAssign(S,x,1),
    mightAssign(S,x,2).

:- end_tests(nondet).
