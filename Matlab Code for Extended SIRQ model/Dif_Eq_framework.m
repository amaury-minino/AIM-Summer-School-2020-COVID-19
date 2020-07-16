function dx = Dif_Eq_framework(t,x)

%x(1) = Susceptible 
%x(2) = Infected Asym
%x(3) = Infected Sym
%x(4) = Quarantine Asym
%x(5) = Quarantine Sym
%x(6) = Recovered Unknown
%x(7) = Recovered Known
%x(8) = Dead
u=5;
v=zeros(6,1);
    v(1) = 0.1; %beta                  
    v(2) = 0.1; %alpha          
    v(3) = 0.02; %sigma            
    v(4) = 0.02; %gamma                       
    v(5) = 0.03; %mu          
    v(6) = u; %control

dx=zeros(8,1);

dx(1) =-v(1)*x(1)*(x(2) +x(3))/(x(1)+x(2)+x(3)+x(4)+x(5)+x(6)+x(7));

dx(2) = v(2) *v(1)*x(1)*(x(2) +x(3))/(x(1)+x(2)+x(3)+x(4)+x(5)+x(6)+x(7)) ...
    -v(3)*x(2) - v(4)*x(2) -u*x(2)/(x(1)+x(2)+x(3)+x(6));

dx(3) = (1-v(2))*v(1)*x(1)*(x(2) +x(3))/(x(1)+x(2)+x(3)+x(4)+x(5)+x(6)+x(7))...
    +v(3)*x(2) - v(4)*x(3) -u*x(3)/(x(1)+x(2)+x(3)+x(6)) - v(5)*x(3);

dx(4) =u*x(2)/(x(1)+x(2)+x(3)+x(6)) - v(4)*x(4);

dx(5) =u*x(3)/(x(1)+x(2)+x(3)+x(6)) - v(4)*x(5) - v(5)*x(5) ;

dx(6) = v(4)*x(2) + v(4)*x(3) ;

dx(7) = v(4)*x(4) + v(4)*x(5);

dx(8) = v(5)*x(3) + v(5)*x(5);

end