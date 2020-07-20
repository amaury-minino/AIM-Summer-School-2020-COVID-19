function dx = Dif_Eq_framework(t,x)


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
a=x(11); %number of time changes
utest=0
utrace=0
for i=0:a-1
    tswitch= x(12+i);
    if t <tswitch
        break
    else
       utest=x(12+a +i);
       utrace=x(12+2a+i);
    end
end



v=zeros(9,1); %intiialize testing rates
    v(1) = 0.1; %beta,transmission rate per day
    v(2) = 0.1; %c, average contacts per day
    v(3) = 0.1; %beta, average infections per day
    v(4) = 0.1; %alpha, progression rate (exposed to infected)
    v(5) = 0.02; %gamma, disease recovery rate
    v(6) = utest; %theta, the testing rate of infectives
    v(7) = 0.03; %kappa, the rate non-infect leave isolation      
    v(8) = utrace; %eta, success rate of tracing
    v(9) = 0.1; %chi, tracing rate    


N = sum(x);
dx=zeros(L,1);

dx(1) =-v(3)*x(2)*x(3)/N +v(7)*x(8)... %Susceptible Unknown
       -v(6)*v(8)*v(9)*x(9);   %contact tracing prob.
   
dx(2) = v(3)*x(2)*x(3)/N - v(4)*x(2)... %Exposed Unknown
       -v(6)*v(8)*v(9)*x(2);   %contact tracing prob.
   
dx(3) = v(4)*x(2) - v(5)*x(3) - v(6)*x(3)... %Infected Unknown
       -v(6)*v(8)*v(9)*x(3);   %contact tracing prob.

dx(4) =v(5)*x(3) +v(7)*x(8)... %Recovered Unknown
      -v(6)*v(8)*v(9)*x(1);   %contact tracing prob.
  
dx(5) = -v(7)*x(5)... %Susceptible Known
        +v(6)*v(8)*v(9)*x(9);   %contact tracing prob.
       
dx(6) = -v(4)*x(6); %Exposed Known
        +v(6)*v(8)*v(9)*x(2)...   %contact tracing prob.

dx(7) = v(6)*x(3)+ v(4)*x(6) - v(5)*x(7)... %Infected Known
       +v(6)*v(8)*v(9)*x(2);   %contact tracing prob.

dx(8) = v(5)*x(7) -v(7)*x(8)... %Recovered Known
       +v(6)*v(8)*v(9)*x(2);   %contact tracing prob.
   
dx(9) =(1-v(3))*v(2)*x(1)*x(3) ... %Susceptible contacts traced
      -(v(3)+v(8)*v(6)*v(9) ...
       +v(3)*v(2)*x(3))*x(9); 
   
dx(10)=v(2)*x(3)*x(4) + v(5)*x(3) ... %Recovered contacts traced
      -(v(3)+v(8)*v(6)*v(9))*x(1);


end