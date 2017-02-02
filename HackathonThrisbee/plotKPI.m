function plotKPI(title,value,secondary)
    set(gca,'visible','off');
    cla
    axis([0 10 0 10]);
    
    text(5,8,title,'FontSize',20,'HorizontalAlignment','center');
    text(5,5,value,'FontSize',40,'HorizontalAlignment','center');
    text(5,2,secondary,'FontSize',20,'HorizontalAlignment','center');
    
end