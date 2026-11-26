# Definir eq, que dice si dos numerales de Church son iguales.
resta = λn m. m pred n
and = λx y. x y false
eq = λn m. and (isZero (resta n m)) (isZero (resta m n))