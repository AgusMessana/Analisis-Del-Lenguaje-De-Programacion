PairNat = ∀X. (Nat → Nat → X) → X

# ----- Ejercicio a ----- #
pairNat : Nat -> Nat -> PairNat
pairNat = λn : Nat. λm : Nat. ΛX. λf : Nat -> Nat -> X. f n m

# ----- Ejercicio b ----- #
fstNat : PairNat -> Nat
fstNat = λp : PairNat. p ⟨Nat⟩ (λn : Nat. λm : Nat. n)

# ----- Ejercicio c ----- #
sndNat : PairNat -> Nat
sndNat = λp : PairNat. p ⟨Nat⟩ (λn : Nat. λm : Nat. m)