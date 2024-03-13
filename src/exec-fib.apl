#!/usr/bin/dyalogscript

fib←{⍵≤1:⍵ ⋄ (fib ⍵ - 1)+fib ⍵ - 2}

⎕← fib 39


