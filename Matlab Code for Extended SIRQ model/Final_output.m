%% Lets see if this works

%% Set parameter

t0       = 0;
tf       = 300        % final time

%% Initialize

 IC=[100 1 1 0 0 0 0 0];
 Ffun = @Dif_Eq_framework
 
%[times,a]=ode45(Ffun,[0,100],IC);
%IC=a(end,:);

%Display the "Truth"
runod45(Ffun,IC,tf);
