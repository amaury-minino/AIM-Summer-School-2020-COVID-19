function final_cost=cost(t, c, I,space)
%t=tests
%c=contacts
%spacing is determeind by ODE, how small are time steps
%tests is how many people were tested each time step
%contact is how many people were contact traced each time step
k_1=50; %cost per test
k_2=100; %cost per contact traced
final_cost = space*(trapz(k_1 *t)+trapz(k_2*c)+trapz(hospital_capacity(I)));

end