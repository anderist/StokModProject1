function problem1d
% bulletpoint 1
close all

PNn = 1/(45-16);                                % P(N=n) uniform distribution
Pz1Nn = zeros(1,15);                            % P(z=1|N=n) as in task a)

for k = 1:15
    for n = 16:45
        Pz1Nn(k) = Pz1Nn(k) + k/n*log(n/k);     % Calculate P(z=1|N=n) for a given k
    end
    Pz1Nn(k) = Pz1Nn(k)*(PNn);                  % Calulate P(z=1) for a given k.
end
Pz1 = Pz1Nn;                                    % Give P(z=1) a suitable variable name for clarity

figure()
hold on;
xlabel('k','interpreter','Latex');
ylabel('P(Z=1)','interpreter','Latex');
plot(1:15,Pz1);                               % plot the results
xlim([1 15]);
k_max = find(Pz1 == max(Pz1));              % find which k is the optimal

yl = ylim;
l = line([k_max k_max], [0 yl(2)]);             % plot a vline for the optimal k
l.LineStyle = '--';
l.Color = 'g';
legend(l,{'k_{max}'});

fprintf('\nThe optimal value of k is now %i.\n',k_max);

%bulletpoint 2
nMax = 45;                      % maximum value of n
bMax = 1000;                    % maximum value of b
x = zeros(bMax,nMax);           % initialize our candidate matrix
n= randi([16 45],[bMax 1]);     % find value of n_b for realization b

m = 0;                          % # of times the strategy gives the best candidate.
p = 0;                          % # of times the strategy gives candidate among top three
q = 0;                          % # of times the strategy gives you candidate x_n (the last candidate).
k = k_max;                      % set the k to the optimal value

for b = 1:bMax                  
    x(b,1:n(b)) = rand(1,n(b)); %initialize realization b
    
    temp = max(x(b,1:k)) ;      % store max(x_1,...,x_k)
    c = 0;                      % index for our chosen candidate
    for j = k+1:n(b)               % for all candidates after k
        if x(b,j) > temp        % if its better than max(x_1,...,x_k)...
            c = j;              % ... we choose this candidate
        end
    end
    
    if c == 0                   % if we made it to the last candidate
        c = n(b);                  %... we choose the this candidate
    end
    
    xSorted = sort(x(b,1:n(b)));     % sort the list so that the highest candidates are retrieveable
    
    if x(b,c) == xSorted(end)   % if we choose the best candidate
        m = m + 1;
    end
    
    if x(b,c) >= xSorted(end-2) % if we choose the top 3 candidate
        p = p + 1;
    end
    
    if c == n(b)                %if we've chosen the last candidate
        q = q + 1;
    end
end

    fprintf('For %i realizations,\nThe # of times the strategy gave the best result was %i / %d ~= %.3f,\n', bMax,m,bMax,m/bMax);
    fprintf('while the probability of this occuring is ~= %.3f.\n', Pz1(k_max));
    fprintf('The # of times the strategy gave us one of the top three candidates was %i / %d ~= %.3f,\n', p,bMax,p/bMax);
    fprintf('The # of times the strategy gave us the last candidate was %i / %d ~= %.3f,\n\n', q,bMax,q/bMax);

end