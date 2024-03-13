⍝ This is a comment.
⍝ Use :cmd, to introduce a comment.
⍝ Use :cmd l for the output variable ⎕

avg ← {+/⍵ ÷ ⍴⍵} ⍝ :cmd w ⍵, :cmd r ⍴, :cmd = ÷
sd ← {((+/(⍵ - +/⍵ ÷ ⍴⍵)*2)÷⍴⍵)*0.5} ⍝ :cmd p *

⎕ ← 'Test functions avg and sd'
⎕ ← 'Test vector V= ' , V ← 4.5 8 3.6 12
⎕ ← 'Average= ' , avg V
⎕ ← 'Standard Deviation= ' , sd V
' '
