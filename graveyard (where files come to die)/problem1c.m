function problem1c

rng('shuffle');                 % initialize random generator with different seed every run
n = 30;                         % # of participants
bMax = 1000;                    % # of realizations
k = floor(n/exp(1));            % optimal stopping rule
x = rand(bMax,n);               % list of x_i's for every realization per row.

m = 0;                          % # of times the strategy gives the best candidate.
p = 0;                          % # of times the strategy gives candidate among top three
q = 0;                          % # of times the strategy gives you candidate x_n (the last candidate).
for i = 1:bMax
    
    index_max = find(x(i,:) == max(x(i,:)));
    
   %if(there are several participants with the highest value)
    if length(index_max) > 1                
       %if (the best candidate exists to the right of k, find the first one after k)
        if length(index_max(index_max > k)) > 1         % if x_best exists to the right of k, find the first one after k
            index_max = index_max(index_max > k);
            index_max = index_max(1);
        else                                            %else it has to be to the left of k
            index_max = index_max(1);
        end %if
    end %if
   
   %if (x_best is not left of x_k) AND (there are no participant between the right of x_k and x_best for which (x_{k<i<maxIndex} > x_k) ),then the best participant is chosen.
    if (index_max > k) && ((sum(x(i,k+1:index_max-1) > max(x(i,1:k)))) == 0)
        m = m + 1;                                      %strategy worked.
        p = p + 1;                                      %we've also chosen one of the top three candidates...
       %if (the value we've chosen is at the end)
        if index_max == length(x(i,:))
            q = q + 1;                                  %then we've interviewed all candidates.
        end %if
        continue;                                       %...and we need not continue checking anything for this realization.
    end %if
    
    topThreeChosen = 0;                                 %treat this variable as logical, if > 0 then true.
    xSorted = sort(x(i,:));                             %sort the list
    indexList = zeros(1,3);                             %index of the top 3 values
    v = 1;                                              %for counting indexList.
    for j = 1:length(x(i,:))                            %find index of the top 3 values...
            if x(i,j) >= xSorted(end-2)
                indexList(v) = j;                       %....and store them here
                v = v + 1;
            end %if
    end %for
    
   %if(at least one top 3 candidate is to the right of k)
    if (sum(indexList > k)) > 0 
        for j = k+1:length(x(i,:))
           %if(we're gonna choose this candidate)
            if x(i,j) > max(x(i,1:k))
                topThreeChosen = sum((indexList == j)); %if the chosen candidate is found in the indexList, then one of the top three was chosen.
                break;                                  %aaand check if we chose the last one later, thus breaking the loop
            end %if
        end %for
    end %if
    
    
    %if (there is no element to the right of k and to the left the first top3 candidate)
    if (topThreeChosen) 
        p = p + 1; %then we've succesfully chosen a top three candidate.
       %if (our top three candidate was the last one (and thus the only
       %non-zero element of indexList)
        if indexList(1) == length(x(i,:))
            q = q + 1;                                  %then we've interviewed all candidates.
        end %if
        continue;
    end %if
    
    %if (no x_{i>k} is better than any x_{i<=k})
    if sum( (x(i,k+1:end) >= max(x(i,1:k)))) == 0
        q = q + 1;
    end %if
        
    
    
end %for all realizations

fprintf('For %i realizations, with a total of %i participants,\nThe # of times the strategy gave the best result was %i / %d ~= %.3f,\n', bMax,n,m,bMax,m/bMax);
fprintf('while the probability is (k/n)*ln(n/k) = %.3f.\n',k/n*log(n/k));
fprintf('The # of times the strategy gave us one of the top three candidates was %i / %d ~= %.3f,\n', p,bMax,p/bMax);
fprintf('The # of times the strategy gave us the last candidate was %i / %d ~= %.3f,\n', q,bMax,q/bMax);

end %function

