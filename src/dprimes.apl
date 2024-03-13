⍝ primes.apl
⍝ prm 40 finds all primes between 2 and 40
prm ← {
  r←w
  ⋄ (~r∊r∘.×r)/r←1↓⍳r}
⎕← prm 40
txt←'<html><body><p>This is <em>emphasized</em> text.</p></body></html>'

htmlTXT ← {⍵ /⍨ ~{⍵∨≠\⍵}⍵∊'<>'} 

