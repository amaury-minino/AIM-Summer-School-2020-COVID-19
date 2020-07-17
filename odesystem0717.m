function dx = odesystem_test(t,x)

beta = 0.32;
alpha = 0.2;

N = 100;

tswitch = x(5); % Control Condition

if t < tswitch % Activating Switch
    u = x(3);
else
    u = x(4);
end

dx = zeros(5,1);

dx(1) = -beta*x(1)*x(2)/N + alpha*x(2) + u*x(2);
dx(2) = beta*x(1)*x(2)/N - alpha*x(2) - u*x(2);
dx(3) = 0;
dx(4) = 0;
dx(5) = 0;

end
