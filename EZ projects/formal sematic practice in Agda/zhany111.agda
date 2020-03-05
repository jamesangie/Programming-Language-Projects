open import Data.Nat using (ℕ ; zero ; suc ; pred)
open import Data.Product using (_×_ ; _,_)
open import Relation.Binary.PropositionalEquality
  using (_≡_ ; _≢_)
  renaming (refl to ByReflexivity)

data Var : Set where
  i j k : Var

State : Set
State = Var → ℕ

-- Update a state for a single variable
_[_≔_] : State → Var → ℕ → State
(σ [ i ≔ n ]) i = n
(σ [ j ≔ n ]) j = n
(σ [ k ≔ n ]) k = n
{-# CATCHALL #-} -- Avoids a small warning about not properly splitting variables
(σ [ x ≔ n ]) y = σ x

data Stmt : Set where
  Skip : Stmt
  Inc : Var → Stmt
  Dec : Var → Stmt
  Zero?_Do_ : Var → Stmt → Stmt

reduce : Stmt × State → Stmt × State
reduce (Skip , σ) = Skip , σ
reduce (Inc x , σ) = Skip , (σ [ x ≔ suc (σ x) ]) -- use suc
reduce (Dec x , σ) = Skip , (σ [ x ≔ pred (σ x) ]) -- use pred
reduce ((Zero? x Do S) , σ) with σ x
…                              | 0 = reduce (S , σ)
…                              | (suc _) = (Skip , σ)


data _⟶_ : Stmt × State → Stmt × State → Set where
  increase : {σ : State} → {x : Var} → (Inc x , σ) ⟶ (Skip , (σ [ x ≔ suc (σ x) ]))
  decrease : {σ : State} → {x : Var} → (Dec x , σ) ⟶ (Skip , (σ [ x ≔ pred (σ x) ]))
  cond-up :  {σ : State} → {x : Var} → σ x ≡ zero → {S : Stmt} → ((Zero? x Do S) , σ) ⟶ reduce (S , σ)
  cond-skip : {σ : State} → {x : Var} → σ x ≢ zero → {S : Stmt} → ((Zero? x Do S) , σ) ⟶ (Skip , σ)

evaluate : Stmt × State → State
evaluate (Skip , σ) = σ
evaluate (Inc x , σ) = (σ [ x ≔ suc (σ x) ])
evaluate (Dec x , σ) = (σ [ x ≔ pred (σ x) ])
evaluate ((Zero? x Do S) , σ) with σ x
…                               | 0 = evaluate (S , σ)
…                               | (suc _) = σ


data _⇓_ : Stmt × State → State → Set where
  increase : {σ : State} → {x : Var} → (Inc x , σ) ⇓ (σ [ x ≔ suc (σ x) ])
  decrease : {σ : State} → {x : Var} → (Dec x , σ) ⇓ (σ [ x ≔ pred (σ x) ])
  cond-do : {σ : State} → {x : Var} → σ x ≡ 0 → {S : Stmt} → ((Zero? x Do S) , σ) ⇓ evaluate (S , σ)
  cond-skip : {σ : State} → {x : Var} → σ x ≢ 0 → {S : Stmt} → ((Zero? x Do S) , σ) ⇓ σ

σ₁ : State
σ₁ i = 0
σ₁ j = 0
σ₁ k = 0

σ₂ : State
σ₂ i = 1
σ₂ j = 0
σ₂ k = 0

test : (σ₂) ≡ (evaluate (Inc i , σ₁))
test = ByReflexivity
