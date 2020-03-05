//--------------------------------------------------------------------
// Assignment 1, Task 4, Part 2
// Testing script
//
// Instructions: this testing script is provided to help ensure
// your program meets the expectations of the assignment.
//
// It will be run with the command
//   fsharpc IExpr_with_subst.fs a1t4p2-testing.fs; mono a1t4p2-testing.exe
// Notice the command references file IExpr_with_subst.fs;
// your code for that part must be in that file,
// and that file must define a module of the same name.
//
// Complete the interface below as instructed,
// and then run and ensure your program passes the provided tests.
//--------------------------------------------------------------------
module Interface

open IExpr_with_subst
// Your file must define this module

//--------------------------------------------------------------------
// BEGIN Interface
//
// Instructions: replace instances of () with appropriate instances
// of your IExpr type.
// DO NOT modify any other aspects of these functions.
//--------------------------------------------------------------------
let mkConst i     = IExpr().Const(i)
let mkNeg   e     = neg(e)
let mkAbs   e     = abs(e)
let mkPlus  e1 e2 = plus(e1, e2)
let mkTimes e1 e2 = times(e1, e2)
let mkMinus e1 e2 = minus(e1, e2)
let mkExp   e1 e2 = exp(e1, e2) 
let mkIdent s       = IExpr().Ident(s)
let mkSubst s e1 e2 = subst(s, e1, e2)
//--------------------------------------------------------------------
// END Interface
//--------------------------------------------------------------------

//--------------------------------------------------------------------
// BEGIN Testing
//
// Instructions: you should use these tests to make certain your
// interpretation method(s) is (are) working as expected.
// You MAY also add additional tests if you wish,
// but note that this section will be replaced with
// a more robust test suite during marking, so your modifications
// will not be used.
//--------------------------------------------------------------------

// Note that you will get errors about the calles to interpret below
// if you try to compile this file before correcting the interface functions.

// Construct some expressions for testing
try
  let two = mkConst 2
  let five = mkConst 5
  let neg_five = mkNeg five
  let plus_neg_five_two = mkPlus neg_five two
  let x = mkIdent "x" // interpreting this should fail
  let subst_x_five_x = mkSubst "x" five x
  printfn "All expressions constructed without exception."

  // Test interpretation on the constructed expressions
  try
      let mutable failed = 0
      if (int)(interpret(two)) <> 2 then
          printfn "two was not 2!"
          failed <- failed + 1
      if (int)(interpret(five)) <> 5 then
          printfn "five was not 5!"
          failed <- failed + 1
      if (int)(interpret(neg_five)) <> -5 then
          printfn "neg 5 was not -5"
          failed <- failed + 1
      if (int)(interpret(plus_neg_five_two)) <> -5 + 2 then
          printfn "plus neg 5 2 was not -3"
          failed <- failed + 1
      if (int)(interpret(subst_x_five_x)) <> 5 then
          printfn "subst x 5 x was not 5"
          failed <- failed + 1
      if failed > 0 then
        printfn "%d interpretation tests failed" failed
      else
        printfn "All interpretation tests passed"
  with
  | _ as e -> printfn "Exception “%A” during interpretation." e
with
| _ as e -> printfn "Exception “%A” during expression construction." e
//---------------------------------------------------------------------
// END Testing
//---------------------------------------------------------------------