cmap = colormap;
N2 = N/max(max(N));
N2 = N2*max(size(cmap));
imwrite(N2,cmap,'fractal_stuff109.png')