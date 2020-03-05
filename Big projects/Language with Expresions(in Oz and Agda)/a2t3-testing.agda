open import zhany111
module test where
module WellTypedTesting where
  open NaivePrograms renaming (Stmt to NaiveStmt ; Expr to testE ; IExpr to TestI ; BExpr to TestB) public
  open WellTypedPrograms public

  data Maybe (A : Set) : Set where
    just : A → Maybe A
    nothing : Maybe A

  isJust : {A : Set} → Maybe A → Set
  isJust (just _) = Truth
  isJust nothing = Falsehood



  extract : {A : Set} → (m : Maybe A) → (_ : isJust m) → A
  extract (just e) _ = e

  -- The definition of ¬ given in the assignment is flawed;
  -- the tests use this instead.
  not : Set → Set
  not A = A → Falsehood


  --The function that changes Expr, BExpr, IExpr to my well typed one
  mutual
    _changeE : testE → Expr
    (x₁ :Bool) changeE = x₁ changeB :Bool
    (x₁ :Int) changeE = (x₁ changeI) :Int

  

    _changeI : TestI → IExpr
    const x₁ changeI = const x₁
    varᴵ x₁ changeI = varᴵ x₁
    (x₁ + x₂) changeI = (x₁ changeI) + (x₂ changeI)
    (x₁ - x₂) changeI = (x₁ changeI) - (x₂ changeI)
    (x₁ * x₂) changeI = (x₁ changeI) * (x₂ changeI)
    (x₁ div x₂) changeI = (x₁ changeI) div (x₂ changeI)
    (x₁ mod x₂) changeI = (x₁ changeI) mod (x₂ changeI)
  
    _changeB : TestB → BExpr
    true changeB = true
    false changeB = false
    varᴮ x₁ changeB = varᴮ x₁
    ((x₁) == (x₂)) changeB = (x₁ changeE) == (x₂ changeE)
    (x₁ \= x₂) changeB = (x₁ changeE) == (x₂ changeE)
    (x₁ =< x₂) changeB = (x₁ changeI) =< (x₂ changeI)
    (x₁ < x₂) changeB = (x₁ changeI) < (x₂ changeI)
    (x₁ >= x₂) changeB = (x₁ changeI) >= (x₂ changeI)
    (x₁ > x₂) changeB = (x₁ changeI) > (x₂ changeI)
  
  
  -- Translate from the old, naive type to your new one.
  translate : NaiveStmt → Maybe Stmt
  translate skip = just skip
  translate localInt var In S end with translate S
  …                                  | nothing = nothing
  …                                  | just S' = just Stmt.localInt var In S' end
  translate localBool var In S end with translate S
  …                                  | nothing = nothing
  …                                  | just S' = just Stmt.localBool var In S' end
  translate (var ≔ᴮ (E :Bool)) = just (var ≔ᴮ (E changeB))
  translate (var ≔ᴮ (E :Int)) = nothing   -- Type error
  translate (var ≔ᴵ (E :Bool)) = nothing  -- Type error
  translate (var ≔ᴵ (E :Int)) = just ((var ≔ᴵ (E changeI)))
  translate (S₁ ⨾ S₂) with (translate S₁) 
  …                                  | (nothing) = nothing
  …                                  | (just S₁') with (translate S₂)
  …                                                               | nothing = nothing
  …                                                               | (just S₂') = just (S₁' ⨾ S₂')
  
  translate if E :Bool then S₁ else S₂ end with (translate S₁) 
  …                                  | (nothing) = nothing
  …                                  | (just S₁') with (translate S₂)
  …                                                               | nothing = nothing
  …                                                               | (just S₂') = just (if (E changeB) then S₁' else S₂' end)
  translate if E :Int then S₁ else S₂ end = nothing  -- Type error
  translate while E :Bool Do S end with (translate S) 
  …                                  | (nothing) = nothing
  …                                  | (just S') = just( while (E changeB) Do S' end)
  translate while E :Int Do S end = nothing  -- Type error

----------------------------------------------------------------------
-- BEGIN Testing
--
-- Instructions: you should try to fill in the holes below
-- to make sure your predicate is correct.
--
-- In fact, all of these holes should be fillable using auto
-- (C-c C-a).
--
-- You MAY also add additional tests if your wish,
-- but note that this section will be replaced with
-- a more robust test suite during marking, so your modifications
-- will not be used.
----------------------------------------------------------------------

module ScopeTesting where
  open WellTypedTesting
  open WellScoped

  test₁ : (extract (translate skip) witness) WellScoped
  test₁ = ∧-intro witness witness

  test₂ : let S = localInt x In
                    x ≔ᴵ (const (pos zero) :Int)
                  end
         in
         (extract (translate S) witness) WellScoped
  test₂ = ∧-intro (∧-intro (∨-intro-l ByReflexivity) witness) witness

  test₃ : let S = localInt x In
                    if varᴵ x < const (pos (suc (suc zero))) :Bool
                      then localInt y In skip end
                      else localInt z In skip end
                    end
                  end
         in
         (extract (translate S) witness) WellScoped
  test₃ = ∧-intro
            (∧-intro (∨-intro-l ByReflexivity)
             (∧-intro
              (∧-intro (∧-intro (∨-intro-l ByReflexivity) witness)
               (∧-intro (∨-intro-l ByReflexivity) witness))
              (∧-intro (∨-intro-l ByReflexivity) witness)))
            (∧-intro witness (∧-intro witness witness))

  -- case split on bad until you reach a (); then you're done.
  test₄ : let S = x ≔ᴵ (const (pos zero) :Int)
         in
         not ((extract (translate S) witness) WellScoped)
  test₄ (∧-intro witness witness) = {!!}



module InitialisationTesting where
  open WellTypedTesting
  open WellInitialised

  -- Make sure your type is named _WellInitialised

  test₁ : (extract (translate skip) witness) WellInitialised
  test₁ = ∧-intro witness witness

  test₂ : let S = localInt x In
                    x ≔ᴵ (const (pos zero) :Int)
                  end
         in
         (extract (translate S) witness) WellInitialised
  test₂ = ∧-intro (∨-intro-l ByReflexivity) witness

  -- This is well-scoped, but not well-initialised, as we use x
  -- before assigning to it.
  -- Case split on bad here until you reach ().
  test₃ : let S = localInt x In
                    if varᴵ x < const (pos (suc (suc zero))) :Bool
                      then localInt y In skip end
                      else localInt z In skip end
                    end
                  end
         in
         not ((extract (translate S) witness) WellInitialised)
  test₃ (∧-intro (∧-intro P-proof Q-proof₁) (∧-intro P-proof₁ Q-proof)) = {!!}

  -- This is not well-scoped, but is well-initialised.
  test₄ : let S = x ≔ᴵ (const (pos zero) :Int)
         in
         (extract (translate S) witness) WellInitialised
  test₄ = ∧-intro (∨-intro-l ByReflexivity) witness

  -- similar to test₄, this is well-initialised, though not well-scoped
  test₅ : let S = x ≔ᴵ (const (pos zero) :Int) ⨾
                 x ≔ᴵ ((varᴵ x + const (pos (suc zero))) :Int)
         in
         (extract (translate S) witness) WellInitialised
  test₅ = ∧-intro
            (∧-intro (∨-intro-l ByReflexivity) (∨-intro-l ByReflexivity))
            (∧-intro witness witness)

----------------------------------------------------------------------
-- END Testing
----------------------------------------------------------------------
