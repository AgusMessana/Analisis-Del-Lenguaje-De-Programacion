Dar el tipo de: 
* const ⟨Nat⟩ ⟨Bool⟩
  const : ∀X. ∀Y. X → Y → X
* double ⟨Bool → Bool⟩
  double : ∀X. (X → X) → X → X.

const ⟨Nat⟩ ⟨Bool⟩ : Nat -> Bool -> Nat
double ⟨Bool → Bool⟩ : ((Bool -> Bool) -> (Bool -> Bool)) -> (Bool -> Bool) -> (Bool -> Bool)