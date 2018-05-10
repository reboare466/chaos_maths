% lorenzbutterfly

close all

for j = 1:1
    x1 = 2.^j;
    y1 = 2.^j;
    z1 = 2.^j;
    sigma = 10;
    rho = 28;
    beta = 8./3;
    tspan = [0,100];

    icond = [x1,y1,z1];

    options = odeset('RelTol',1e-13,'AbsTol',1e-15); % set tolerance for ode
    [t,path] = ode113(@lorenz_equations,tspan,icond,options);

    ifinal = length(path(:,1));

    plot3(path(:,1),path(:,2),path(:,3),'LineWidth',0.5,'Color','r')
    hold on
    scatter3(x1,y1,z1)
    scatter3(path(ifinal,1),path(ifinal,2),path(ifinal,3))
    hold off
%     pause
end

dx = sigma.*(path(:,2)-path(:,1));
dy = path(:,1).*(rho-path(:,3))-path(:,2);
dz = path(:,1).*path(:,2) - beta.*path(:,3);

% figure
% plot3(path(:,1),path(:,2),path(:,3))
% plot3(dx,dy,dz)