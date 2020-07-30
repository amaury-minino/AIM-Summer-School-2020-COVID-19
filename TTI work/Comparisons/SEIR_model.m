function [tx, data]= SEIR_model(IC, tf)
time=0:0.01:tf;

Ffun = @SEIR_Dif_Eq;

%% Run Simulation

[tx,data] = ode45(Ffun,time,IC );

figure(1)
subplot(4,1,1)
plot(tx,data(:,1),'-ob')
hold on
title('Susceptible')
xlim([0 tf])

figure(1)
subplot(4,1,2)
plot(tx,data(:,2),'-or')
hold on
title('Exposed')
xlim([0 tf])

figure(1)
subplot(4,1,3)
plot(tx,data(:,3),'-og')
hold on
title('Infected')
xlim([0 tf])

figure(1)
subplot(4,1,4)
plot(tx,data(:,4),'-oy')
hold on
title('Recovered')
xlim([0 tf])
end