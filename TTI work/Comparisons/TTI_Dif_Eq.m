function dx = TTI_Dif_Eq(t,x)

%% Variables

v=zeros(9,1); %intiialize testing rates
beta=.3;
c=10; 
alpha=1/5;
gamma=1/7;
kappa=1/7;
theta=x(11);
v(1)=beta;
v(2)=c;
v(3)=beta*c;
v(4)=alpha/v(3);
v(5)=gamma/v(3);
v(6)=theta/v(3); %theta;
v(7)=kappa/v(3); %kappa;
v(8)=0.25; %eta*chi;
v(9)=c/beta %c;
%     v(1) = beta,transmission rate per contact
%     v(2) = c, average contacts per day
%     v(3) = b average infections per day
%     v(4) = alpha, progression rate (exposed to infected)
%     v(5) = gamma, disease recovery rate
%     v(6) = theta, the testing rate of infectives
%     v(7) = kappa, the rate non-infect leave isolation      
%     v(8) = eta*chi, percent of all contacts successfully traced

%% ODE components
dx=zeros(length(x),1);
dx(1) = -x(1)*x(3)+v(7)*x(5)-v(6)*v(8)*x(9); %Su
dx(2)=x(1)*x(3) - v(4)*x(2)-v(6)*v(8)*x(2); %Eu
dx(3)=v(4)*x(2) - v(5)*x(3)-v(6)*x(3)-v(6)*v(8)*x(3); %Iu
dx(4)=v(5)*x(3) +v(7)*x(8)-v(6)*v(8)*x(10); %Ru
dx(5) = v(6)*v(8)*x(9)-v(7)*x(5);%Sk
dx(6) = v(6)*v(8)*x(2)-v(4)*x(6);%Ek
dx(7) = v(6)*v(8)*x(3)+v(6)*x(3)+v(4)*x(6)-v(5)*x(7); %Ik
dx(8) = v(5)*x(7) - v(7)*x(8)+v(6)*v(8)*x(10); %Rk
dx(9) = (v(9)-1)*x(1)*x(3)-(v(5)+v(8)*v(6) +x(3))*x(9); %Sct
dx(10)= v(9)*x(3)*x(4) +v(5)*x(3)-(v(5)+v(8)*v(6))*x(10);%Rct
dx(11)=0; %testing rate
end