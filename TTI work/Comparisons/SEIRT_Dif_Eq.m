%% SEIRT simple model
function dx = SEIRT_Dif_Eq(t,x)
    beta=3;
    alpha1=1/5;
    gamma1=1/7;
    theta1=x(6); %+0.25;
    delta1=1/7;
    alpha=alpha1/beta;
    gamma=gamma1/beta;
    theta=theta1/beta;
    delta=delta1/beta;
        v=[alpha gamma theta delta];
dx=zeros(length(x),1);
dx(1)=-x(1)*x(2); %-SE
dx(2)=x(1)*x(2)-v(1)*x(2)-v(3)*x(2)*x(2)/(x(1)+x(2)) ; %SE-alpha*E
dx(3)=v(1)*x(2)-v(2)*x(3); %alpha*E -gamma*I
dx(4)=v(2)*x(3)+v(4)*x(5); %gamma*I
dx(5)= v(3)*x(2)*x(2)/(x(1)+x(2)) -v(4)*x(5);
end