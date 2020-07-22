clear; clc; close all;

%% Set parameter

t0 = 0;
tf = 200;

%% Initialize
unknown=[1000 1 1 0 ]; %S E I R
known=[0 0 0 0]; %S E I R
contact_trace=[0 0]; %S R
a= 2;
time=[50 100];
test=[0.1 0.2];
trace=[0.2  0.3];

IC=[unknown known contact_trace a time test trace]; % S I u tswitch
% N determined in odesystem

Ffun = @TTI_Dif_Eq;

%% Run Simulation

Time= t0:0.01:tf;
[t,y]=ode45(Ffun,Time,IC);

%% Plot Results

figure(1)
subplot(4,3,1)
plot(t,y(:,1),'-ob')
hold on
title('Susceptible U')
xlim([t0 tf])

subplot(4,3,2)
plot(t,y(:,5),'-ob')
hold on
title('Susceptible K')
xlim([t0 tf])

subplot(4,3,3)
plot(t,y(:,1)+y(:,5),'-ob')
hold on
title('Susceptible Total')
xlim([t0 tf])

subplot(4,3,4)
plot(t,y(:,2) ,'-or')
hold on
title('Exposed U')
xlim([t0 tf])

subplot(4,3,5)
plot(t, y(:,6),'-or')
hold on
title('Exposed K')
xlim([t0 tf])

subplot(4,3,6)
plot(t,y(:,2)+ y(:,6),'-or')
hold on
title('Exposed Total')
xlim([t0 tf])

subplot(4,3,7)
plot(t,y(:,3),'-og')
hold on
title('Infected U')
xlim([t0 tf])

subplot(4,3,8)
plot(t,y(:,7),'-og')
hold on
title('Infected K')
xlim([t0 tf])

subplot(4,3,9)
plot(t,y(:,3)+y(:,7),'-og')
hold on
title('Infected Total')
xlim([t0 tf])

subplot(4,3,10)
plot(t,y(:,4),'-oy')
hold on
title('Recovered U')
xlim([t0 tf])

subplot(4,3,11)
plot(t,y(:,8),'-oy')
hold on
title('Recovered K')
xlim([t0 tf])

subplot(4,3,12)
plot(t,y(:,4)+y(:,8),'-oy')
hold on
title('Recovered Total')
xlim([t0 tf])

% 
% subplot(2,1,1)
% plot(t,y(:,9),'-oy')
% hold on
% title('Susceptible Traced')
% xlim([t0 tf])
% 
% subplot(2,1,2)
% plot(t,y(:,10),'-oy')
% hold on
% title('Recovered Traced')
% xlim([t0 tf])