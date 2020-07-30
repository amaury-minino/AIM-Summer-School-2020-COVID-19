function [data1, data2]=comparison(fun1,fun2)
%% Initialize shared values

tf=200;
itest=0; %initial testing parameter
tswitch=[5 55]; %when the parameters turn on and off
test_values=[0 0.1 0];
IC=[0.99 0.01 0 0 0];
time=[0 tswitch tf];
a=length(time)-1

%% fun1
IC1=[IC itest]
tx1=[0];
data1=IC1;
    for i=1:a;
        IC1(6)=test_values(i);
        time_interval = time(i):0.1:time(i+1);
        [tx,x_final] = ode45(fun1,time_interval,IC1);
        IC1=x_final(end,:);
        tx1=[tx1(1:end); tx(2:end)];
        data1 = [data1(1:end,:); x_final(2:end,:)];
    %[tx1,data1] = ode45(fun1,time,IC1);
    end


%% fun2
L=zeros(1, 5);
IC2=[IC , L, itest];
tx2=[0];
data2=IC2;
    for i = 1:a
         IC2(11) = test_values(i);
         time_interval = time(i):0.1:time(i+1);
         [tx,x_final] = ode45(fun2,time_interval,IC2);
         IC2 = x_final(end,:);
         tx2 = [tx2(1:end); tx(2:end)];
         data2 = [data2(1:end,:); x_final(2:end,:)];
    end
%[tx2,data2]=ode45(fun2,time,IC2);
%data2_fixed=data2(:, 1:4);
%data_compare=data1-data2_fixed;


%% Data for graphing

S1=data1(:,1);
E1=data1(:,2);
I1=data1(:,3);
R1=data1(:,4);
T1=data1(:,5);
%-----
S2=data2(:,1)+data2(:,5);
E2=data2(:,2)+data2(:,6);
I2=data2(:,3)+data2(:,7);
R2=data2(:,4)+data2(:,8);
Q2=data2(:,5)+data2(:,6)+data2(:,7)+data2(:,8); %quarantined pop
%----------------

%% Plotting for consistency
figure('units', 'normalized', 'outerposition', [0,0,1,1]);
set(gcf,'color','w');
hold on;
plot(tx1,S1,tx1,E1,tx1,I1,tx1,T1,'LineWidth',2);
xlabel('$$t$$','interpreter','latex','fontsize',40);
    ylabel('Relative Population','interpreter','latex','fontsize',40);
    axis([0 tf 0 1]);
    set(gcf,'color','w');
    set(gca,'FontSize',30);
    legend('Susceptible','Exposed','Infected','Quarantined')
    title('SEIRT with temporary testing')
figure('units', 'normalized', 'outerposition', [0,0,1,1]);
set(gcf,'color','w');
hold on;
plot(tx2,S2,tx2,E2,tx2,I2,tx2,Q2,'LineWidth',2);
xlabel('$$t$$','interpreter','latex','fontsize',40);
    ylabel('Relative Population','interpreter','latex','fontsize',40);
    axis([0 tf 0 1]);
    set(gcf,'color','w');
    set(gca,'FontSize',30);
    legend('Susceptible','Exposed','Infected','Quarantined')
    title('SEIR-TCT with contact tracing and temporary testing')
end