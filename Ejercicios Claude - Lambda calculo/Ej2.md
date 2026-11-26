# Determinar qué calcula esta expresión al aplicarla a un numeral de Church:
λn. fst (n (λp. pair (snd p) (fst p)) (pair true false))

0 -> (true false)
1 -> (true, false) -> (false, true)
2 -> (true, false) -> (false, true) -> (true, false)

Determina si un número es par.