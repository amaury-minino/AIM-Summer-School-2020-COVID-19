%% SEIR simple model
function dx = SEIR_Dif_Eq(t,x)
beta=3;
alpha1=1/5;
gamma1=1/7;
alpha=alpha1/beta;
gamma=gamma1/beta;
v=[alpha gamma];
dx=zeros(length(x),1);
dx(1)=-x(1)*x(2); %-SE
dx(2)=x(1)*x(2)-v(1)*x(2); %SE-alpha*E
dx(3)=v(1)*x(2)-v(2)*x(3); %alpha*E -gamma*I
dx(4)=v(2)*x(3); %gamma*I
 
end