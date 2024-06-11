clear all
format long g;
global Ke Kd K0 K1

var=4;
varhi = [1 1 50 50];
varlo = [-1 -1 -50 -50];

iteration=10;                        
popsize=10;  

 n=4;
 [idx,idx]=sort(rand(1,n));
 PopMat=idx(1:n)


for i=1:var
    pop(:,i)=(varhi(i)-varlo(i))*rand(popsize,1)+varlo(i); % random members
end


coste =inf;
for i=1:iteration
    costa=feval('BCostPD',pop);
%     costa=feval('first',pop);
    disp([costa(popsize) i])
    coste(i) = costa(end);
    pop = round(100*bbbcf1(pop,costa,varhi,varlo,i))/100;
    cand(i,:)=pop(end,:);
end

    pop(end,:)
    
   %%
   % IT2FPID 1 , 0.4, 50, 47.83