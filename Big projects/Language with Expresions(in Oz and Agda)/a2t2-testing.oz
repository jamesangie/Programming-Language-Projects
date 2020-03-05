declare
%---------------------------------------------------------------------
% BEGIN Interface
%
% Instructions: this set of Oz declarations provides an interface
% for the testing below.
%
% Place this block of declarations in your Oz file,
% probably under your representation code and interpreter.
%
% Specifically, this interfaces asks you to complete
% - a way to refer to specific variables,
% - a way to create an environment in which those variables
%   are assigned unique references, and
% - the ability to call each of your constructor functions
%   (in the event you have used different names than I assume)
%
%---------------------------------------------------------------------

% Modify these functions to return two distinct variables
% (whatever your representation of variables may be).
fun {VarX} 'x' end
fun {VarY} 'y' end

% An environment maps variables to references (addresses)
% Modify this function as needed to return an environment
% which includes distinct addresses for variables X and Y.
fun {XYEnv V}
  if     V == {VarX} then ~ 1
  elseif V == {VarY} then ~ 2
  else   {EmptyState V}
  end
end

% Complete these functions if you have named your
% constructor functions differently, or introduced a
% different means for constructing expressions and statements.

% fun {True} FillMeInIfNeeded end
% fun {False} FillMeInIfNeeded end
% fun {VarB V} FillMeInIfNeeded end
% fun {Eq Subexpr1 Subexpr2} FillMeInIfNeeded end
% fun {Neq Subexpr1 Subexpr2} FillMeInIfNeeded end
% fun {Leq Subexpr1 Subexpr2} FillMeInIfNeeded end
% fun {Less Subexpr1 Subexpr2} FillMeInIfNeeded end
% fun {Geq Subexpr1 Subexpr2} FillMeInIfNeeded end
% fun {Greater Subexpr1 Subexpr2} FillMeInIfNeeded end
% fun {Const N} FillMeInIfNeeded end
% fun {VarI V} FillMeInIfNeeded end
% fun {Plus Subexpr1 Subexpr2} FillMeInIfNeeded end
% fun {Minus Subexpr1 Subexpr2} FillMeInIfNeeded end
% fun {Times Subexpr1 Subexpr2} FillMeInIfNeeded end
% fun {Div Subexpr1 Subexpr2} FillMeInIfNeeded end
% fun {Mod Subexpr1 Subexpr2} FillMeInIfNeeded end
% fun {Skip} FillMeInIfNeeded end
% fun {Local V Substmt} FillMeInIfNeeded end
% fun {Assign V Expr} FillMeInIfNeeded end
% fun {Sequence Substmt1 Substmt2} FillMeInIfNeeded end
% fun {If Cond ThenStmt ElseStmt} FillMeInIfNeeded end
% fun {While Cond DoStmt} FillMeInIfNeeded end



%---------------------------------------------------------------------
% BEGIN Testing
%
% Instructions: these tests can be run by feeding the buffer
% to the virtual machine.
% Results are to be visually verified (ensure it's the right output).
%---------------------------------------------------------------------

% This test assigns the variable returned by VarX to be 0.
Stmt1 = {Assign {VarX} {Const 0}}
%                   x ≔ 0

% Interpreting a statement should return a state;
% this should be a function.
TestState1 = {Interpret Stmt1 XYEnv EmptyState}

% Check the value at that variable to ensure it's 0.
{Browse {TestState1 {VarX}}}



% This statement increments VarX by one.
% It (probably) can't be interpreted as is, because VarX is not assigned to.
% Probably meaning I'd expect a type clash,
% but it will depend upon your implementation.
Stmt2 = {Assign {VarX} {Plus {VarI {VarX}} {Const 1}}}
%                   x ≔               x  +  1



% We can compose Stmt1 and Stmt2 to get a good program
Stmt3 = {Sequence Stmt1 Stmt2}
TestState2 = {Interpret Stmt3 XYEnv EmptyState}
{Browse TestState2}



% We can also use Stmt1 and Stmt2 to construct a while loop,
% incrementing VarX 10 times.
Stmt4 = {Sequence Stmt1 {While {Less {VarI {VarX}} {Const 10}} Stmt2}}
%              x ≔ 0 ;  while               (x < 10)   do    x ≔ x + 1

TestState3 = {Interpret Stmt3 XYEnv EmptyState}
{Browse {TestState3 {VarX}}}

%---------------------------------------------------------------------
% END Testing
%---------------------------------------------------------------------
