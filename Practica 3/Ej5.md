# a. (λx y z. x (λy. y z) w)    y    (λt u v. t (λz. z v)) w
(λx y z. x (λy. y z) w) = (λx. (λy. (λz. (x (λy. (y z))) w)))
(λt u v. t (λz. z v)) w = ((λt. (λu. (λv. (t (λz. (z v)))))) w)
No son equivalentes. La estructura de ambos pares son diferentes.

# b. (λx y z. x (λy. y z) w)    y    (λx y w. x (λy. y w) z)
(λx y z. x (λy. y z) w) = (λx. (λy. (λz)))
(λx y w. x (λy. y w) z)

# c. (λx y z. x (λy. y z) w)    y    (λx t z. x (λu. t z)) w


# d. (λx y z. x (λy. y z) w)(λx. x y)    y    (λx y w. x (λy. y z) w) (λz. z y)


# e. (λx y z. x (λy. y z) w)    y    (λv u t. v (λv. v t) w)