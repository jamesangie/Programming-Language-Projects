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
  S1 = sequence(_, _),
  S2 = assign(_, _);
  S1 = either(_, _);
  S1 = sequence(_, _).

% The last, sequence(S1, S2). It has two inputs which are statements.
% Execute first statements S1, then execute second statement S2
sequence(S1, S2) :-
  % Type check same as for either(). S1 and S2 need to both be one of:
  % assign(), either() or sequence()
  S1 = assign(_, _);
  S1 = either(_, _);
  S1 = sequence(_, _),
  S2 = assign(_, _);
  S1 = either(_, _);
  S1 = sequence(_, _).

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


  
