function values = time_switch(conditions, time)
values = [0 0]; %[testing, tracing]
a=conditions(1); %number of time conditions
t_switches = conditions(2:a+1);
testing= conditions(a+2: 2*a+1); %(a+2: a+2 +(a-1))
tracing= conditions(2*a+2: 3*a +1);

    if a ~=0
        for i=1:a
            if time <= t_switches(i)
                break
            else
                values(1)= testing(i);
                values(2)=tracing(i);
            end
        end
    end
    values
end