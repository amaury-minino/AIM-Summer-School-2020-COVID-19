%% Function for sensitivty analysis
%This will generate a straightforward function that takes in as input all
%possible model parameters, and outputs all possible information.
function [recovered, cost] =  sa_PTTI( difeq_param, testing_range, testing_time_range, contact_range, runtime)

X=testing_range; %0-100 percent of population, 200 points
Y=testing_time_range; %end after 20-180 days, 200 points
c=contact_range; %0-100 percent effectiveness of capturing contacts, 200 points
p=difeq_param;
rt=runtime;
recovered=[];
cost=[];
[recovered, cost]=autograph(X,Y,c,p,rt)
end


