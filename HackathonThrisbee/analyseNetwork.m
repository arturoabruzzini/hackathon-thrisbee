function analyseNetwork(S)
    figure(3)
    cla
    
    groupSize = 5;
    sequenceLength = length(S);
    tally = zeros(groupSize,1);
    connections = zeros(groupSize);
    ignoredStreaks = zeros(groupSize, 1);
    selfPasses = 0;
    
    names = ['A','B','C','D','E'];

    for i=1:sequenceLength
        c = S(i);
        if(i<sequenceLength)
            n = S(i+1);
        else
            n = 1;
        end
        if (c ~= n)
            tally(S(i)) = tally(S(i)) + 1;
        else
            selfPasses = selfPasses + 1;
        end
        connections(c,n) = connections(c,n) + 1;
    end

    for p=1:groupSize
        connections(p,p) = 0;
    end

    for p=1:groupSize
        ipt = 0;
        %ipt = ignoredPresentTally
        for i=2:sequenceLength
            if(S(i) ~= S(i-1))
                if(S(i) ~= p)
                    ipt = ipt+1;
                else
                    ipt = 0;
                end
                if(ipt>ignoredStreaks(p))
                    ignoredStreaks(p) = ipt;
                end
            end
        end
    end

    palOne = 0;
    palTwo = 0;
    bestBudScore = 0;

    for p=1:groupSize
        for q=1:groupSize
            connScore = connections(p,q)+connections(q,p);
            if(connScore > bestBudScore)
                bestBudScore = connScore;
                palOne = p;
                palTwo = q;
            end
        end
    end

    nemesisOne = 0;
    nemesisTwo = 0;
    conMax = 2*max(max(connections));
    enmityScore = 0;

    for p=1:groupSize
        for q=1:groupSize
            enScore = conMax-connections(p,q)-connections(q,p);
            if(p ~=q)
                if(enScore > enmityScore)
                    enmityScore = enScore;
                    nemesisOne = p;
                    nemesisTwo = q;
                end
            end
        end
    end
   
    total = sum(tally);
    [Nmax Imax] = max(tally);
    [Nmin Imin] = min(tally);

    bestBudPercentScore = ceil(100*bestBudScore/conMax);
    enmityPercentScore = ceil(100*enmityScore/conMax);

    %disp(['The total number of throws was ', num2str(total)]);
    subplot(421);
    plotKPI('Number of throws',num2str(total),'');

    %disp(['The most popular person was ', num2str(Imax), ', with a score of ', num2str(Nmax), '.'])
    string = ['with ', num2str(Nmax), ' passes'];
    subplot(422);
    plotKPI('Most popular person', names(Imax),string); 
    ths = ceil(total/groupSize + sqrt(sqrt(sequenceLength)));
    
    if(Nmax > ths)
        %disp(['A notable high score would ', num2str(ths), ' so this is relatively high.']);
        %plotKPI('A notable high score would ', num2str(ths), ' so this is relatively high.');
    else
        %disp(['A notable high score would be ', num2str(ths), ' so this is within expected bounds.']);
        %plotKPI('A notable high score would be ', num2str(ths), ' so this is within expected bounds.');
    end
    %disp(['Whereas the least popular person was ', num2str(Imin), ', with a score of ', num2str(Nmin), '.']);
    string = ['with ', num2str(Nmin), ' passes'];
    subplot(423);
    plotKPI('Least popular person', names(Imin), string);
    tls = floor(total/groupSize - sqrt(sqrt(sequenceLength)));
    if(Nmin < tls)
        %disp(['A notable low score would be ', num2str(tls), ' so this is notably low.']);
        %plotKPI('A notable low score would be ', num2str(tls), ' so this is notably low.');
    else
        %disp(['A notable low score would be ', num2str(tls), ' so this is within reasonable bounds.']);
        %plotKPI('A notable low score would be ', num2str(tls), ' so this is within reasonable bounds.');
    end

    lIS = max(ignoredStreaks);
    aIS = mean(ignoredStreaks);
    %disp(['The longest ignored streak was ', num2str(lIS), ' and the average ignored streak was ', num2str(aIS), '.'])
    string = ['average ignored streak was ', num2str(aIS), ''];
    subplot(424);
    plotKPI('Longest ignored streak', num2str(lIS),string);
    %Notably bad? Compassion score
    gentilityScore = ceil(10 - ((3*aIS/(total/groupSize)) + 2*lIS/total));
    %disp(['Gentility score was  ', num2str(gentilityScore), ' /10 .']);
    subplot(425);
    plotKPI('Gentility score was  ', num2str(gentilityScore), ' /10');
    
    subplot(426);
    plotKPI('Fun had by all  ', [num2str(100), '%'],'');
    
    friendString = [names(palOne) ' & ' names(palTwo)];
    friendResultString = [' with a score of ' num2str(bestBudPercentScore) '%'];
    %disp(['The closest friends were ', friendString, friendResultString]);
    subplot(427);
    plotKPI('The closest friends were ', friendString, friendResultString);
    enemyString = [names(nemesisOne) ' & ' names(nemesisTwo)];
    enemyResultString = [' with a score of ' num2str(enmityPercentScore) '%'];
    %disp(['The most dire enemies were ', enemyString, enemyResultString]);
    subplot(428);
    plotKPI('The most dire enemies were ', enemyString, enemyResultString);

end