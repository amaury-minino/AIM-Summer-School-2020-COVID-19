function runod45(Ffun,IC,tf)
t0=0;
%odeset('NonNegative',[1 2 3],'AbsTol',1e-2,'RelTol',1e-2);
%W. Liu, M. Li model
%odeset('NonNegative',[1 2 3]);
%tf=3e5;
%IC=[35 0.09555 67];
%[t,y]=ode45(@sir,[t0 tf],IC);
%S. Schechter model
%odeset('NonNegative',[1 2 3 4]);
%tf=4e4;
%IC=[.97,.03,.98,.02];
%[t,y]=ode45(@six,[t0 tf],IC);


%The following determines the time steps of the system
%Time=[t0 tf];
Time= t0: 0.01 : tf;

[t,y]=ode45(Ffun,Time,IC);

color = get(gca,'colororder'); % for plotting

    figure(1)
    subplot(5,1,1)
    plot(t,y(:,1),'-o','Color',color(1,:))
    hold on
    title('Susceptible')
    xlim([t0 tf])

    subplot(5,1,2)
    plot(t,y(:,2) + y(:,3),'-o','Color',color(2,:))
    hold on
    title('Infected')
    xlim([t0 tf])

    subplot(5,1,3)
    plot(t,y(:,6) + y(:,7),'-o','Color',color(3,:))
    hold on
    title('Recovered')
    xlim([t0 tf])

    subplot(5,1,4)
    plot(t,y(:,4) + y(:,5),'-o','Color',color(3,:))
    hold on
    title('Quarantine')
    xlim([t0 tf])
    
    subplot(5,1,5)
    plot(t,y(:,8),'-o','Color',color(3,:))
    hold on
    title('Dead')
    xlim([t0 tf])    

    
    
    sgtitle('Truth')
