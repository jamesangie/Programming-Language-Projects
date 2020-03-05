% First we define the statement needed. Which are, first, assign(X, I),
% basicly assigning an interger value I to a variable X.
assign(X, I) :-
  % Check if the inputs are correct by type checking
  atom(X),
  integer(I).
  
% Second, either(S1, S2). It has two inpus S1 and S2, which are
% both statements. It basiclly only executes S1 or S2, but not both  
either(S1, S2) :-
  % Type check for statements S1 and S2. they need to both be one of:
  % assign(), either() or sequence()
  S1 = assign(_, _);
  S1 = either(_, _);
  S1 = sequence(_, _);
  S1 = both(_, _),
  S2 = assign(_, _);
  S1 = either(_, _);
  S1 = sequence(_, _);
  S1 = both(_, _).

% sequence(S1, S2). It has two inputs which are statements.
% Execute first statements S1, then execute second statement S2
sequence(S1, S2) :-
  % Type check same as for either(). S1 and S2 need to both be one of:
  % assign(), either() or sequence()
  S1 = assign(_, _);
  S1 = either(_, _);
  S1 = sequence(_, _);
  S1 = both(_, _),
  S2 = assign(_, _);
  S1 = either(_, _);
  S1 = sequence(_, _);
  S1 = both(_, _).

% both(S1, S2). It has two inputs which are statements.
% The order of executing these two statements is not defined.
both(S1, S2) :-
  % Type check same as for either(). S1 and S2 need to both be one of:
  % assign(), either() or sequence()
  S1 = assign(_, _);
  S1 = either(_, _);
  S1 = sequence(_, _);
  S1 = both(_, _),
  S2 = assign(_, _);
  S1 = either(_, _);
  S1 = sequence(_, _);
  S1 = both(_, _).

% Check if X is assigned with I, when the statement is assign()
mightAssign(assign(A, B), X, I) :-
  % Compare if A = X and B = I. If they are both correct then X and I
  % are assigned together well. 
  A = X,
  I = B.

% Check if X is assigned with I, when the statement is either()
mightAssign(either(S1, S2), X, I) :-
  % use ; to excute one of the statements. 
  mightAssign(S1, X, I);
  mightAssign(S2, X, I).

% Check if X is assigned with I, when the statement is sequence()
mightAssign(sequence(S1, S2), X, I) :-
  % first check if X is assigned in S2. If yes then we are good
  mightAssign(S2, X, I);
  % check if X is assigned in S1, while X is not re-assigned in S2.
  % Since we only want to check the final value of X assigns to.
  mightAssign(S1, X, I),
  \+ mightAssign(S2, X, _).

% Check if X is assigned with I, when the statement is sequence()
mightAssign(both(S1, S2), X, I) :-
  % The order of executing S1 and S2 in not defined.
  % So we just try all the orders, if one of these is possible then we are good.
  mightAssign(either(S1, S2), X, I);
  mightAssign(sequence(S1, S2), X, I);
  mightAssign(sequence(S2, S1), X, I).

  
