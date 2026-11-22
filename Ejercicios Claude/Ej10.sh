Nat = ∀X. (X → X) → X → X

Usando la suma de Sistema F
mult : Nat → Nat → Nat

mult = λn : Nat. λm : Nat. m ⟨Nat⟩ (λr : Nat. suma r n) zero