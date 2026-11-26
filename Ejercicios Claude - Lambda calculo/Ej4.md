# Definir el factorial de un numeral de Church usando el combinador Y.
fact = λn. (isZero n) 1 (prod n (fact (pred n)))
fact = Y(λf n. (isZero n) 1 (prod n (f (pred n))))