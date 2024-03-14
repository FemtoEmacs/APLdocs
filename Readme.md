# APL -- Mode d'Emploi
This archive contains the source code
of a LaTeX guide for using the APL array
processing language. The compiled file,
which is the only one you may be interested
in downloading and reading, is **apltutorial.pdf**.

I don't claim that I will teach you how
to program in APL. I will only show how
to use the two most efficient APL systems,
April APL and Dyalog APL. For learning APL,
I recommend Stefan Kruger's book,
"Learning APL," which I use myself.

[Learning APL](https://xpqz.github.io/learnapl/intro.html)

## A benchmark
I found a discussion on a computer languages
forum about how fast Dyalog APL is compared
to Python. The forum members proposed using
matrix multiplication to resolve the issue.
Unfortunately, their algorithm was incorrect.
Below, you will find the correct method for
multiplying two matrices of size (3000, 3000),
whose elements are random numbers.
As you can see, Dyalog APL finishes the
calculation in 14 seconds on my machine,
which is not very powerful (the salary of
a professor is not large enough to buy
a top-of-the-line computer).

```
     m1 ← ?3000 3000 ⍴1e10
     m2 ← ?3000 3000 ⍴1e10
     ]Performance.runtime '⍴ m1 +.× m2'

* Benchmarking "⍴ m1 +.× m2"
              (ms)
 CPU (avg):  14227
 Elapsed:    14231
```
The NumPy library relies on BLAS and LAPACK
libraries to execute linear algebra functions
with vectors and matrices efficiently. Even so,
it seems that NumPy is slower than Dyalog APL,
according to the conclusion of the members
of the forum.

```
~/apl/apldocs/src$ python -q
>>>> import numpy
i>>>> import time
>>>> def mm():
....    start_time= time.time()
....    a= numpy.random.randint(0, 1e10, (2, 3000, 3000))
....    print((a[0,] @ a[1,]).shape)
....    print(time.time() - start_time)
....    
>>>> mm()
(3000, 3000)
41.086079359054565
```
As for my part, since I am very fond
of BLAS and LAPACK, I refuse to believe
in what my eyes are showing me.

## Matrix multiplication
Let us see that the algorithm of matrix
multiplication used in the Dyalog APL
benchmark works. I will create two small
random matrices, and multiply them.

```
      m1 ← ?3 3 ⍴ 5

      m1
3 4 2
3 4 1
1 1 5
      m2 ← ?3 3 ⍴ 4
      m2
2 2 1
3 4 3
3 1 3
      m1 +.× m2
24 24 21
21 23 18
20 11 19
```

