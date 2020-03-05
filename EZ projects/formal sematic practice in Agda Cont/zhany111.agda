data Truth : Set where
  witness : Truth

data Falsehood : Set where
  -- There's no proof of falsehood, so no constructors

data _∧_ : (P Q : Set) → Set where
  ∧-intro : {P Q : Set} → (pf₁ : P) → (pf₂ : Q) → P ∧ Q

data _∨_ : (P Q : Set) → Set where
  ∨-introᴸ : {P Q : Set} → (pfᴸ : P) → P ∨ Q
  ∨-introᴿ : {P Q : Set} → (pfᴿ : Q) → P ∨ Q

data ¬ : (P : Set) → Set where
  ¬_ : {P : Set} → (contradiction : (P → Falsehood)) → ¬ P

infix 101 _≡_

-- For any type A, all elements a of A are equal to themselves.
-- No other two things are equal.
data _≡_ {A : Set} : A → A → Set where
  ByReflexivity : {a : A} → a ≡ a

∧-idempotent-expand : {P : Set} → P → P ∧ P
∧-idempotent-expand = λ z → ∧-intro z z

∧-idempotent-contract : {P : Set} → P ∧ P → P
∧-idempotent-contract {P} (∧-intro pf₁ pf₂) = pf₁

∨-idempotent-expand : {P : Set} → P → P ∨ P
∨-idempotent-expand = ∨-introᴸ

∨-idempotent-contract : {P : Set} → P ∨ P → P
∨-idempotent-contract {P} (∨-introᴸ pfᴸ) = pfᴸ
∨-idempotent-contract {P} (∨-introᴿ pfᴿ) = pfᴿ

∧-weakeningᴸ : {P Q : Set} → P ∧ Q → P
∧-weakeningᴸ {P} {Q} (∧-intro pf₁ pf₂) = pf₁

∧-weakeningᴿ : {P Q : Set} → P ∧ Q → Q
∧-weakeningᴿ {P} {Q} (∧-intro pf₁ pf₂) = pf₂

∨-weakeningᴸ : {P Q : Set} → P → P ∨ Q
∨-weakeningᴸ {P} {Q} x = ∨-introᴸ x

∨-weakeningᴿ : {P Q : Set} → P → P ∨ Q
∨-weakeningᴿ {P} {Q} x = ∨-introᴸ x

∧-∨-Distribute : {P Q R : Set} → P ∧ (Q ∨ R) → (P ∧ Q) ∨ (P ∧ R)
∧-∨-Distribute {P} {Q} {R} (∧-intro pf₁ (∨-introᴸ pfᴸ)) = ∨-introᴸ (∧-intro pf₁ pfᴸ)
∧-∨-Distribute {P} {Q} {R} (∧-intro pf₁ (∨-introᴿ pfᴿ)) = ∨-introᴿ (∧-intro pf₁ pfᴿ)

∧-∨-Undistribute : {P Q R : Set} → (P ∧ Q) ∨ (P ∧ R) → P ∧ (Q ∨ R)
∧-∨-Undistribute {P} {Q} {R} (∨-introᴸ (∧-intro pf₁ pf₂)) = ∧-intro pf₁ (∨-introᴸ pf₂)
∧-∨-Undistribute {P} {Q} {R} (∨-introᴿ (∧-intro pf₁ pf₂)) = ∧-intro pf₁ (∨-introᴿ pf₂)

Shunt : {P Q R : Set} → (P ∧ Q → R) → (P → Q → R)
Shunt = λ z z₁ z₂ → z (∧-intro z₁ z₂)

Unshunt : {P Q R : Set} → (P → Q → R) → (P ∧ Q → R)
Unshunt {P} {Q} {R} x (∧-intro pf₁ pf₂) = x pf₁ pf₂

modus-ponens : {P Q R : Set} → P ∧ (P → Q) → Q
modus-ponens {P} {Q} {R} (∧-intro pf₁ pf₂) = pf₂ pf₁

-- Note: the pattern () indicates there's no constructor for the argument's type
ex-falso-quodlibet : {P : Set} → Falsehood → P
ex-falso-quodlibet = λ ()
