function [Wacummulated,Wi, MSE_LMS, EMSE_LMS, MSD_LMS,Desired] = lmsfilter (ntaps,iterations,u,w_init,mi,d,a)

%Wacummulated = zeros(iterations*ntaps,1,'single');
wzin       = zeros (ntaps,iterations);
MSE_LMS 	= zeros (1,iterations);
EMSE_LMS 	= zeros (1,iterations);
MSD_LMS 	= zeros (1,iterations);
Desired 	= zeros (1,iterations);
%1.0e-312 * 0.9053 -> 5 Non Knocking Cycles
%1.0e-255 * (-0.8669) -> 5 Non Knocking Cycles
%1.0e-183 * (-0.1516) -> 10 Non Knocking Cycles
Wo =  a * ones(ntaps,1);
%
%Wo =   1.0e-003 * [0.0981;-0.0934;-0.3082];
uSample = zeros(1,ntaps);
dSample = zeros(1,ntaps);
%{
J = zeros(1,iterations);
Jgrad = wzin;
%}
%Wacummulated(1:ntaps,:) = Wacummulated(1:ntaps,:) + w_init;
Wi = w_init;

for i = 1:iterations,
    wzin (:,i) = Wi;
    %d = uSample * c + v(i);
    %dSample = d(i-ntaps:i-1)';
    %
    %Instantaneous LMS error determination
    MSE_LMS  (i) = (d(i) -  (uSample * Wi))^2;
    EMSE_LMS (i) = MSE_LMS  (i) + 0.01;
    
    %MSE_LMS  (i) = (Wo - Wi)' * dSample * dSample' * (Wo - Wi)+ 0.01;
    %EMSE_LMS (i) = (Wo - Wi)' * dSample * dSample' * (Wo - Wi);
    MSD_LMS  (i) = (Wo - Wi)' * (Wo - Wi);
    %
    %Coefficient estimation
    %Wi  = Wi + mi *  uSample' * ( dSample - uSample * Wi);
    Wi  = Wi + (mi) *  (uSample') * ( d(i)     - uSample * Wi);
%{
    Var = alpha * (uSample * uSample')* Var_i_1 + beta * temp;
    Var_i_1 = Var;
    Jgrad(i,:) = -d(i)*uSample' + Wi'*(uSample*uSample');
    J(i) = uSample'*uSample - d(i)*uSample'*Wi - Wi'*d(i)*uSample + Wi'* (uSample' * uSample) * Wi;
    hold all
    plot(diag(Var));
%}
    Desired(i) = uSample * Wi;
    uSample = [d(i) uSample(1,1:(ntaps-1))];
end

clear dSample uSample Wi_1
Wacummulated = wzin;
end