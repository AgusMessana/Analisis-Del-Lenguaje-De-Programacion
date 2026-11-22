Bool = ∀X. X → X → X
List X = ∀Y. (X → Y → Y) → Y → Y

filter : ∀X. (X → Bool) → List X → List X
filter f xs = foldr (\x r -> if f x then x : r else r) [] xs

filter = ΛX. λf : X -> Bool. λxs : List X. xs ⟨List X⟩ (λx : X. λr : List X. (f x) ⟨List X⟩ (cons ⟨X⟩ x r) r) (nil ⟨X⟩)