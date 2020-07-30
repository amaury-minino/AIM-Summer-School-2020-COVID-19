function dx = TTI_Dif_Eq(t,x)

%% Variables

v=zeros(8,1); %intiialize testing rates
parfor i=1:8;
    v(i)=x(13+i);
end

%     v(1) = beta,transmission rate per contact
%     v(2) = c, average contacts per day
%     v(3) = b average infections per day
%     v(4) = alpha, progression rate (exposed to infected)
%     v(5) = gamma, disease recovery rate
%     v(6) = theta, the testing rate of infectives
%     v(7) = kappa, the rate non-infect leave isolation      
%     v(8) = eta*chi, percent of all contacts successfully traced

N=0;
for i=1:8
    N=N+x(i);
end
%(x(1)+x(2)+x(3)+x(4)+x(5)+x(6)+x(7)+x(8))

%% ODE components
y=zeros(L,1);

%Su -> Eu, initial infection
y(1) = v(3)*x(1)*x(3)/N;
%(beta*c)*Su*Iu/N

%Eu -> Iu, disease progression
y(2)= v(4)*x(2);
%alpha*Eu

%Iu -> Ru, recovery
y(3)= v(5)*x(3);
%gamma*Iu

%Ek -> Ik, exposed contained becomes infected
y(4) = v(4)*x(6);
%alpha*Ek

%Ik ->Rk, contained ingected recovers
y(5) = v(5)*x(7);
%gamma*Ik

%Sk -> Su, isolation is over
y(6)=v(7)*x(5);
%kappa*Sk

%Rk -> Ru, isolation is over
y(7)=v(7)*x(8);
%kappa*Rk

%Su -> Sk Contact Trace
y(8)= v(6)*v(8)*x(9);
%eta*theta*chi*Sct

%Ru -> Rk Contact Trace
y(9)= v(6)*v(8)*x(10);
%eta*theta*chi*Rct

%Eu -> Ek Contact Trace
y(10)= v(6)*v(8)*x(2);
%eta*theta*chi*Eu

%Iu -> Ik Contact Trace
y(11)= v(6)*v(8)*x(3);
%eta*theta*chi*Iu

%Iu ->Ik Testing
y(12) = v(6)*x(3);
%theta*Iu

%-> Sct, unsucesful infections per day
y(13) = (1-v(1))*v(2)*x(1)*x(3)/N;
%(1-beta)*c*Iu*Su/N

%Sct->, contacts lost through time
y(14) = v(5)*x(9)  +  v(6)*v(8)*x(9) +v(3)*x(3)*x(9)/N;
% (gamma + eta*theta*chi +beta*c*Iu/N)*Sct
%first term is saying that after time of 1/gamma, if someone was in
%contact, we lost them
%second term is saying that we identify someone as contact, so they are no
%longer supected of contact
%third term is saying those expected of contact end up having
%succesful contact

%->Rct, contacts per day, plus new recovered per day
y(15)= v(2)*x(3)*x(4)/N +v(5)*x(3);
%c*Iu*Ru/N + gamma*Iu
%general number of contaacts between infected and recovered per day, plus
%the infected individuals who recovered, since they had "recently" been in
%contact with someone infected

%Rct->, contacts lost through time
y(16) = v(5)* x(10) +  v(6)*v(8)*x(10);
%gamma*Rct + eta*theta*chi*Rct
%gamma is length fo infection, if you were infectious, you would have
%recovered by now, eta theta chi says you were thrown into known.


%% ODE

dx=zeros(L,1);

dx(1)=-y(1) + y(6)-y(8);  % Susceptible Unknown
      %-(general infection term) +(isolated return) - (tracing)
 
   
dx(2)= y(1)- y(2) -y(10); %Exposed Unknown
      %(general infection term)-(exposed to Infectious)-(tracing)
   
dx(3)= y(2)-y(3)- y(12)-y(11);%Infected Unknown
     %(Exposed to infectious) - (Recovery rate)-(testing) -(tracing)

dx(4)=y(3)+y(7) -y(9);%Recovered Unknown
    %(recovery rate) + (isolated return)  -(tracing)   
  
dx(5) = y(8)-y(6);  %Susceptible Known
        %(traced) - (leave isolation)
      
 dx(6) =y(10) -y(4); %Exposed Known
        %(traced) - (exposed to infectious)
% 
 dx(7)= y(4)+y(11) + y(12)- y(5); %Infected Known
         %(exposed to infectious)+(traced) +(testing) - (recovery)   
 
 dx(8) = y(5)-y(7)+y(9);%Recovered Known 
        %(recovery) - (leave isolation) +(traced)
   
dx(9) =y(13)-y(14); %Susceptible traced
       %(growth) - (decay), Susceptible traced

 dx(10)=y(15)-y(16); 
        %(growth) +(growth) - (decay), Recovered  traced
        
 dx(13) =(v(6)*v(8))*(x(9) +x(2) +x(3)+x(10));
     %sus + exposed + infect + rec traced
end