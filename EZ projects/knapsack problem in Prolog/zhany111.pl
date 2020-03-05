% The possible items we can put in our our knapsack (the x𝑖's).
weight(charger,1).
weight(phone,2).
weight(lunch,5).
weight(computer,10).
weight(textbook,25).

% Nothing fits with 0 “Capacity”.
knapsack(0,[]).

% We can pack a charger in addition to some “Rest” of contents if…
knapsack(Capacity,[charger|Rest]) :-
  % we have “Capacity”  for 1 unit, and…
  Capacity >= 1,
  % the “Remaining” space is enough to fit the “Rest”.
  Remaining is (Capacity - 1), % (is performs arithmetic; = would not).
  knapsack(Remaining,Rest).

knapsack(Capacity,[phone|Rest]) :-
  % we have “Capacity”  for 2 unit, and…
  Capacity >= 2,
  Capacity < 5,
  % the “Remaining” space is enough to fit the “Rest”.
  Remaining is (Capacity - 2), % (is performs arithmetic; = would not).
  knapsack(Remaining,Rest).

knapsack(Capacity,[lunch|Rest]) :-
  % we have “Capacity”  for 5 unit, and…
  Capacity >= 5,
  Capacity < 10,
  % the “Remaining” space is enough to fit the “Rest”.
  Remaining is (Capacity - 5), % (is performs arithmetic; = would not).
  knapsack(Remaining,Rest).

knapsack(Capacity,[computer|Rest]) :-
  % we have “Capacity”  for 10 unit, and…
  Capacity >= 10,
  Capacity < 25,
  % the “Remaining” space is enough to fit the “Rest”.
  Remaining is (Capacity - 10), % (is performs arithmetic; = would not).
  knapsack(Remaining,Rest).

knapsack(Capacity,[textbook|Rest]) :-
  % we have “Capacity”  for 25 unit, and…
  Capacity >= 25,

  % the “Remaining” space is enough to fit the “Rest”.
  Remaining is (Capacity - 25), % (is performs arithmetic; = would not).
  knapsack(Remaining,Rest).

% Task 2
% Nothing fits with 0 “Capacity”.
knapsackDRY(0,[]).

% We can pack an “Item” in addition to some “Rest” of contents if…
knapsackDRY(Capacity,[Item|Rest]) :-
  (weight(Item, X)), 
  % we have “Capacity”  for 25 unit, and…
  Capacity >= X,

  % the “Remaining” space is enough to fit the “Rest”.
  Remaining is (Capacity - X), % (is performs arithmetic; = would not).
  knapsack(Remaining,Rest).

% Task 3
% Nothing fits with 0 “Capacity”.
knapsackSingle(0,[]).

% We can pack a charger in addition to some “Rest” of contents if…
knapsackSingle(Capacity,[charger|Rest]) :-
  % we have “Capacity”  for 1 unit, and…
  Capacity = 1,
  % the “Remaining” space is enough to fit the “Rest”.
  Remaining is (Capacity - 1), % (is performs arithmetic; = would not).
  knapsack(Remaining,Rest).

knapsackSingle(Capacity,[phone|Rest]) :-
  % we have “Capacity”  for 2 unit, and…
  Capacity >= 2,
  Capacity < 5,
  % the “Remaining” space is enough to fit the “Rest”.
  Remaining is (Capacity - 2), % (is performs arithmetic; = would not).
  knapsack(Remaining,Rest).

knapsackSingle(Capacity,[lunch|Rest]) :-
  % we have “Capacity”  for 5 unit, and…
  Capacity >= 5,
  Capacity < 10,
  % the “Remaining” space is enough to fit the “Rest”.
  Remaining is (Capacity - 5), % (is performs arithmetic; = would not).
  knapsack(Remaining,Rest).

knapsackSingle(Capacity,[computer|Rest]) :-
  % we have “Capacity”  for 10 unit, and…
  Capacity >= 10,
  Capacity < 25,
  % the “Remaining” space is enough to fit the “Rest”.
  Remaining is (Capacity - 10), % (is performs arithmetic; = would not).
  knapsack(Remaining,Rest).

knapsackSingle(Capacity,[textbook|Rest]) :-
  % we have “Capacity”  for 25 unit, and…
  Capacity >= 25,

  % the “Remaining” space is enough to fit the “Rest”.
  Remaining is (Capacity - 25), % (is performs arithmetic; = would not).
  knapsack(Remaining,Rest).
