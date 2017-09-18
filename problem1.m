function problem1a
close all;
n=[30,40];
k1 = linspace(1,n(1),1000);
k2 = linspace(1,n(2),1000);

Pz1 = k1./n(1).*log(n(1)./k1);
Pz2 = k2./n(2).*log(n(2)./k2);
figure();
hold on;
plot(k1,Pz1);
plot(k2,Pz2);
yl = ylim;
l2 = line([n(2)/exp(1) n(2)/exp(1)],[0,max(yl)]);
l1 = line([n(1)/exp(1) n(1)/exp(1)],[0,max(yl)]);
l2.LineStyle = '--';
l1.LineStyle = '--';

xlabel('n');
ylabel('P(Z=1)','interpreter','Latex');

end