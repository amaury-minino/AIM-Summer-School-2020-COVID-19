function dx = TTI_Dif_Eq(t,x)


%x(1) = Susceptible Unknown
%x(2) = Exposed Unknown
%x(3) = Infected Unknown
%x(4) = Recovered Unknown
%x(5) = Susceptible Known
%x(6) = Exposed Known
%x(7) = Infected Known
%x(8) = Recovered Known
%x(9) = Susceptibles with infectious contact
%x(10)= Recovered with infectious contact
%x(11)= a, Total number of time conditions
%x(12)--x(12+a-1)= Time Controls
%x(12+a)--x(12+2a-1)= Testing control conditions
%x(12+2a)--x(12+3a-1)= Tracing control conditions
%x(12) to x(12+3a-1) allow us to include timers on our controls.

L=length(x);
% a=x(11); %number of time changes
 utest=0.1;
 utrace=0.5;
% if a~=0
%     for i=0:a-1
%         tswitch= x(12+i);
%         if t <tswitch
%             break
%         else
%             utest=x(12+a+i);
%             utrace=x(12+2*a+i);
%         end
%     end
% end
% 


v=zeros(9,1); %intiialize testing rates
    v(1) = 0.0425; %beta,transmission rate per contact
    v(2) = 11; %c, average contacts per day
    v(3) = v(1)*v(2); %beta, average infections per day
    v(4) = 1/5; %alpha, progression rate (exposed to infected)
    v(5) = 1/7; %gamma, disease recovery rate
    v(6) = utest; %theta, the testing rate of infectives
    v(7) = 1/14; %kappa, the rate non-infect leave isolation      
    v(8) = utrace; %eta, success rate of tracing
    v(9) = 0.5; %chi, tracing rate    

N=0;
for i=1:4
    N=N+x(i);
end
%(x(1)+x(2)+x(3)+x(4)+x(5)+x(6)+x(7)+x(8))
dx=zeros(L,1);

dx(1)=-v(3)*x(1)*x(3)/N + v(7)*x(5) -v(6)*v(8)*v(9)*x(9);  % Susceptible Unknown
      %-(general infection term) +(isolated return) - (tracing)
 
   
dx(2)= v(3)*x(1)*x(3)/N- v(4)*x(2) -v(6)*v(8)*v(9)*x(2); %Exposed Unknown
      %(general infection term)-(exposed to Infectious)-(tracing)
   
dx(3)= v(4)*x(2)- v(5)*x(3)- v(6)*x(3)-v(6)*v(8)*v(9)*x(3);%Infected Unknown
     %(Exposed to infectious) - (Recovery rate)-(testing) -(tracing)

dx(4)=v(5)*x(3)+v(7)*x(8) -v(6)*v(8)*v(9)*x(10);%Recovered Unknown
    %(recovery rate) + (isolated return)  -(tracing)   
  
dx(5) = v(6)*v(8)*v(9)*x(9)-v(7)*x(5);  %Susceptible Known
        %(traced) - (leave isolation)
      
 dx(6) =v(6)*v(8)*v(9)*x(2) -v(4)*x(6); %Exposed Known
        %(traced) - (exposed to infectious)
% 
 dx(7)= v(4)*x(6)+v(6)*v(8)*v(9)*x(3) + v(6)*x(3)- v(5)*x(7); %Infected Known
         %(exposed to infectious)+(traced) +(testing) - (recovery)   
%        +v(6)*v(8)*v(9)*x(2);   %contact tracing prob.
% 
 dx(8) = v(5)*x(7)-v(7)*x(8)+v(6)*v(8)*v(9)*x(10);%Recovered Known 
        %(recovery) - (leave isolation) +(traced)
   
dx(9) =(1-v(3))*v(2)*x(1)*x(3)-(v(5)+v(8)*v(6)*v(9)+v(3)*v(2)*x(3))*x(9); %Susceptible traced
       %(growth) - (decay), Susceptible traced

 dx(10)=v(2)*x(3)*x(4) + v(5)*x(3) -(v(3)+v(8)*v(6)*v(9))*x(10); 
        %(growth) +(growth) - (decay), Recovered  traced
    
end