function [f] = file_name(a,b)
    if a==1,
        f = 'LMS ';
        f = strcat([f,num2str(b),'.mat']);
    elseif a==2,
        f = 'NLMS ';
        f = strcat([f,num2str(b),'.mat']);
    elseif a==3,
        f = 'RLS ';
        f = strcat([f,num2str(b),'.mat']);
    elseif a==4,
        f = 'Est-Pot ';
        f = strcat([f,num2str(b),'.mat']);
    end
end