# Definir or y xor (verdadero si exactamente uno de los dos es verdadero).
or = λx y. x true y

xor = λx y. x (not y) y