open import Data.Nat using (ℕ ; zero ; suc ; _+_ ; _*_)
open import Data.Bool using (Bool ; true ; false)
open import Relation.Binary.PropositionalEquality
  using (_≡_)
  renaming (refl to ByReflexivity)

{- Exercise 1 ----------------------------------------------

Complete the definitions of the following simple
functions on the naturals.

You will want to split the definitions into cases
using pattern matching.

place your cursor in the hole in each definition
and press c-c c-c (control + c and then control + c),
and then enter an argument name
(e.g. n) to have this splitting done automatically.

after splitting, place your cursor into a hole
and press c-c c-, to see what type of expression
is needed to fill the hole (for these functions,
all the holes should require a ℕ expression),
along with what names are in the local context
along with their types. type an expression of type ℕ
in the hole, and then press c-c c-space to fill
the hole with that expression.

once you complete the definitions by filling in the holes,
you can test your code by *normalising* some simple expressions
such as `factorial 5` (which should normalise to 120). press
c-c c-n, then type the expression to normalise into the prompt.

(Side note: the numeric literal `0` can be used in place of `zero`
if you wish, and `1` can be used in place of `suc zero`).
-}

factorial : ℕ → ℕ
factorial zero = suc zero
factorial (suc n) = (suc n) * (factorial n) 

exponent : ℕ → ℕ → ℕ
exponent m zero = suc zero
exponent m (suc n) = m * exponent m n

-- END Exercise 1 ------------------------------------------

{- Exercise 2 ----------------------------------------------

Define the factorial and exponent functions yet again,
but this time using a postfix and infix name,
taking advantage of Agda's lenient name requirements.

You might also try out the commands C-c C-f,
which moves the cursor to the next hole, and C-c C-a,
which tries to automatically fill a hole
(it won't fill it correctly here, since the system doesn't
know what you're intended to define,
but this can be useful in some cases).
-}

_! : ℕ → ℕ
zero ! = suc zero
suc n ! = suc n * (n !)

_^_ : ℕ → ℕ → ℕ
m ^ zero = suc zero
m ^ suc n = m * (m ^ n)

-- END Exercise 2 ------------------------------------------

{- Exercise 3 ----------------------------------------------

Complete the below definitions for simple boolean operators.

You can find definitions for these in Data.Bool from the
standard library (which we import Bool, true and false
from above), but try
to complete them yourself. You may want to look at the more
general if-then-else function in the standard library once you
complete yours.

The logical and/or symbols are unicode characters, entered in
Emacs by typing \and and \or respectively.

Notice that this time we have left holes in the types for you
to fill in; holes can appear in both the type signature and the
definition of functions!

Also notice we haven't filled in argument names in the definitions;
if you case split in the holes (by pressing C-c C-c) and just press
Enter/Return, it will ``split on result'' and fill in argument names
for you (this will often result in less useful names, though).
-}

_∧_ : Bool → Bool → Bool
false ∧ x₁ = false
true ∧ x₁ = x₁

_∨_ : Bool → Bool → Bool
false ∨ x₁ = x₁
true ∨ x₁ = true

-- Natural number valued if-then-else
if_then_else_ : Bool → ℕ → ℕ → ℕ
if false then x₁ else x₂ = x₂
if true then x₁ else x₂ = x₁

-- END Exercise 3 ------------------------------------------

{- Exercise 4 ----------------------------------------------

We can perform some tests by normalising terms (C-c C-n),
or we can use the equality type former, _≡_.

Complete these tests by trying to fill the holes with
ByReflexivity (the only element of the equality type).

If everything is defined correctly above,
you should be able to fill these holes with auto
(C-c C-a), since there is only one possible value.

If you cannot fill the holes, it means something is
not defined correctly above.

(We use _ as the name of these tests, which leaves
them anonymous (unnamed), because we never need
to actually call them, just typecheck them).
-}

_ : factorial 5 ≡ 120
_ = ByReflexivity

_ : exponent 5 2 ≡ 25
_ = ByReflexivity

_ : 5 ! ≡ 120
_ = ByReflexivity

_ : 5 ^ 2 ≡ 25
_ = ByReflexivity

_ : true ∧ false ≡ false
_ = ByReflexivity

_ : true ∨ false ≡ true
_ = ByReflexivity

_ : if false then 5 else 4 ≡ 4
_ = ByReflexivity

-- Exercise 4 ----------------------------------------------
