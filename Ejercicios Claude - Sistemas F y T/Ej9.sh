Nat = ∀X. (X → X) → X → X
Bool = ∀X. X → X → X

isZero : Nat → Bool
isZero = λn : Nat. n ⟨Bool⟩ (λb : Bool. false) true