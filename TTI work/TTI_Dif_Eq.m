function dx = Dif_Eq_framework(t,x)


%x(1) = Susceptible Unknown
%x(2) = Exposed Unknown
%x(3) = Infected Unknown
%x(4) = Recovered Unknown
%x(5) = Susceptible Known
%x(6) = Exposed Known
%x(7) = Infected Known
%x(8) = Recovered Known

u=5;
v=zeros(6,1);
    v(1) = 0.1; %beta, infection rate               
    v(2) = 0.1; %alpha, progression rate (exposed to infected)
    v(3) = 0.02; %gamma, disease recovery rate
    v(4) = 0.02; %theta, the testing rate from IU to IK
    v(5) = 0.03; %kappa, the rate non-infect leave isolation      
    v(6) = u; %control
N = sum(x);
dx=zeros(8,1);

dx(1) =-v(1)*x(2)*x(3)/N +v(5)*x(8); %Susceptible Unknown

dx(2) = v(1)*x(2)*x(3)/N - v(2)*x(2); %Exposed Unknown

dx(3) = v(2)*x(2) - v(3)*x(3) - v(4)*x(3); %Infected Unknown

dx(4) =v(3)*x(3) +v(5)*x(8); %Recovered Unknown

dx(5) = -v(5)*x(5); %Susceptible Known

dx(6) =  - v(2)*x(6); %Exposed Known

dx(7) = v(4)*x(3)+ v(2)*x(6) - v(3)*x(7); %Infected Known

dx(8) = v(3)*x(7) -v(5)*x(8); %Recovered Known


end