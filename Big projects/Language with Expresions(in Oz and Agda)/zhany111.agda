module zhany111 where

data Truth : Set where
  witness : Truth

data Falsehood : Set where
  -- There's no proof of falsehood, so no constructors

data _∧_ : (P Q : Set) → Set where
  ∧-intro : {P Q : Set} → (P-proof : P) → (Q-proof : Q) → P ∧ Q

data _∨_ : (P Q : Set) → Set where
  ∨-intro-l : {P Q : Set} → (P-proof : P) → P ∨ Q
  ∨-intro-r : {P Q : Set} → (Q-proof : Q) → P ∨ Q

¬ : Set → Set 
¬ P = P → Falsehood

infix 101 _≡_

-- For any type A, all elements a of A are equal to themselves.
-- No other two things are equal.
data _≡_ {A : Set} : A → A → Set where
  ByReflexivity : {a : A} → a ≡ a

data Varᴵ : Set where
  i j k x y z : Varᴵ
  _′ : Varᴵ → Varᴵ

data Varᴮ : Set where
  a b c : Varᴮ
  _′ : Varᴮ → Varᴮ

data ℕ : Set where
  zero : ℕ
  suc : ℕ → ℕ

data ℕ⁺ : Set where
  one : ℕ⁺
  suc⁺ : ℕ⁺ → ℕ⁺

data ℤ : Set where
  pos : ℕ → ℤ
  neg : ℕ⁺ → ℤ

module NaivePrograms where

  infix 100 varᴵ varᴮ const
  infix 90 _*_ _div_ _mod_
  infix 85 _+_ _-_
  infix 80 _=<_ _<_ _>=_ _>_
  infix 75 _\=_
  infix 70 _==_
  infix 65 _≔ᴵ_ _≔ᴮ_
  infix 60 _⨾_

  data Expr : Set

  data BExpr : Set

  data IExpr : Set

  data Expr where
    _:Bool : BExpr → Expr
    _:Int : IExpr → Expr

  data BExpr where
    true false : BExpr
    varᴮ : Varᴮ → BExpr
    _==_ _\=_ : Expr → Expr → BExpr
    _=<_ _<_ _>=_ _>_ : IExpr → IExpr → BExpr

  data IExpr where
    const : ℤ → IExpr
    varᴵ : Varᴵ → IExpr
    _+_ _-_ _*_ _div_ _mod_ : IExpr → IExpr → IExpr

  data Stmt : Set where
    skip : Stmt
    localInt_In_end : Varᴵ → Stmt → Stmt
    localBool_In_end : Varᴮ → Stmt → Stmt
    _≔ᴮ_ : Varᴮ → Expr → Stmt
    _≔ᴵ_ : Varᴵ → Expr → Stmt
    _⨾_ : Stmt → Stmt → Stmt
    if_then_else_end : Expr → Stmt → Stmt → Stmt
    while_Do_end : Expr → Stmt → Stmt

  _ : Stmt
  _ = skip

  _ : Stmt
  _ = if false :Bool then skip else skip end

  -- Note: the spacing below is only for readability
  _ : Stmt
  _ = localInt x In
        x ≔ᴵ (const (pos zero) :Int) ⨾
        while (varᴵ x < const (pos (suc (suc (suc zero)))) :Bool) Do
          x ≔ᴵ (varᴵ x + const (pos (suc zero)) :Int)
        end
      end

  -- Type error; assigning a boolean to an integer variable.
  -- Also a scope error; x is not declared.
  _ : Stmt
  _ = x ≔ᴵ (true :Bool)

  -- Type error; using an integer as an if condition
  _ : Stmt
  _ = if (const (pos zero) :Int) then skip else skip end

  -- Variable used before initialisation
  _ : Stmt
  _ = localBool b In
        if (varᴮ b :Bool) then skip else skip end
      end

module WellTypedPrograms where
  infix 100 varᴵ varᴮ const
  infix 90 _*_ _div_ _mod_
  infix 85 _+_ _-_
  infix 80 _=<_ _<_ _>=_ _>_
  infix 75 _\=_
  infix 70 _==_
  infix 65 _≔ᴵ_ _≔ᴮ_
  infix 60 _⨾_

  data Expr : Set

  data BExpr : Set

  data IExpr : Set

  data Expr where
    _:Bool : BExpr → Expr
    _:Int : IExpr → Expr

  data BExpr where
    true false : BExpr
    varᴮ : Varᴮ → BExpr
    _==_ _\=_ : Expr → Expr → BExpr
    _=<_ _<_ _>=_ _>_ : IExpr → IExpr → BExpr

  data IExpr where
    const : ℤ → IExpr
    varᴵ : Varᴵ → IExpr
    _+_ _-_ _*_ _div_ _mod_ : IExpr → IExpr → IExpr

  data Stmt : Set where
    skip : Stmt
    localInt_In_end : Varᴵ → Stmt → Stmt
    localBool_In_end : Varᴮ → Stmt → Stmt
    _≔ᴮ_ : Varᴮ → BExpr → Stmt
    _≔ᴵ_ : Varᴵ → IExpr → Stmt
    _⨾_ : Stmt → Stmt → Stmt
    if_then_else_end : BExpr → Stmt → Stmt → Stmt
    while_Do_end : BExpr → Stmt → Stmt

  _ : Stmt
  _ = skip

  _ : Stmt
  _ = if true then skip else skip end

  -- Only IExpr can be assigned to variables now
  -- Only BExpr can be as an while condition
  _ : Stmt
  _ = localInt x In
        x ≔ᴵ (const (pos zero) ) ⨾
        while ( (const (pos zero)) < const (pos (suc (suc (suc zero))))) Do
          x ≔ᴵ ( (const (pos zero)) + const (pos (suc zero)))
        end
      end

  -- Now only int value can be assigned to an integer variable.
  -- Still a scope error that x is not declared.
  _ : Stmt
  _ = x ≔ᴵ (const( pos(zero)))

  -- now only BExpr can be as an if condition
  _ : Stmt
  _ = if true then skip else skip end

  -- Initialize error: Variable used before initialisation
  _ : Stmt
  _ = localBool b In
        if true then skip else skip end
      end

module WellScoped where
  -- Bring your datatypes from part 1 into scope
  open WellTypedPrograms
  
  -- Scopes for integer variables
  Scopeᴵ : Set₁
  Scopeᴵ = (v : Varᴵ) → Set

  -- The empty scope is false for every variable
  EmptyScopeᴵ : Scopeᴵ
  EmptyScopeᴵ v = Falsehood

  -- Adding a variable to a scope
  -- “Add v ToScopeᴵ S” is a new predicate on variables
  Add_ToScopeᴵ_ : Varᴵ → Scopeᴵ → Scopeᴵ
  (Add v ToScopeᴵ S) w = (v ≡ w) ∨ S w
  -- And we define the same concepts for boolean variables

  Scopeᴮ : Set₁
  Scopeᴮ = (v : Varᴮ) → Set

  -- The empty scope is false for every variable
  EmptyScopeᴮ : Scopeᴮ
  EmptyScopeᴮ v = Falsehood

  -- Adding a variable to a scope
  -- “Add v ToScopeᴵ S” is a new predicate on variables
  Add_ToScopeᴮ_ : Varᴮ → Scopeᴮ → Scopeᴮ
  (Add v ToScopeᴮ S) w = (v ≡ w) ∨ S w

  mutual
    --Special function to check scope for IExpr in the case of: (IExpr ∘ IExpr → BExpr), where ∘ is (==, /=, <, <=...)
    --We have to define a new function for this because we are checking int from a bool scope
    _IntoSpecial_ : BExpr → Scopeᴵ → Set
    true IntoSpecial x₂ = Truth
    false IntoSpecial x₂ = Truth
    varᴮ x₁ IntoSpecial x₂ = Truth
    ((x₁ :Bool) == (x₃ :Bool)) IntoSpecial x₂ = Truth
    ((x₁ :Bool) == (x₃ :Int)) IntoSpecial x₂ = Truth
    ((x₁ :Int) == (x₃ :Bool)) IntoSpecial x₂ = Truth
    ((x₁ :Int) == (x₃ :Int)) IntoSpecial x₂ = (x₁ IntoIExpr x₂) ∧ (x₃ IntoIExpr x₂)
    ((x₁ :Bool) \= (x₃ :Bool)) IntoSpecial x₂ = Truth
    ((x₁ :Bool) \= (x₃ :Int)) IntoSpecial x₂ = Truth
    ((x₁ :Int) \= (x₃ :Bool)) IntoSpecial x₂ = Truth
    ((x₁ :Int) \= (x₃ :Int)) IntoSpecial x₂ = (x₁ IntoIExpr x₂) ∧ (x₃ IntoIExpr x₂)
    (x₁ =< x₃) IntoSpecial x₂ = (x₁ IntoIExpr x₂) ∧ (x₃ IntoIExpr x₂)
    (x₁ < x₃) IntoSpecial x₂ = (x₁ IntoIExpr x₂) ∧ (x₃ IntoIExpr x₂)
    (x₁ >= x₃) IntoSpecial x₂ = (x₁ IntoIExpr x₂) ∧ (x₃ IntoIExpr x₂)
    (x₁ > x₃) IntoSpecial x₂ = (x₁ IntoIExpr x₂) ∧ (x₃ IntoIExpr x₂)

    --Function that check if the variables in IExpr are in Scopeᴵ
    _IntoIExpr_ : IExpr → Scopeᴵ → Set
    const x₁ IntoIExpr x₂ = Truth
    varᴵ x₁ IntoIExpr x₂ = (Add x₁ ToScopeᴵ x₂) x₁
    (x₁ + x₃) IntoIExpr x₂ = (x₁ IntoIExpr x₂) ∧ (x₃ IntoIExpr x₂)
    (x₁ - x₃) IntoIExpr x₂ = (x₁ IntoIExpr x₂) ∧ (x₃ IntoIExpr x₂)
    (x₁ * x₃) IntoIExpr x₂ = (x₁ IntoIExpr x₂) ∧ (x₃ IntoIExpr x₂)
    (x₁ div x₃) IntoIExpr x₂ = (x₁ IntoIExpr x₂) ∧ (x₃ IntoIExpr x₂)
    (x₁ mod x₃) IntoIExpr x₂ = (x₁ IntoIExpr x₂) ∧ (x₃ IntoIExpr x₂)

    --Function that check if the variables in BExpr are in Scopeᴮ
  
    _IntoBExpr_ : BExpr → Scopeᴮ → Set
    true IntoBExpr x₂ = Truth
    false IntoBExpr x₂ = Truth
    varᴮ x₁ IntoBExpr x₂ = (Add x₁ ToScopeᴮ x₂) x₁
    ((x₁ :Bool) == (x₃ :Bool)) IntoBExpr x₂ = (x₁ IntoBExpr x₂) ∧ (x₃ IntoBExpr x₂)
    ((x₁ :Int) == (x₃ :Int)) IntoBExpr x₂ = Truth
    ((x₁ :Bool) \= (x₃ :Bool)) IntoBExpr x₂ = (x₁ IntoBExpr x₂) ∧ (x₃ IntoBExpr x₂)
    ((x₁ :Int) \= (x₃ :Int)) IntoBExpr x₂ = Truth
    ((x₂ :Bool) == (x₃ :Int)) IntoBExpr x₁ = Falsehood
    ((x₂ :Int) == (x₃ :Bool)) IntoBExpr x₁ = Falsehood
    ((x₂ :Bool) \= (x₃ :Int)) IntoBExpr x₁ = Falsehood
    ((x₂ :Int) \= (x₃ :Bool)) IntoBExpr x₁ = Falsehood
    (x₁ =< x₃) IntoBExpr x₂ = Truth
    (x₁ < x₃) IntoBExpr x₂ = Truth
    (x₁ >= x₃) IntoBExpr x₂ = Truth
    (x₁ > x₃) IntoBExpr x₂ = Truth

  --Check if the variables from statements are in Scopeᴵ 
  _WithinScopeᴵ_ : Stmt → Scopeᴵ → Set
  skip WithinScopeᴵ x₂ = Truth
  localInt x₁ In x₃ end WithinScopeᴵ x₂ = (Add x₁ ToScopeᴵ x₂) x₁ ∧ (x₃ WithinScopeᴵ x₂) 
  localBool x₁ In x₃ end WithinScopeᴵ x₂ = x₃ WithinScopeᴵ x₂
  (x₁ ≔ᴮ x₃) WithinScopeᴵ x₂ = Truth
  (x₁ ≔ᴵ x₃) WithinScopeᴵ x₂ = (x₃ IntoIExpr x₂)
  (x₁ ⨾ x₃) WithinScopeᴵ x₂ = (x₃ WithinScopeᴵ x₂) ∧ (x₁ WithinScopeᴵ x₂)
  if x₁ then x₃ else x₄ end WithinScopeᴵ x₂ = ((x₃ WithinScopeᴵ x₂) ∧ (x₄ WithinScopeᴵ x₂)) ∧ (x₁ IntoSpecial x₂)
  while x₁ Do x₃ end WithinScopeᴵ x₂ = (x₃ WithinScopeᴵ x₂) ∧ (x₁ IntoSpecial x₂)

  --Check if Variables from Statements are in Scopeᴮ
  _WithinScopeᴮ_ : Stmt → Scopeᴮ → Set
  skip WithinScopeᴮ x₂ = Truth 
  localInt x₁ In x₃ end WithinScopeᴮ x₂ = (x₃ WithinScopeᴮ x₂) 
  localBool x₁ In x₃ end WithinScopeᴮ x₂ = (Add x₁ ToScopeᴮ x₂) x₁ ∧ (x₃ WithinScopeᴮ x₂)
  (x₁ ≔ᴮ x₃) WithinScopeᴮ x₂ = (x₃ IntoBExpr x₂)
  (x₁ ≔ᴵ x₃) WithinScopeᴮ x₂ = Truth
  (x₁ ⨾ x₃) WithinScopeᴮ x₂ = (x₃ WithinScopeᴮ x₂) ∧ (x₁ WithinScopeᴮ x₂)
  if x₁ then x₃ else x₄ end WithinScopeᴮ x₂ = (x₁ IntoBExpr x₂) ∧ ((x₄ WithinScopeᴮ x₂) ∧ (x₃ WithinScopeᴮ x₂))
  while x₁ Do x₃ end WithinScopeᴮ x₂ = (x₁ IntoBExpr x₂) ∧ (x₃ WithinScopeᴮ x₂)

  _WellScoped : Stmt → Set
  x₁ WellScoped = (x₁ WithinScopeᴵ EmptyScopeᴵ) ∧ (x₁ WithinScopeᴮ EmptyScopeᴮ)



module WellInitialised where
  -- Bring your datatypes from part 1 into scope
  open WellTypedPrograms
  
  -- Initial for integer variables
  Initialᴵ : Set₁
  Initialᴵ = (v : Varᴵ) → Set

  -- The empty Initial is false for every variable
  EmptyInitialᴵ : Initialᴵ
  EmptyInitialᴵ v = Falsehood

  -- Adding a variable to a scope
  -- “Add v ToInitialᴵ S” is a new predicate on variables
  Add_ToInitialᴵ_ : Varᴵ → Initialᴵ → Initialᴵ
  (Add v ToInitialᴵ S) w = (v ≡ w) ∨ S w
  
  -- And we define the same concepts for boolean variables
  Initialᴮ : Set₁
  Initialᴮ = (v : Varᴮ) → Set

  -- The empty scope is false for every variable
  EmptyInitialᴮ : Initialᴮ
  EmptyInitialᴮ v = Falsehood

  -- Adding a variable to a Initial
  -- “Add v ToInitialᴵ S” is a new predicate on variables
  Add_ToInitialᴮ_ : Varᴮ → Initialᴮ → Initialᴮ
  (Add v ToInitialᴮ S) w = (v ≡ w) ∨ S w

  --Same as the scope check, we need to go into different Expr
  --We first go into special case because some of the IExpr are
  --checked in Initialᴵ
  mutual
    --Special function to check Initial for IExpr in the case of: (IExpr ∘ IExpr → BExpr), where ∘ is (==, /=, <, <=...)
    --We have to define a new function for this because we are checking int from a bool expression
    _IIntoSpecial_ : BExpr → Initialᴵ → Set
    true IIntoSpecial x₂ = Truth
    false IIntoSpecial x₂ = Truth
    varᴮ x₁ IIntoSpecial x₂ = Truth
    ((x₁ :Bool) == (x₃ :Bool)) IIntoSpecial x₂ = Truth
    ((x₁ :Bool) == (x₃ :Int)) IIntoSpecial x₂ = Truth
    ((x₁ :Int) == (x₃ :Bool)) IIntoSpecial x₂ = Truth
    ((x₁ :Int) == (x₃ :Int)) IIntoSpecial x₂ = (x₁ IIntoIExpr x₂) ∧ (x₃ IIntoIExpr x₂)
    ((x₁ :Bool) \= (x₃ :Bool)) IIntoSpecial x₂ = Truth
    ((x₁ :Bool) \= (x₃ :Int)) IIntoSpecial x₂ = Truth
    ((x₁ :Int) \= (x₃ :Bool)) IIntoSpecial x₂ = Truth
    ((x₁ :Int) \= (x₃ :Int)) IIntoSpecial x₂ = (x₁ IIntoIExpr x₂) ∧ (x₃ IIntoIExpr x₂)
    (x₁ =< x₃) IIntoSpecial x₂ = (x₁ IIntoIExpr x₂) ∧ (x₃ IIntoIExpr x₂)
    (x₁ < x₃) IIntoSpecial x₂ = (x₁ IIntoIExpr x₂) ∧ (x₃ IIntoIExpr x₂)
    (x₁ >= x₃) IIntoSpecial x₂ = (x₁ IIntoIExpr x₂) ∧ (x₃ IIntoIExpr x₂)
    (x₁ > x₃) IIntoSpecial x₂ = (x₁ IIntoIExpr x₂) ∧ (x₃ IIntoIExpr x₂)

    --Function that check if the variables in IExpr are in Initialᴵ
    _IIntoIExpr_ : IExpr → Initialᴵ → Set
    const x₁ IIntoIExpr x₂ = Truth
    varᴵ x₁ IIntoIExpr x₂ = (Add x₁ ToInitialᴵ x₂) x₁
    (x₁ + x₃) IIntoIExpr x₂ = (x₁ IIntoIExpr x₂) ∧ (x₃ IIntoIExpr x₂)
    (x₁ - x₃) IIntoIExpr x₂ = (x₁ IIntoIExpr x₂) ∧ (x₃ IIntoIExpr x₂)
    (x₁ * x₃) IIntoIExpr x₂ = (x₁ IIntoIExpr x₂) ∧ (x₃ IIntoIExpr x₂)
    (x₁ div x₃) IIntoIExpr x₂ = (x₁ IIntoIExpr x₂) ∧ (x₃ IIntoIExpr x₂)
    (x₁ mod x₃) IIntoIExpr x₂ = (x₁ IIntoIExpr x₂) ∧ (x₃ IIntoIExpr x₂)

    --Function that check if the variables in BExpr are in Initialᴮ
  
    _IIntoBExpr_ : BExpr → Initialᴮ → Set
    true IIntoBExpr x₂ = Truth
    false IIntoBExpr x₂ = Truth
    varᴮ x₁ IIntoBExpr x₂ = (Add x₁ ToInitialᴮ x₂) x₁
    ((x₁ :Bool) == (x₃ :Bool)) IIntoBExpr x₂ = (x₁ IIntoBExpr x₂) ∧ (x₃ IIntoBExpr x₂)
    ((x₁ :Int) == (x₃ :Int)) IIntoBExpr x₂ = Truth
    ((x₁ :Bool) \= (x₃ :Bool)) IIntoBExpr x₂ = (x₁ IIntoBExpr x₂) ∧ (x₃ IIntoBExpr x₂)
    ((x₁ :Int) \= (x₃ :Int)) IIntoBExpr x₂ = Truth
    ((x₂ :Bool) == (x₃ :Int)) IIntoBExpr x₁ = Falsehood
    ((x₂ :Int) == (x₃ :Bool)) IIntoBExpr x₁ = Falsehood
    ((x₂ :Bool) \= (x₃ :Int)) IIntoBExpr x₁ = Falsehood
    ((x₂ :Int) \= (x₃ :Bool)) IIntoBExpr x₁ = Falsehood
    (x₁ =< x₃) IIntoBExpr x₂ = Truth
    (x₁ < x₃) IIntoBExpr x₂ = Truth
    (x₁ >= x₃) IIntoBExpr x₂ = Truth
    (x₁ > x₃) IIntoBExpr x₂ = Truth

  --Only add new item to the Initialᴵ when there is ≔ᴵ operation
  _WithinInitialᴵ_ : Stmt → Initialᴵ → Set
  skip WithinInitialᴵ x₂ = Truth
  localInt x₁ In x₃ end WithinInitialᴵ x₂ =  (x₃ WithinInitialᴵ x₂)
  localBool x₁ In x₃ end WithinInitialᴵ x₂ = x₃ WithinInitialᴵ x₂
  (x₁ ≔ᴮ x₃) WithinInitialᴵ x₂ = Truth
  (x₁ ≔ᴵ x₃) WithinInitialᴵ x₂ = (Add x₁ ToInitialᴵ x₂) x₁
  (x₁ ⨾ x₃) WithinInitialᴵ x₂ = (x₃ WithinInitialᴵ x₂) ∧ (x₁ WithinInitialᴵ x₂)
  if x₁ then x₃ else x₄ end WithinInitialᴵ x₂ = (x₄ WithinInitialᴵ x₂) ∧( (x₃ WithinInitialᴵ x₂) ∧ (x₁ IIntoSpecial x₂))
  while x₁ Do x₃ end WithinInitialᴵ x₂ = (x₃ WithinInitialᴵ x₂) ∧ ((x₁ IIntoSpecial x₂))

  --Only add new item to the Initialᴮ when there are ≔ᴵ or ≔ᴮ operation, since
  --sometimes we need to check if IExpr is in Initialᴮ
  _WithinInitialᴮ_ : Stmt → Initialᴮ → Set
  skip WithinInitialᴮ x₂ = Truth
  localInt x₁ In x₃ end WithinInitialᴮ x₂ = x₃ WithinInitialᴮ x₂
  localBool x₁ In x₃ end WithinInitialᴮ x₂ =  (x₃ WithinInitialᴮ x₂)
  (x₁ ≔ᴮ x₃) WithinInitialᴮ x₂ = (Add x₁ ToInitialᴮ x₂) x₁
  (x₁ ≔ᴵ x₃) WithinInitialᴮ x₂ = Truth
  (x₁ ⨾ x₃) WithinInitialᴮ x₂ = (x₃ WithinInitialᴮ x₂) ∧ (x₁ WithinInitialᴮ x₂)
  if x₁ then x₃ else x₄ end WithinInitialᴮ x₂ = ((x₃ WithinInitialᴮ x₂) ∧ (x₄ WithinInitialᴮ x₂))
  while x₁ Do x₃ end WithinInitialᴮ x₂ = x₃ WithinInitialᴮ x₂

  _WellInitialised : Stmt → Set
  I WellInitialised = (I WithinInitialᴵ EmptyInitialᴵ) ∧ (I WithinInitialᴮ EmptyInitialᴮ)




module Correct where
  open WellTypedPrograms
  open WellScoped

  Stateᴵ : Set
  Stateᴵ = Varᴵ → ℤ

  Stateᴮ : Set
  Stateᴮ = Varᴮ → BExpr

  _caseᴵ_ :  Stmt → Stateᴵ → Stmt
  skip caseᴵ x₂ = skip
  localInt x₁ In x₃ end caseᴵ x₂ = {!!}
  localBool x₁ In x₃ end caseᴵ x₂ = {!!}
  (x₁ ≔ᴮ x₃) caseᴵ x₂ = {!!}
  (x₁ ≔ᴵ x₃) caseᴵ x₂ = {!!}
  (x₁ ⨾ x₃) caseᴵ x₂ = {!!}
  if x₁ then x₃ else x₄ end caseᴵ x₂ = {!!}
  while x₁ Do x₃ end caseᴵ x₂ = {!!}

  _caseᴮ_ :  Stmt → Stateᴮ → Stmt
  skip caseᴮ x₂ = skip
  localInt x₁ In x₃ end caseᴮ x₂ = {!!}
  localBool x₁ In x₃ end caseᴮ x₂ = {!!}
  (x₁ ≔ᴮ x₃) caseᴮ x₂ = {!!}
  (x₁ ≔ᴵ x₃) caseᴮ x₂ = {!!}
  (x₁ ⨾ x₃) caseᴮ x₂ = {!!}
  if x₁ then x₃ else x₄ end caseᴮ x₂ = {!!}
  while x₁ Do x₃ end caseᴮ x₂ = {!!}

  
  
    
