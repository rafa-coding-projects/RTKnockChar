
close all;clc;clear all;
cd 'data\scenario1\scenario1 reviewed\';
copyfile 'knock_reference.mat' '..\..\..\' f;
cd '..\..\..\';

clear all;
eng_scenario1_combined1

clear all;
eng_scenario1_combined2

clear all;
eng_scenario1_combined3

clear all;
eng_scenario1_combined4
delete knock_reference.mat
%%
cd 'data\scenario2\scenario2 reviewed\';
copyfile 'knock_reference.mat' '..\..\..\' f;
cd '..\..\..\';
clear all;
eng_scenario2_combined

clear all;
eng_scenario2_combined2
delete knock_reference.mat
%%
cd 'data\scenario3\scenario3 reviewed\';
copyfile 'knock_reference.mat' '..\..\..\' f;
cd '..\..\..\';
clear all;
eng_scenario3_combined

clear all;
eng_scenario3_combinedLMS

clear all;
eng_scenario3_combined2

clear all;
eng_scenario3_combinedNLMS
delete knock_reference.mat
disp('******************************************************************');
disp('Simulation is now complete.');
disp('******************************************************************');