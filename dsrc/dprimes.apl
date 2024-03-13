⍝ prm 40 finds all primes between 2 and 40

:NameSpace stat
  avg ← {(+⌿⍵)÷≢⍵}
 
  stDev ← 0.5 * ⍨ (+/2*⍨ ⊢ - + / ÷ ⍴)÷⍴

  prm ←  {(~v ∊ v ∘.×v)/v←1↓⍳⍵}
:EndNameSpace

