function dy = lorenz_equations(t,icond)

L = length(icond(:,1));
x = icond(1,1);
y = icond(2,1);
z = icond(3,1);
sigma = 10;
rho = 28;
beta = 8./3;

dy = zeros(L,1);

for j = 1:L
    if j == 1
        dy(1,1) = sigma.*(y-x);
    elseif j == 2
        dy(2,1) = x.*(rho-z)-y;
    elseif j == 3
        dy(3,1) = x.*y - beta.*z;
    end
end