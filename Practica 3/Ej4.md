# a. (λy. y (λx. x) z) [(λw. w t) / z] =
= (λy. ((y (λx. x)) z)) [(λw. w t) / z] =
= (λy. ((y (λx. x)) z) [(λw. w t) / z]) =
= (λy. ((y (λx. x)) [(λw. w t) / z] z [(λw. w t) / z])) =
= (λy. ((y [(λw. w t) / z] (λx. x) [(λw. w t) / z]) (λw. w t))) =
= (λy. ((y (λx. x)) (λw. w t)))

# b. ((λy. y (λx. x)) z) [(λw. w t) / z] =
= ((λy. (y (λx. x))) z) [(λw. w t) / z] =
= ((λy. (y (λx. x))) [(λw. w t) / z] z [(λw. w t) / z]) =
= ((λy. (y (λx. x))) (λw. w t))

# c. (λy. x (λx. x) z) [(λw. w t) / z] =
= (λy. ((x (λx. x)) z)) [(λw. w t) / z] =
= (λy. ((x (λx. x)) z) [(λw. w t) / z]) =
= (λy. ((x (λx. x)) [(λw. w t) / z] z [(λw. w t) / z])) =
= (λy. ((x [(λw. w t) / z] (λx. x) [(λw. w t) / z]) (λw. w t))) =
= (λy. ((x (λx. x)) (λw. w t)))

# d. (λy. x (λx. x) z) [(λw. w y) / z] =
= (λy. ((x (λx. x)) z)) [(λw. w y) / z] =
= (λu. (((x (λx. x)) z) [u / y]) [(λw. w y) / z]) =
= (λu. ((x (λx. x)) [u / y] z [u / y]) [(λw. w y) / z]) =
= (λu. ((x [u / y] (λx. x) [u / y]) z) [(λw. w y) / z]) =
= (λu. ((x (λx. x)) z) [(λw. w y) / z]) =
= (λu. ((x (λx. x)) [(λw. w y) / z]) z [(λw. w y) / z]) =
= (λu. ((x [(λw. w y) / z] (λx. x) [(λw. w y) / z]) (λw. w y))) =
= (λu. ((x (λx. x)) (λw. w y)))

# e. (λy. y z) [z / y] =
= (λy. (y z)) [z / y] =
= (λy. (y z))

# f. (λy. y z) [y / z] =
= (λy. (y z)) [y / z] =
= (λu. ((y z) [u / y]) [y / z]) =
= (λu. ((y [u / y] z [u / y]) [y / z])) =
= (λu. (u z) [y / z]) =
= (λu. (u [y / z] z [y / z])) =
= (λu. (u y))