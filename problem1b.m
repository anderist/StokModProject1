function problem1b
close all;
n=[30,40]; %%solve problem for n=30,40
k1 = linspace(1,n(1),1000); %%create list of k's to plot
k2 = linspace(1,n(2),1000);

Pz1 = k1./n(1).*log(n(1)./k1); %% set values for P(Z=1)|n=30
Pz2 = k2./n(2).*log(n(2)./k2); %% set values for P(Z=1)|n=40

figure();
hold on;

plot(k1,Pz1); %plot results
plot(k2,Pz2);

yl = ylim;
l2 = line([n(2)/exp(1) n(2)/exp(1)],[0,max(yl)]); %%find approximate mode for n = 30
l1 = line([n(1)/exp(1) n(1)/exp(1)],[0,max(yl)]); %%find approximate mode for n = 40

l2.LineStyle = '--';%%line formatting
l1.LineStyle = '--';

xlabel('n'); %%set axis labels
ylabel('P(Z=1)','interpreter','Latex');

end