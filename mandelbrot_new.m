clear               % start fresh
tic                 % start timer

%=======================================
% simulation constants
%=======================================

a = 1000;           % resolution along x axis
b = 1000;           % resolution along y axis
iterations = 30;    % depth of boundry definition

width = 4;      % "zoom"
centrex = 0;   % x position
centrey = 0;   % y position
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

for m = 0:0

c = X + 1i.*Y;      % pre-define complex grid
z = c;              % pre-define function grid

for j = 1:a
    for k = 1:b
        step = 0;
        conv_test = 1;
        while conv_test
            if abs(z(j,k)) < 2
                z(j,k) = (z(j,k)).^2 + c(j,k);   % matrix point-wise itterative function
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
%colormap(hsv)
shading interp
axis equal
% print('-dbmp','-r300',fnames{m+1})
end
toc                 % stop timer