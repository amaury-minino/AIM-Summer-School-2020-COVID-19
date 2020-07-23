function final_cost=cost(test, contact, I,space)
%spacing is determeind by ODE, how small are time steps
%tests is how many people were tested each time step
%contact is how many people were contact traced each time step
k_1=50;
k_2=100;
final_cost = space*(trapz(k_1 *test) + trapz(k_2*contact)+ trapz(hospital_capacity(I)));

end