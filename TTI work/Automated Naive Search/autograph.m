%%Automate simulations to determine workable points
function final= autograph(testing_range, time_range)
%testing_range is a vector that gives all values to check 
%time_range gives full simulation time, as well as all possible time
%switches
t0=0;
tf=200;
X=time_range;
lX=length(X);
Y=testing_range;
lY=length(Y);
Z=zeros(lX,lY);

parfor i=1:lX
    for j=1:lY
        Z(i,j)=PTTI_model( [Y(j)],[X(i) 0], [0.5 0.5]);
        i
    end
end
final=Z;
surf(X,Y,Z)
end