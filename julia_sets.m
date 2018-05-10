clear               % start fresh
tic                 % start timer

%=======================================
% simulation constants
%=======================================

con = 0.6346.*exp(sqrt(-1).*(0.5).*pi);%-0.4+0.2.*sqrt(-1);
a = 500;           % resolution along x axis
b = 500;           % resolution along y axis
iterations = 1000;    % depth of boundary definition

% width = 1;      % "zoom"
% centrex = 0.25;   % x position
% centrey = 0.5;   % y position

width = 0.1;      % "zoom"
centrex = 0.05;   % x position
centrey = 0;   % y position
rot = 0;    % rotation

xmax = centrex + 0.5*width;      % right hand limit on complex plain
xmin = centrex - 0.5*width;      % left hand limit on complex plain
ymax = centrey + 0.5*width;     % top limit on complex plain
ymin = centrey - 0.5*width;     % bottom limit on complex plain

fnames = {'m0','m1','m2','m3','m4','m5','m6','m7','m8','m9','m10','m11','m12','m13','m14','m15','m16','m17','m18','m19','m20','m21','m22','m23','m24','m25','m26','m27','m28','m29','m30'};

%=======================================
% domain generation
%=======================================

x = linspace(xmin,xmax,a);
y = linspace(ymin,ymax,b);

[X,Y] = meshgrid(x,y);          % grid of points

%=======================================
% itteration loop
%=======================================

for m = 6:6

c = con + 0.0003.*m.*con;      % pre-define complex grid
z = exp(-sqrt(-1).*rot).*(X + 1i.*Y);              % pre-define function grid

for j = 1:a
    for k = 1:b
        step = 0;
        conv_test = 1;
        while conv_test
            if abs(z(j,k)) < 2
                z(j,k) = (z(j,k)).^2 + c;   % matrix point-wise itterative function
                step = step + 1;
                if step > iterations
                    z(j,k) = step;
                    conv_test = 0;
                end
            else
                z(j,k) = step;
                conv_test = 0;
            end
        end
    end
end

%=======================================
% plotting
%=======================================

pcolor(x,y,z)
% surf(x,y,z)
% colormap(hsv)
shading interp
axis equal
% print('-dbmp','-r300',fnames{m+1})
end

toc                 % stop timer

% cmap = colormap;
% z2 = z/max(max(z));
% z2 = z2*max(size(cmap));
% imwrite(z2,cmap,'julia_set1.png')