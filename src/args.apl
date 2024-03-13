⍝ :cmd` gives the concatenating operator ⋄
avg ← {+/⍵ ÷ ⍴ ⍵ }

sdev ← {[vx]
  m ← avg vx
  ⋄ n ← ⍴ vx ⍝ commands are concatenated with ⋄
  ⋄ ((+/(vx - m)*2) ÷ n)*0.5} ⍝ :cmd p *

distance ← {[vx;vy] ⍝ args are separated by semicolon
    (+/(vx - vy)*2)*0.5}

⍝ Test functions avg and sdev
⎕ ← 'Test vector V= ' , V ← 4.5 8 3.6 12
⎕ ← 'Average= ' , avg V
⎕ ← 'Sdev= ' , sdev V
' '
