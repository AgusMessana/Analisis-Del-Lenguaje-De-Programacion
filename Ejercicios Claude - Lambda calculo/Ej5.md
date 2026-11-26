# Representamos las listas como su propio fold, igual que en Sistema F pero sin tipos
nil  = λc n. n
cons = λx xs. λc n. c x (xs c n)

# Definir
# a. isNil, que dice si una lista es vacía
isNil = λxs. xs (λx r. false) true

# b. length, el largo de una lista (como numeral de Church)
length = λxs. xs (λx r. succ r) 0

# c. sum, la suma de una lista de numerales
sum = λxs. xs (λx r. suma x r) 0

# d. map
map = λf xs. xs (λx r. cons (f x) r) nil

# e. append
append = λxs ys. xs (λx r. cons x r) ys