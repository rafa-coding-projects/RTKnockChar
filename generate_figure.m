load(strcat(figurename,'.mat'))
%%
figure;subplot(3,1,1),plot(y);
title(['Power Estimator Output, \alpha =',num2str(c(1)),...
    ', \beta = ',num2str(beta(1)),', AF \mu =',num2str(mu(1)),...
    ', AF Order = ',num2str(M(1))]);
ylabel('Voltage');
axis([-inf inf min(y) max(y)]);
set(gca,'xtick',[])
ax = gca;
ax.FontSize = 25; 
%%
if SignalApplied(2) == 1
    subplot(3,1,2);plot(Wacummulated_M(1,:));
    sig = Wacummulated_M(1,:);
else
    subplot(3,1,2);plot(Desired_M(1,:));
    sig = Desired_M(1,:);
end
title('Applied Signal');
axis([-inf inf min(sig) max(sig)]);
ylabel('Voltage');
set(gca,'xtick',[]);
ax = gca;
ax.FontSize = 25; 
%%
subplot(3,1,3),plot(InputData);
title('Damped signal after AWGN');
ylabel('Voltage');
%set(gca,'xtick',[0 0.25]);
xticklabels({'0.007','0.014','0.021','0.028','0.035','0.042','0.049','0.054','0.063','0.07'})
xticks('auto')
axis([-inf inf min(InputData) max(InputData)]);
xlabel('Time [s]');
set(gcf, 'Position', get(0, 'Screensize'));
ax = gca;
ax.FontSize = 25; 
%%
%{
subplot(4,1,4),plot(l);
title('Damped signal before AWGN');
ylabel('Voltage');
xlabel('Time [s]');
set(gcf, 'Position', get(0, 'Screensize'));
ax = gca;
ax.FontSize = 20; 
%}
%%
saveas(gca,strcat(figurename,'.fig'));
saveas(gca,strcat(figurename,'.png'));
saveas(gca,strcat(figurename,'.eps'));

SNR_original = 20*log(norm(InputData)^2/norm(InputData-l)^2)
SNR_d = 20*log(norm(Desired_M)^2/norm(InputData-l)^2)
SNR_y = 20*log(norm(y)^2/norm(InputData-l)^2)
