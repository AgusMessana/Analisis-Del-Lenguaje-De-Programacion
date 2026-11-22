PairNat = ∀X. (Nat → Nat → X) → X.

Da vuelta las componentes del par.
swap : PairNat → PairNat
swap = λp : PairNat. pairNat (sndNat p) (fstNat p)

swap2 : PairNat → PairNat
swap2 = λp : PairNat. p ⟨PairNat⟩ (λa : Nat. λb : Nat. ΛX. λf : Nat -> Nat -> X. f b a)