cmap = colormap;
z2 = z/max(max(z));
z2 = z2*max(size(cmap));
imwrite(z2,cmap,'julia_set27.png')