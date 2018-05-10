function dy = equations(x,y,z)

L = length(x(1,:));
constants = lorenz_param(dummy);

for j = 1:L
    if j == 1
        dy(1) = constants(1).*(y-x);
    elseif j == 2
        dy(2) = x.*(constants(2)-z)-y;
    elseif j == 3
        dy(3) = x.*y - constants(3).*z;
    end
end