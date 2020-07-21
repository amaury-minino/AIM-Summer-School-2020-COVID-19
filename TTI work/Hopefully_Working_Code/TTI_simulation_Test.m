clear; clc; close all;

%% Set parameter

t0 = 0;
tf = 200;

%% Initialize
unknown=[99 0 1]; %S E I R
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
plot(t,y(:,1),'-ob')
hold on
plot(t,y(:,2),'-or')
legend('Susceptible', 'Infected')
xlim([t0 tf])