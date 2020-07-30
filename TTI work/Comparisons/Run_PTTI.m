%% Run PTTI_Model

X=linspace(0,1,200); %0-100 percent of population, 200 points
Y=linspace(20, 180, 200); %end after 20-180 days, 200 points
 param=zeros(9,1); %intiialize parameters
    param(1) = 0.0425; %beta,transmission rate per contact
    param(2) = 11; %c, average contacts per day
    param(3) = param(1)*param(2); %beta, average infections per day
    param(4) = 1/5; %alpha, progression rate (exposed to infected)
    param(5) = 1/7; %gamma, disease recovery rate
    param(6) = utest; %theta, the testing rate of infectives
    param(7) = 1/14; %kappa, the rate non-infect leave isolation      
    param(8) = utrace; %eta, success rate of tracing
    param(9) = 1; %chi, tracing rate, set at one so eta determines percent of all contacts successfully traced. 
recovered=[];
cost=[];
[recovered, cost]=autograph(X,Y,param)