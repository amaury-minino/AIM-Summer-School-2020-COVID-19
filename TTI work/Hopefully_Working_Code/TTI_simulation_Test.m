clear; clc; close all;

%% Set parameter

t0 = 0;
tf = 200;

%% Initialize
unknown=[99 0 1 0 0 0 0 0]; %S E I R
known=[0 0 0 0]; %S E I R
contact_trace=[0 0]; %S R
a= 1;
time=[1];
test=[0];
trace=[0];

IC=[unknown known contact_trace a time test trace]; % S I u tswitch
% N determined in odesystem

Ffun = @TTI_Dif_Eq;

%% Run Simulation

Time= t0:0.01:tf;
[t,y]=ode45(Ffun,Time,unknown);

%% Plot Results

figure(1)
plot(t,y(:,1) +y(:,5),'-ob')
hold on
plot(t,y(:,2) + y(:,6),'-or')
hold on
plot(t,y(:,3)+y(:,7),'-og')
hold on
plot(t,y(:,4)+y(:,8),'-oy')
legend('Susceptible', 'Exposed', 'Infected', 'Recovered')
xlim([t0 tf])
