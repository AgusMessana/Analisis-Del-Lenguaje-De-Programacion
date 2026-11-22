# ----- Inciso a ----- #
∅ ⊢ either (λx : N. suc (suc x)) (λf : N → N. f 0) (inl 0)

Para usar la regla T-Either deben cumplirse 3 premisas:
1. Γ ⊢ t1 : T1 -> T => ∅ ⊢ (λx : N. suc (suc x)) : N -> N
2. Γ ⊢ t2 : T2 -> T => ∅ ⊢ (λf : N → N. f 0) : (N -> N) -> N
3. Γ ⊢ t : T1 + T2 => ∅ ⊢ (inl 0) : N  + (N -> N)

(Árbol en el archivo .png)

# ----- Inciso b ----- #
Progreso: si ∅ ⊢ t : T entonces t es un valor o existe t' tal que t -> t'
Preservación: si Γ ⊢ t : T y t -> t' entonces Γ ⊢ t' : T

# ----- Inciso c ----- #
Progreso no vale. 
Contraejemplo: t = inl ((λx : N. x) 0).

1. Está bien tipado. Por T-Var y T-Abs, ∅ ⊢ λx : N. x : N → N. Por T-Zero, ∅ ⊢ 0 : N. Entonces, por T-App, ∅ ⊢ (λx : N. x) 0 : N Finalmente, por T-Inl, ∅ ⊢ inl ((λx : N. x) 0) : N + N.

2. No es un valor. Los valores de la forma inl son inl v, con v un valor. Pero (λx : N. x) 0 es una aplicación, y las aplicaciones no son valores. Por lo tanto, t no es un valor.

3. No existe t' tal que t → t'. Ninguna regla de evaluación tiene a la izquierda un término de la forma inl t₁: no hay una regla de congruencia del tipo
    t₁ → t₁'
──────────────────
inl t₁ → inl t₁'
Las reglas E-Either2 y E-Either3 contienen inl/inr, pero solo como argumento de either, así que tampoco se aplican.

Entonces t es un término cerrado, bien tipado, que no es un valor y no puede dar ningún paso: está atascado. Por lo tanto, progreso no se cumple.

