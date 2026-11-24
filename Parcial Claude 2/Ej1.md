``` haskell
Con la representación
Nat    = ∀X. (X → X) → X → X
Bool   = ∀X. X → X → X
List X = ∀Y. (X → Y → Y) → Y → Y
y suponiendo definidos zero, succ, nil, cons y append : ∀X. List X → List X → List X

## a) Definir replicate : ∀X. Nat → X → List X, que dado n y un elemento x devuelve una lista con n copias de x.
## b) Definir concatMap : ∀X. ∀Z. (X → List Z) → List X → List Z, que aplica una función a cada elemento y concatena todas las listas resultantes. Por ejemplo, concatMap (λx. [x, x]) [1, 2] = [1, 1, 2, 2].

## a)
replicate 0 x = []
replicate n x = x : replicate (n - 1) x

replicate : ∀X. Nat → X → List X
replicate = ΛX. λn : Nat. λy : X. n ⟨List X⟩ (λr : List X. cons ⟨X⟩ y r) (nil ⟨X⟩)

## b)
concatMap : ∀X. ∀Z. (X → List Z) → List X → List Z
concatMap = ΛX. ΛZ. λf : X -> List Z. λxs : List X. concat ⟨Z⟩ (map ⟨X⟩ ⟨List Z⟩ f xs) 

map : ∀X. ∀Z. (X -> Z) -> List X -> List Z
map f xs = foldr (\x r -> (f x) : r) []
map = ΛX. ΛZ. λf : X -> Z. λxs : List X. xs ⟨List Z⟩ (λx : X. λr : List Z. cons ⟨Z⟩ (f x) r) (nil ⟨Z⟩)

concat : ∀X. List (List X) -> List X
concat xxs = foldr (\xs r -> append xs r) []
concat = ΛX. λxxs : List (List X). xxs ⟨List X⟩ (λxs : List X. λr : List X. append ⟨X⟩ xs r) (nil ⟨X⟩)ª
´´´