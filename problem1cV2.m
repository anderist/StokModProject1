function problem1cV2

rng('shuffle');                 % initialize random generator with different seed every run
n = 30;                         % # of participants
bMax = 1000;                    % # of realizations
k = floor(n/exp(1));            % optimal stopping rule
x = rand(bMax,n);               % list of x_i's for every realization per row.

m = 0;                          % # of times the strategy gives the best candidate.
p = 0;                          % # of times the strategy gives candidate among top three
q = 0;                          % # of times the strategy gives you candidate x_n (the last candidate).

for b = 1:bMax
    
    temp = max(x(b,1:k)) ;      % store max(x_1,...,x_k)
    c = 0;                      % index for our chosen candidate
    for j = k+1:n               % for all candidates after k
        if x(b,j) > temp        % if its better than max(x_1,...,x_k)...
            c = j;              % ... we choose this candidate
        end
    end
    
    if c == 0                   % if we made it to the last candidate
        c = n;                  %... we choose the this candidate
    end
    
    xSorted = sort(x(b,:));     % sort the list so that the highest candidates are retrieveable
    
    if x(b,c) == xSorted(end)   % if we choose the best candidate
        m = m + 1;
    end
    
    if x(b,c) >= xSorted(end-2) % if we choose the top 3 candidate
        p = p + 1;
    end
    
    if c == n                   %if we've chosen the last candidate
        q = q + 1;
    end
    
end

    fprintf('For %i realizations, with a total of %i participants,\nThe # of times the strategy gave the best result was %i / %d ~= %.3f,\n', bMax,n,m,bMax,m/bMax);
    fprintf('while the probability is (k/n)*ln(n/k) = %.3f.\n',k/n*log(n/k));
    fprintf('The # of times the strategy gave us one of the top three candidates was %i / %d ~= %.3f,\n', p,bMax,p/bMax);
    fprintf('The # of times the strategy gave us the last candidate was %i / %d ~= %.3f,\n', q,bMax,q/bMax);

end
