import numpy
import time

def mm():
    start_time= time.time()
    a= numpy.random.randint(0, 1e10, (2, 2000, 2000))
    print((a[0,] @ a[1,]).shape)
    print(time.time() - start_time)

