%% Run PTTI_Model

X=linspace(0,1,200); %0-100 percent of population, 200 points
Y=linspace(20, 180, 200); %end after 20-180 days, 200 points
recovered=[];
cost=[];
[recovered, cost]=autograph(X,Y)