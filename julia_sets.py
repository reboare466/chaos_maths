import numpy as np
import matplotlib.pyplot as plt

xres = 1000 #Row
yres = 1000 #Column
xoffset = xres/2
yoffset = yres/2
max_iterations = 100
constant = complex(0.1,-0.7)

xmin = -3
ymin = -3
xmax = 3
ymax = 3

output_array = np.zeros([xres,yres],np.clongdouble)

for x in range(xres):
    for y in range(yres):
        running_value = complex((x-xoffset)/xoffset*(2),(y-yoffset)/yoffset*2)
        counter = 0
        undecided = True
        while (undecided and counter < max_iterations):
            running_value = running_value*running_value + constant
            counter += 1
            undecided = 0.01 < abs(running_value) < 2
        output_array[x,y] = counter

output_array = -np.absolute(output_array)
#print(output_array)

plt.imshow(output_array,'Spectral')
plt.show()
