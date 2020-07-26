function result=PTTI_model(time_values,test_values,trace_values)
%time_values give each time change
%test_values= different testing rates for each time interval
%trace_values= "   "  tracing  "    "
%length(trace)=length(testing) = length(time) -1

%% Set parameter
% 
time=[time_values];
%% Initialize
 %%population
    unknown=[1000 1 1 0 ]; %S E I R
    known=[0 0 0 0]; %S E I R
    contact_trace=[0 0]; %S R
    Total_traced=[0]; %counts all individuals successfully traced
 %%Testing and tracing
    a= length(time)-1; %number time intervals
    test=0; %initializes testing value
    trace=0; %initializes testing value
 %%Initial conditions
    IC=[unknown known contact_trace test trace Total_traced]; % S I u tswitch
    % N determined in odesystem
    y=IC(:,:);
    t = [0];
Ffun = @TTI_Dif_Eq;

%% Run Simulation


    for i = 1:a
         IC(11) = test_values(i);
         IC(12) = trace_values(i);
         time_interval = time(i):0.1:time(i+1);
         [tx,x_final] = ode45(Ffun,time_interval,IC);
         IC = x_final(end,:);
         t = [t(1:end); tx(2:end)];
         y = [y(1:end,:); x_final(2:end,:)];
    end
result=y;
end

