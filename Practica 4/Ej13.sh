PairNat = ∀X. (Nat → Nat → X) → X
Nat = ∀X. (X → X) → X → X

step : PairNat -> PairNat
step = λp : PairNat. p ⟨PairNat⟩ (λa : Nat. λb : Nat. pairNat b (succ b))

pred : Nat -> Nat
pred = λn : Nat. fstNat(n⟨PairNat⟩ step (pairNat zero zero))