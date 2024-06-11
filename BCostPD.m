function [CostValue] = BCostPD(x)
global Ke Kd K0 K1

[N ,l]=size(x);



 for  i=1:N
    Ke = x(i,1);
    Kd = x(i,2);
    K0 = x(i,3);
    K1 = x(i,4);

    sim('BBBCSystem');
%% J1 Part - Integral Square Error

        CostValue(i)=ISE(end,:);
%% J2 Part - Integral Time Square Error

%     CostValue(i)=ITSE(end,:);

%% J3 Part - Overshoot+Settling Time

%     
%     H=Kc+(Ki/s)+(Kd*s);
%     T=(G*H/(1+G*H));
%     AS=stepinfo(T);
%     if isnan(AS.SettlingTime)
%         AS.SettlingTime=10000;
%     end
% 
%     if ~(MAX(end,:)>=1)
%         MAX(end,:)=10;
%     end
% 
%     if  (Output.signals.values(end,1)>=1);
%         delta=Output.signals.values(end,1)-1;
%         settling=delta*10000;
%         CostValue(i)=MAX(end,:)+AS.SettlingTime;
%         
%     else
%         CostValue(i)=MAX(end,:)+AS.SettlingTime;
% 
%     end
    

    
end

end
