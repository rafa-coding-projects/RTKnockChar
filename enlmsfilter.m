function [Wacummulated_NLMS,Wi, MSE_NLMS, EMSE_NLMS, MSD_NLMS,Desired_NLMS] = enlmsfilter (ntaps,iterations,u,w_init,mi,e,d,a)

%Wacummulated_NLMS = zeros(iterations*ntaps,1,'single');
wzin       = zeros (ntaps,iterations);
MSE_NLMS 	= zeros (1,iterations);
EMSE_NLMS 	= zeros (1,iterations);
MSD_NLMS 	= zeros (1,iterations);
Desired_NLMS 	= zeros (1,iterations);
Wo          = a * ones(ntaps,1);

uSample = zeros(1,ntaps);
dSample = zeros(1,ntaps);

%Wacummulated_NLMS(1:ntaps,:) = Wacummulated_NLMS(1:ntaps,:) + w_init;
Wi = w_init;

for i = ntaps+1:iterations,
    wzin (:,i) = Wi;    
    %d = uSample * c + v(i);
    %dSample = d(i-ntaps:i-1);
    %
    %Instantaneous LMS error determination
    MSE_LMS  (i) = (d(i) -  (uSample * Wi))^2;
    EMSE_LMS (i) = MSE_LMS  (i) + 0.01;
    
    %MSE_LMS  (i) = (Wo - Wi_1)' * dSample * dSample' * (Wo - Wi_1)+ 0.01;
    %EMSE_LMS (i) = (Wo - Wi_1)' * dSample * dSample' * (Wo - Wi_1);
    MSD_LMS  (i) = (Wo - Wi)' * (Wo - Wi);
    %
    %Coefficient estimation
    Wi  = Wi + (mi/(e + (norm(uSample))^2)) * uSample' * ( d(i) -  uSample * Wi);
    %Wi  = Wi + (mi/(e + (norm(uSample))^2)) * uSample' * ( dSample -  uSample' * Wi);
    %Wacummulated_NLMS(i-ntaps+1:i,:) = Wacummulated_NLMS(i-ntaps+1:i,:) + Wi;

    Desired_NLMS(i) = uSample * Wi;
    uSample = [d(i) uSample(1,1:(ntaps-1))];
end	
    
clear dSample uSample Wi_1
Wacummulated_NLMS = wzin;
end