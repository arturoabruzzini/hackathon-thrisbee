function plotPentagram(holderList)
    figure(2)
    set(gca,'visible','off');
    s = length(holderList);
    hold on
    xValues = [500 405 441 559 595 500];
    yValues = [400 469  581 581 469 400];
    text(xValues(1),yValues(1),'A','FontSize',30);
    text(xValues(2),yValues(2),'B','FontSize',30);
    text(xValues(3),yValues(3),'C','FontSize',30);
    text(xValues(4),yValues(4),'D','FontSize',30);
    text(xValues(5),yValues(5),'E','FontSize',30);
    axis([400 600 400 600]);
    if(s>3)
        for n=1:s-3
            i = holderList(n);
            j = holderList(n+1);
            patch([xValues(i) xValues(j)], [yValues(i) yValues(j)], 'r','FaceColor', 'none', 'EdgeAlpha', 0.05, 'EdgeColor', [0.2 0.2 0.2]);
        end
    end
    if (s>2)
        patch([xValues(holderList(s-2)) xValues(holderList(s-1))], [yValues(holderList(s-2)) yValues(holderList(s-1))], 'r', 'FaceColor', 'none', 'EdgeColor', [0.5 0 0]);
    end
    if (s>1)
        patch([xValues(holderList(s-1)) xValues(holderList(s))], [yValues(holderList(s-1)) yValues(holderList(s))], 'r', 'FaceColor', 'none', 'EdgeColor', [1 0 0]);
    end
end