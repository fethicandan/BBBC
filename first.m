function [CostValue] = first(pop)

[N ,l]=size(pop);

 for  i=1:N
    x1 =pop(i,1);
    x2=pop(i,2);

    CostValue(i)=3*x1^2 - 2*x1*x2 + x2^2 + 4*x1 +3*x2;
    
end
end

