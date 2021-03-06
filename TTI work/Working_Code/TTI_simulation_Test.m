clear; clc; close all;

%% Set parameter

t0 = 0;
tf = 200;

%% Initialize
 %%population
    unknown=[1000 1 1 0 ]; %S E I R
    known=[0 0 0 0]; %S E I R
    contact_trace=[0 0]; %S R
 %%Testing and tracing
    a= 3; %number time intervals
    time=[t0 50 100 tf];
    test_values=[0.1 0.1 0.1]; %testing rate for each time interval
    trace_values=[1 0.3 0.2 ];% tracing "    "
    test=0; %initializes testing value
    trace=0; %initializes testing value
 %%Initial conditions
    IC=[unknown known contact_trace test trace]; % S I u tswitch
    % N determined in odesystem
    y=IC(:,:);
    t = [0];
Ffun = @TTI_Dif_Eq;

%% Run Simulation

% Time= t0:0.01:tf;
% [t,y]=ode45(Ffun,Time,IC);


for i = 1:a
 IC(11) = test_values(i);
 IC(12) = trace_values(i);
 time_interval = time(i):0.1:time(i+1);
 [tx,x_final] = ode45(Ffun,time_interval,IC);
 IC = x_final(end,:);
 t = [t(1:end); tx(2:end)];
 y = [y(1:end,:); x_final(2:end,:)];
 
end


% 
% 
% for i = 1:s
%  x0 = x0 + treatment_ic(i,:);
%  time_interval = time_treatment(i):0.1:time_treatment(i+1);
%  [tx,x_final] = ode45(@(t,x)Treatement_model_difq(t,x),time_interval,x0);
%  x0 = x_final(end,:);
%  
%  time_result = [time_result(1:end-1); tx];
%  
%  results = [results(1:end-1,:); x_final];
% end




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