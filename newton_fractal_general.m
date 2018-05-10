
tic

xmax = 3;
xmin = -3;
ymax = 3;
ymin = -3;
xres = 500;
yres = 500;
iterations = 100;
alpha = 1+0*sqrt(-1);

x = linspace(xmin,xmax,xres);
y = linspace(ymin,ymax,yres);

[X,Y] = meshgrid(x,y);

f = @(u) (10.*u.^5 + u.^3 + 10.*u).*sin(u.^3) - 1;
df = @(u) 3.*(u.^2).*cos(u.^3).*(10.*u.^5 + u.^3 + 10.*u) + ...
    sin(u.^3).*(50.*u.^4 + 3.*u.^2 + 10);

% f = @(u) u.^2 - 1;
% df = @(u) 2.*u.^1;

% f = @(u) 0.01.*exp(u.^2) + u.^7 - 50;
% df = @(u) 0.02.*u.*exp(u.^2) + 7.*u.^6;

% f = @(u) 1.*sqrt(-1).*sin(u-u.^3) + u.^9 - 10.*exp(u.^2)-10;
% df = @(u) 1.*sqrt(-1).*(1-3.*u.^2).*cos(u-u.^3) + 9.*u.^8 -20.*u.*exp(u.^2);

% f = @(u) sin(u).*u.^(sqrt(-1))-1;
% df = @(u) sin(u).*sqrt(-1).*u.^(-1+sqrt(-1)) + cos(u).*u.^(sqrt(-1));

C = X + sqrt(-1).*Y;
Z = C - alpha .* f(C)./df(C);
N = zeros(xres,yres);

for j = 1:xres
    for k = 1:yres
        for l = 1:iterations
                Z(j,k) = Z(j,k) - alpha .* (f(Z(j,k))./df(Z(j,k)));
            if abs(f(Z(j,k))) <= 0.001
                N(j,k) = l;
                break
            end
        end
    end
end

figure(1)
% plot(Z(:,1))
pcolor(X,Y,N)
shading interp
axis equal

toc

%cmap = colormap;
%N2 = N/max(max(N));
%N2 = N2*max(size(cmap));
%imwrite(N2,cmap,'fractal_stuff9.png')