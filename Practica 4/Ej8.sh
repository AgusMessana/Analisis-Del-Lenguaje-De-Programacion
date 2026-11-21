# ----- Ejercicio a ----- #
pred : Nat -> Nat
pred 0 = 0
pred (n + 1) = n

rec 0 paso 0 = 0
rec 0 paso (n + 1) = paso (rec 0 paso n) n ->
-> (λr m. m) (rec 0 paso n) n

pred = R 0 (λr m. m) 

# ----- Ejercicio b ----- #
suma : Nat -> Nat -> Nat
suma n 0 = n
suma n (succ m) = succ (suma n m)

rec n paso 0 = n
rec n paso (m + 1) = paso (rec n paso m) m ->
-> (λr p. succ r) (rec n paso m) m

suma = λn. R n (λr p. succ r)

# ----- Ejercicio c ----- #
mult : Nat -> Nat -> Nat
mult n 0 = 0
mult n (succ m) = suma (mult n m) n

rec 0 paso 0 = 0
rec 0 paso (m + 1) = paso (rec 0 paso m) m ->
-> (λr p. suma r n) (rec 0 paso m) m

mult = λn. R 0 (λr p. suma r n)

# ----- Ejercicio d ----- #
is0 : Nat -> Bool
is0 0 = true
is0 (succ n) = false

rec true paso 0 = true
rec true paso (n + 1) = paso (rec true paso n) n ->
-> (λr p. false) (rec true paso n) n

is0 = R true (λr p. false)

# ----- Ejercicio e ----- #
eq : Nat -> Nat -> Bool
eq = λn m. and (is0 (resta n m)) (is0 (resta m n))

and : Bool -> Bool -> Bool
and = λa b . D a b false

resta : Nat -> Nat -> Nat
resta n 0 = n
resta n (succ m) = pred (resta n m)

rec n paso 0 = n
rec n paso (m + 1) = paso (rec n paso m) m ->
-> (λr p. pred r) (rec n paso m) m

resta = λn. R n (λr p. pred r)