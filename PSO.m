function [xgbest,fgbest,OF]=PSO(iteration,pop_size,Dmin,Dmax)


c1=2;
c2=2;
wmax=0.9;
wmin=0.4;

D=length(Dmin);
x=zeros(pop_size,D);
v=zeros(pop_size,D);
fitness=zeros(pop_size,1);

for count1=1:pop_size
    for count2=1:D
        x(count1,count2)=Dmin(count2)+rand*(Dmax(count2)-Dmin(count2));
        v(count1,count2)=0.4*rand*(Dmax(count2)-Dmin(count2));
    end
    fitness(count1)=optimfunc(x(count1,:)); %%%%%%%%%%%%%
end

[fgbest indgbest]=min(fitness);
xgbest=x(indgbest,:);
fpbest=fitness;
xpbest=x;

for count1=1:iteration
%     disp([count1 fgbest])
    OF(count1)=fgbest;
    w=wmax-(wmax-wmin)*count1/iteration;
    for count2=1:pop_size
        for count3=1:D
            v(count2,count3)=w*v(count2,count3)+c1*rand*(xpbest(count2,count3)-x(count2,count3))+c2*rand*(xgbest(count3)-x(count2,count3));
            x(count2,count3)=x(count2,count3)+v(count2,count3);
            if x(count2,count3)>Dmax(count3)
                x(count2,count3)=Dmax(count3);
            elseif x(count2,count3)<Dmin(count3)
                x(count2,count3)=Dmin(count3);
            end
        end
        fitness(count2)=optimfunc(x(count2,:)); %%%%%%%%%%%%%%%%%%%%%
        if fitness(count2)<fpbest(count2)
            fpbest(count2)=fitness(count2);
            xpbest(count2,:)=x(count2,:);
            if fitness(count2)<fgbest
                fgbest=fitness(count2);
                xgbest=x(count2,:);
            end
        end
    end
end
fgbest;