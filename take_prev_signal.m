function [d,f,l,filepath] = take_prev_signal(FilterExecutionOrder,b,SignalApplied,h,M,name,l,filepath)
    
    d=0;f='';l=0;

    if b~=1,
        f = file_name(FilterExecutionOrder(b-1),(b-1));
    else
        f = file_name(FilterExecutionOrder(b),(b));
    end
   
    if SignalApplied==1,
        load (f,'Wacummulated_M');
        d = Wacummulated_M(1,:);
        clear Wacummulated_M;
    elseif SignalApplied==2,
        [d,l,filepath] = KnockGenerator(h);
        save('knock_reference','d','l');
    elseif SignalApplied==3;
        load (f,'y'); 
        d = y;
        clear y;
    elseif SignalApplied==4;
        load (f,'Desired_M');
        d = Desired_M;
        clear Desired_M;
    elseif SignalApplied==5;
        load (f,'InputData');
        d = InputData;
        clear InputData;
    elseif SignalApplied==6;
        load ('IonCurrent2Filter.mat');
        d = IonKc;
    elseif SignalApplied==7;
        load ('real_signal.mat',name);
        d = eval(name);
        d = d*0.0000001;
        %d = d + (sqrt(0.001) + randn(1,length(d)))';
    elseif SignalApplied==8
        load(strcat(filepath,'knock_reference.mat'));
    end
end
                