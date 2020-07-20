% simulation that will hopefully determine optimal solution of SIS model
% with control function u(t)

% total population of sim. (constant pop.)
N = 100;

% useful model parameters...
beta = 0.5;
alpha = 0.1;
I0 = 5;
M = 20; % bang-bang "on" value
IHat = 40; % capacity of hospitals

% weighted costs of testing
k1 = 10; 
k2 = 50; % 10 -> -364.5, 50 -> 
c = 2; % scalar to accomodate max hospital capacity

% time vector
deltaT = 0.005;
tVec = 0:deltaT:20;
% allocate memory to vectors in sim
SVec = ones(1,length(tVec));
IVec = SVec;
lambdaVec = SVec;
uVec = SVec; 
cost = SVec;
HVec = SVec;
HVec(1) = lambdaVec(1) * (beta * IVec(1) * SVec(1) / N - uVec(1) * IVec(1) / N - ...
    alpha*IVec(1)) - k1*uVec(1); 

% initial conditions (assuming initial conditions for adjoint vector)
lambdaVec(1) = -364.5; % pretty close, -364.5 for T = 20
SVec(1) = N - I0;
IVec(1) = I0;
% set u
if lambdaVec(1) < (-k1*(N / IVec(1)))
    uVec(1) = M;
else
    uVec(1) = 0;
end

cost(1) = -(k1*uVec(1) + k2*IVec(1))*deltaT;

% find optimal solution for some interval [0, T]
for t = 2:length(tVec)
   % update remaining vectors... depends on g(I)
   if IVec(t-1) <= IHat % we are below capacity
        lambdaVec(t) = lambdaVec(t-1) + (lambdaVec(t-1)*(-beta*(N-IVec(t-1)) * ...
            (1 / N) + beta * IVec(t-1) / N + uVec(t-1)/N + alpha) + k2)*deltaT;
   else % we are above max capacity
        lambdaVec(t) = lambdaVec(t-1) + (lambdaVec(t-1)*(-beta*(N-IVec(t-1)) * ...
            (1 / N) + beta * IVec(t-1) / N + uVec(t-1)/N + alpha) + c*k2)*deltaT;
   end
   
   IVec(t) = IVec(t-1) + (beta*(N - IVec(t-1))*IVec(t-1)/N - uVec(t-1)*IVec(t-1)/N - ...
        alpha*IVec(t-1))*deltaT;
   SVec(t) = N - IVec(t);
   
   % update u
   if lambdaVec(t) < (-k1*(N / IVec(t)))
       uVec(t) = M;
   else
       uVec(t) = 0;
   end
      
   % update cost
   if IVec(t-1) <= IHat
      cost(t) = -(k1*(uVec(t)) + k2*IVec(t))*deltaT;
   else
      cost(t) = -(k1*(uVec(t)) + c*k2*IVec(t))*deltaT;
   end
   
   if IVec(t) <= IHat
        HVec(t) = lambdaVec(t) * (beta * IVec(t) * SVec(t) / N - uVec(t) * IVec(t) / N - ...
            alpha*IVec(t)) - k1*uVec(t) - k2*IVec(t);
   else
        HVec(t) = lambdaVec(t) * (beta * IVec(t) * SVec(t) / N - uVec(t) * IVec(t) / N - ...
            alpha*IVec(t)) - k1*uVec(t) - c*k2*IVec(t);
   end

end

cost = sum(cost)
lambdaVec(end)
