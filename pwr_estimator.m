function [y,beta] = pwr_estimator(NumberofSamples,NumberofExperiments,alpha,InputData,b)
    y_1 = 0;
    tic;
    beta = 1 - alpha;
    y = zeros(1,length(InputData));
for m = 1:NumberofExperiments,
    for k=1:NumberofSamples,
        y(k) = alpha(b) * y_1 + beta(b) * InputData(k)^2;
        y_1 = y(k);
    end
end
end