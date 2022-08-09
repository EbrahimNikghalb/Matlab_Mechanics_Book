function Animator(Th)
try
    figure(3)
    
    th1 = Th(1,1); th2 = Th(1,2); 
    
    L1 = 2; L2 = 2;
    x11 = 5; y11 = 5;
    x12 = x11+ L1*sind(th1);
    y12 = y11 -L1*cosd(th1);
    H1 = line([x11 x12],[y11 y12],'linewidth',7);
    x21 = x12;
    y21 = y12;
    
    x22 = x21+ L2*sind(th1+th2);
    y22 = y21 -L2*cosd(th1+th2);
    H2 = line([x21 x22],[y21 y22],'linewidth',7,'color','r');
    
      
    axis([0 10 0 6]); box on; axis equal
    set(gca,'xlim',[1 9],'ylim',[0 9])
    
    for i = 1:size(Th,1)
        pause(0.01)
        th1 = Th(i,1); th2 = Th(i,2);
        %% Link 1
        x11 = 5; y11 = 5;
        x12 = x11+ L1*sind(th1);
        y12 = y11 -L1*cosd(th1);
        %% Link 2
        x21 = x12;
        y21 = y12;
        
        x22 = x21+ L2*sind(th1+th2);
        y22 = y21 -L2*cosd(th1+th2);
        %%
        set(H1,'XData',[x11 x12],'YData',[y11 y12])
        set(H2,'XData',[x21 x22],'YData',[y21 y22])
    end
catch
    fprintf('You Forced to stop Animation!!\n\n')
end




