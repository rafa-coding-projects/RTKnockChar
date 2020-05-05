function eng_cenario3_combinado
%close all;
figurename = 'eng_cenario3_combinado';
path = 'data\scenario3\scenario3 reviewed\';
NumberofExperiments = 1;
M = [1 1];
mu = [0.7 0.2];
alpha = [0.99 0.99 0.99 0.99];% 0.99 0.99 0.99 0.99 0.99 0.99 0.99 0.99];
%{
FilterExecutionOrder =
        1 - LMS 
        2 - NLMS
        3 - RLS
        4 - Power Estimator
%}
FilterExecutionOrder = [1 4];
%{
Signal Applied to each Filter selected on variable "FilterExecutionOrder"
        1 - Coefficient W
        2 - Knock Signal
        3 - Signal from Power Estimator
        4 - d output (Desired_M, for AF only)
        5 - Previous InputData
        6 - Knock Signal from reference file
        7 - Real Signal (pass variable name)
        8 - Knock file from .mat file
%}
SignalApplied = [8 1];

%{
Name of the variable with the real signal
%}
name = ['scope4_sig1'];

%{
Option of the kind of Knock Generation (ALWAYS ESCALAR)
        1 - Generates knock signal by block with random amplitude
        2 - Generates knock signal by random block with random amplitude
        3 - Generates knock signal by block with random amplitude and random length
        4 - Generates knock signal by random block with random amplitude and random length
        5 - Generates knock signal by random block with random amplitude and random frequency
        6 - Generates knock signal by block with random amplitude and random length and random frequency
        7 - Generates knock signal by random block with random amplitude and random length and random frequency
        8 - Generates knock signal by random block (a trial at everyone) with random amplitude and random length and random frequency
%}
KnockGeneration = 4;



%For Power Estimator
c = alpha;

d = 1;

%For NLMS and RLS
e = 0.6;

%Variable for script file
b = 0;

f  = 1; %string name

l = 0;

m = 0;

v = 0;
    
    for b=1:length(FilterExecutionOrder),
        [d,f,l,v] = take_prev_signal(FilterExecutionOrder,b,SignalApplied(b),KnockGeneration,M(b),name,l,path);
        InputData = d;
        d = 0;
        OutputData = InputData;
        f = file_name(FilterExecutionOrder(b),b);
        if b == 1
            save (figurename,'InputData','OutputData','l');
        end
        knock_lab(InputData,OutputData,NumberofExperiments,M(b),mu(b),FilterExecutionOrder(b),b,c,d,e,f,figurename);
    end
generate_figure;
disp('------------------------------------------------------------------');
disp('                          Finished! :)'); 
disp('------------------------------------------------------------------');
end