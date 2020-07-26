%%Automate simulations to determine workable points
function [recovered, costs]= autograph(testing_range, time_range)
%testing_range is a vector that gives all values to check 
%time_range gives full simulation time, as well as all possible time
%switches
t0=0;
tf=300;
Y=time_range;
lY=length(Y);
X=testing_range;
lX=length(X);
Z=zeros(lX,lY);
C=zeros(lX,lY);
tic
parfor i=1:lX
    for j=1:lY
        outcome=PTTI_model( [t0 Y(j) tf],[X(i) 0], [0.5 0.5]);
        Z(i,j) =outcome(end,4)+outcome(end,8)
        infected= outcome(:,3) + outcome(:, 7);
        step=0.1;%from PTTI_model, timestep used in ode45
            T_on = 0:step:Y(j);
            Test_on= ones([1,length(T_on)])*Y(i); %check the length of these vectors
            T_off = Y(j):step:tf;
            Test_off=ones([1,(length(T_off) -1)])*0;
        test=[Test_on, Test_off];
        trace= outcome(:,13);
        C(i,j) = cost(test, trace, infected, step);
        %clock
        [i,j]
    end
    
end
toc
recovered=Z;
costs=C;
figure(1)
surf(X,Y,Z)
hold on
title=('Infections as a function of testing rate and testing duration')
zlabel('Total number of infected')
xlabel('Testing rates')
ylabel('Days of testing')

figure(2)
surf(X,Y,C)
hold on
zlabel('Final Cost USD')
xlabel('Testing rates')
ylabel('Days of testing')
end