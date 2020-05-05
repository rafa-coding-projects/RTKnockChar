function knock_labVIEW_TVT(InputData,OutputData,NumberofExperiments,M,mu,a,b,c,d,e,f,figurename)
	
	%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	%++++++++++             Variables Declaration				+++++++++++++++
	%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    
    save (f,'InputData','OutputData','NumberofExperiments','M');
    disp('------------------------------------------------------------------');
	InputData = InputData';
    OutputData = OutputData';
	NumberofSamples = length(InputData);

	%--------------------------------------------------------------------------
	%							Filter Characteristics
	%--------------------------------------------------------------------------

	%Ensemble Learning Average
	Wacummulated_M      = zeros(M,NumberofSamples);
	MSE_LC              = zeros(1,NumberofSamples);
	EMSE_LC             = zeros(1,NumberofSamples); 
	MSD_LC              = zeros(1,NumberofSamples);
	Desired_M           = zeros(1,NumberofSamples);

	%Vector for measurement purposes
	t = zeros(1,NumberofExperiments);
	%Initial condiitions for w
	w_1 = zeros (M,1);
	w_1_M = zeros (M,1);
	%Step Size 
	u = mu;
    
    %++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    %++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    %++++++++++++++             Power Estimator	(Only 1 Input)		+++++++++++
    %++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    %++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    
    t           = zeros (1,NumberofExperiments);
    y           = 0 * InputData;
    
	%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	%++++++++++     			Filters						+++++++++++++++
	%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

	%--------------------------------------------------------------------------
	%							Experiment
	%--------------------------------------------------------------------------
	
	if a==1 || a==2 || a==3,
            for m = 1:NumberofExperiments,
			%Start timer for performance measurement
			tic;
                if a==1,
                    
                    [Wacummulated,w, MSE, EMSE, MSD,Desired] = lmsfilter (M,NumberofSamples,InputData,w_1,u,OutputData,a);
                    
                elseif a==2,
                    
                    e = e;
                    
                    [Wacummulated,w, MSE, EMSE, MSD,Desired] = enlmsfilter (M,NumberofSamples,InputData,w_1,u,e,OutputData,a);
                    
                elseif a==3,
                    %Squared matrix
                    I = eye (M);
                    %Regularization Parameter
                    e = e;
                    %Lambda
                    h = 0.995;
                    %Initial condition for P
                    P_1 = (1 / e) * I;
                    [Wacummulated,w, MSE, EMSE, MSD,Desired]  = rlsfilter (M,NumberofSamples,InputData,w_1,P_1,h,OutputData,a);
                end
            
			t(m) = toc;
			
			MSE_LC          = MSE_LC            + MSE;
			EMSE_LC 		= EMSE_LC           + EMSE;
			MSD_LC 			= MSD_LC            + MSD;
			Wacummulated_M  = Wacummulated_M    + Wacummulated;
			Desired_M       = Desired_M         + Desired;
			w_1_M           = w_1_M             + w;
			
			%Calculous of Learning Curve
			MSE_LC          = (1/NumberofExperiments) * MSE_LC;
			EMSE_LC 		= (1/NumberofExperiments) * EMSE_LC;
			MSD_LC			= (1/NumberofExperiments) * MSD_LC;
			Wacummulated_M  = (1/NumberofExperiments) * Wacummulated;
			Desired_M       = (1/NumberofExperiments) * Desired;
			w_1_M           = (1/NumberofExperiments) * w;
            end
        f
                
        %
		save (f,'Wacummulated','Wacummulated_M','Desired_M','Desired','MSE_LC','EMSE_LC','MSD_LC','-append');
		save(figurename,'Wacummulated_M','Desired_M','-append');
        %
		%clear function;
		%clearvars -except w_1_M t f M mu a b c d e g l;
		w_1_M;

		%--------------------------------------------------------------------------
		%                       Numerical Result
		%--------------------------------------------------------------------------
		
		disp('Wo Coefficient for Algorithm');
		disp('------------------------------------------------------------------');
		
		w_1_M
		
		%clear w_1_M;
		
		disp('Average Time of Execution for Each Experiment for Algorithm');
		disp('------------------------------------------------------------------');
		mean(t)
		
		%clearvars -except f M mu a b c d e g l;
		%clear function;
		
	elseif a==4,
		%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
		%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
		%++++++++++++++             Power Estimator	(Only 1 Input)		+++++++++++
		%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
		%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%{
		for m = 1:NumberofExperiments,
			y_1 = 0;
			tic;
			for k=1:NumberofSamples,
				y(k) = c(b) * y_1 + beta(b) * InputData(k)^2;
				y_1 = y(k);
			end
			t(m) = toc;
        end
        %}

        [y,beta] = pwr_estimator(NumberofSamples,NumberofExperiments,c,InputData,b);
       
		save(f,'c','beta','y','-append');
		save(figurename,'y','beta','c','-append');
		%clear function;
		%clearvars -except t f M mu a b c d e g l;

		%--------------------------------------------------------------------------
		%                       Numerical Results - Power Estimator
		%--------------------------------------------------------------------------
		
		disp('Average Time of Execution for Each Experiment for Power Estimator Algorithm');
		disp('------------------------------------------------------------------');
		mean(t)
		
		%clearvars -except f M mu a b c d e g l;
		figurename;
		
		%clear function;
		dummy = uint8(0);
    end
end