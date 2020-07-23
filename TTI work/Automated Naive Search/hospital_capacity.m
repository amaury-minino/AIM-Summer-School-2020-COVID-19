function final_cost = hospital_capacity(infections)
%returns vector of hospital costs
%infections is the vector of all hospitalizations
I= 100; %hospital capacity
c=2; %geq 1, increased costs when ICUs run out
m=length(infections);
final_cost= zeros([1,m]);
    parfor i=1:m
        if infections(i) <= I
            final_cost(i)= 1000*infections(i); %price of a hospital bed in USD
        else
            final_cost(i)=1000*I + 1000*c*(infections(i)-I); %increased costs when overflowed
        end
    end
end