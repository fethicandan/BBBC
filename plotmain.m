

figure(1);
plot3(iteration, xvar(:,1), xvar(:,2),'-b','LineWidth',2,'Marker','o','MarkerFaceColor',[0.5,0.5,0.5]);
set(gca,'FontName','Times New Roman','FontSize',11)
xlabel('�terasyon Numaras�','FontSize',13);
ylabel('x_1 Noktas�','FontSize',13);
zlabel('x_2 Noktas�','FontSize',13);
grid on;
text(-0.6,0,0.7,{'Ba�lang�� noktas�','        (0 0)'},'FontName','Times New Roman','FontWeight','Bold')
text(10,-1.4,-2.9,{'Biti� noktas�','(-1.75 -3.25)'},'FontName','Times New Roman','FontWeight','Bold')


%%Hooke 

figure(2);
plot3(iteration, xvar(:,1), xvar(:,2),'-b','LineWidth',2,'Marker','o','MarkerFaceColor',[0.5,0.5,0.5]);
set(gca,'FontName','Times New Roman','FontSize',11)
xlabel('�terasyon Numaras�','FontSize',13);
ylabel('K_c De�eri','FontSize',13);
zlabel('K_d De�eri','FontSize',13);
grid on;
view(-14,54)
% text(-5,-5,0,{'Ba�lang�� noktas�'},'FontName','Times New Roman','FontWeight','Bold')


figure(3);
plot(Output.time, Output.signals.values(:,2),'-b','LineWidth',2);
hold on;
plot(Output.time, Output.signals.values(:,1),'-.k','LineWidth',2);
set(gca,'FontName','Times New Roman','FontSize',11)
ylabel('Genlik','FontSize',13);
xlabel('Zaman [s]','FontSize',13);
grid on;
xlim([0 2]);
ylim([0 1.201]);
legend('Referans','Sistem Cevab�')

figure(4);
plot(Controller.time, Controller.signals.values,'-b','LineWidth',2);
set(gca,'FontName','Times New Roman','FontSize',11)
ylabel('Genlik','FontSize',13);
xlabel('Zaman [s]','FontSize',13);
grid on;
xlim([0 2]);
% ylim([0 1.201]);




plot(1:1:iteration, coste,'-b','LineWidth',2);