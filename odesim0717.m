clear; clc; close all;

%% Set parameter

t0 = 0;
tf = 1000;

%% Initialize

IC=[99 1 0 0.1 150]; % S I u tswitch
% N determined in odesystem

Ffun = @odesystem_test;

%% Run Simulation

Time= t0:0.01:tf;
[t,y]=ode45(Ffun,Time,IC);

%% Plot Results

figure(1)
plot(t,y(:,1),'-ob')
hold on
plot(t,y(:,2),'-or')
legend('Susceptible', 'Infected')
xlim([t0 tf])