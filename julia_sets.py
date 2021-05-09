import numpy as np
import matplotlib.pyplot as plt
from matplotlib import cm
from PIL import Image as im

xres = 100 #Row
yres = 100 #Column
xoffset = xres/2
yoffset = yres/2
max_iterations = 100
constant = complex(0.2,-0.7)

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

output_array = np.absolute(output_array)
output_array = 255 * output_array / output_array.max()
output_array = output_array.astype(int)

# Get 256 entries from "viridis" or any other Matplotlib colormap
colmap = cm.get_cmap('viridis', 256)
lut = (colmap.colors[...,0:3]*255).astype(np.uint8)

# Make output image, same height and width as grey image, but 3-channel RGB
result = np.zeros((*output_array.shape,3), dtype=np.uint8)

# Take entries from RGB LUT according to greyscale values in image
np.take(lut, output_array, axis=0, out=result)

#im.fromarray(result).save('result.png')

plt.imshow(output_array,'viridis')
plt.show()
