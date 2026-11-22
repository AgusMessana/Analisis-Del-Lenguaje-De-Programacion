Calcula n^m.
potencia : Nat → Nat → Nat

potencia n 0 = 1
potencia n (m + 1) = n^(m + 1) = n^m * n = mult (potencia n m) n

rec base paso n
rec 1 paso 0 = 1
rec 1 paso (m + 1) = paso (rec 1 paso m) m ->
-> (λ r p. mult r n) (rec 1 paso m) m

potencia = λn. λm. R 1 (λr p. mult r n) m