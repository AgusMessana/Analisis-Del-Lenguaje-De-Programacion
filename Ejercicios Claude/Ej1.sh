Calcula 2 * n, usando R directamente (sin mult).
doble : Nat → Nat

doble 0 = 0
doble (n + 1) = 2n + 2 = succ (succ (doble n))

rec base paso n
rec 0 paso 0 = 0
rec 0 paso (n + 1) = paso (rec 0 paso n) n ->
-> (λr p. succ(succ r)) (rec 0 paso n) n

doble = λn. R 0 (λr m. succ(succ r)) n