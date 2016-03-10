import numpy as np
import matplotlib.pyplot as plt

def iterator(r,iput):
    oput = r * iput * (1 - iput)
    return oput

rmin = 3.4
rmax = 3.6
slices = 1000

maxcount = 500
maxunique = 24
ndp = 3

rvalues = np.tile(np.linspace(rmin, rmax, slices),(24,1))
rvalues = rvalues.T

fullstore = np.zeros((slices, maxunique))

for i in range(0, slices, 1):
    check = 0
    count = 0
    cur = 0.1
    store = np.zeros((1, maxcount))

    while(check == 0):
        oput = iterator(rvalues[i, 0],cur)
        cur = oput
        store[0, count] = cur
        count = count + 1
        if(count >= maxcount):
            check = 1

    roundstore = (np.around(store,decimals=ndp))
    final = np.unique(roundstore[0,-maxunique:])
    padded = np.pad(final, (0,maxunique-len(final)),mode='constant', constant_values=0)
    fullstore[i,:] = padded
    

fullmasked = np.ma.masked_equal(fullstore,0)

plt.scatter(rvalues,fullmasked,s=1)
plt.show()
