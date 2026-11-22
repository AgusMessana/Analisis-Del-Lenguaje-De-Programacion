Dice si un número es par. (Pista: pensá qué pasa con la paridad al sumar uno.)
par : Nat → Bool

par 0 = true
par (n + 1) = if par n then false else true

rec base paso n
rec true paso 0 = true
rec true paso (n + 1) = paso (rec true paso n) n ->
-> (λr p. not r) (rec true paso n) n

par = λn. R true (λr p. not r) n