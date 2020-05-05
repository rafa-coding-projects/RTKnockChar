function [KS_Signal,reference_damping,noise] = KnockGenerator(a)
knock_signal_amp = 0.5;

N_sinusoid = 10;
ini_signal_size = 1:500;

NumberOfBlocks = 10;
len_signal = length(ini_signal_size);
exp_coef = 0.007;
sine_component = sin(2*pi/N_sinusoid*ini_signal_size);

exp_component = exp(-exp_coef*ini_signal_size);
damped_signal = knock_signal_amp * (sine_component.* exp_component);
len_damped_signal = length(damped_signal);
reference_damping = zeros(1,len_signal*NumberOfBlocks);

sig2 = 0.001;
noise = sqrt(sig2) + randn(1,len_signal*NumberOfBlocks);
noise = noise*0.1;
len_noise = length(noise);

p = rand(1,len_noise);
I = sign(p - rand(1,len_noise));

knock_signal = noise;

if a == 1
    %
    %1 - Generates knock signal by block with random amplitude and fixed frequency
    for k = 1:NumberOfBlocks-1,
        if(rem(k,2))~= 0,
                damped_signal = damped_signal * abs(sign(len_noise - k*len_signal+len_damped_signal)) * (heaviside(len_noise - k*len_signal+len_damped_signal))*(rand+1);
                knock_signal(k*len_signal:k*len_signal+len_damped_signal-1) = noise(k*len_signal:k*len_signal+len_damped_signal-1) + damped_signal + 2;
                reference_damping(k*len_signal:k*len_signal+len_damped_signal-1) = reference_damping(k*len_signal:k*len_signal+len_damped_signal-1) + damped_signal;
        end
    end
    %
elseif a==2,
    %2 - Generates knock signal by random block with random amplitude and fixed frequency
    for k = 1:NumberOfBlocks-1,
        if(rem(k,2))~= 0,
            if I(k) == -1,
                damped_signal = damped_signal * abs(sign(len_noise - k*len_signal+len_damped_signal)) * (heaviside(len_noise - k*len_signal+len_damped_signal))*(rand);
                knock_signal(k*len_signal:k*len_signal+len_damped_signal-1) = noise(k*len_signal:k*len_signal+len_damped_signal-1) + damped_signal;
                reference_damping(k*len_signal:k*len_signal+len_damped_signal-1) = reference_damping(k*len_signal:k*len_signal+len_damped_signal-1) + damped_signal;
            end
        end
    end
elseif a==3,
    %3 - Generates knock signal by block with random amplitude and random
    %length and fixed frequency
    for k = 1:NumberOfBlocks-1,
        if(rem(k,2))~= 0,
            damped_signal = (knock_signal_amp * (sine_component.* (exp(-((0.001+(rand^2)/10))*ini_signal_size)))) * abs(sign(len_noise - k*len_signal+len_damped_signal)) * (heaviside(len_noise - k*len_signal+len_damped_signal))*(rand);
            knock_signal(k*len_signal:k*len_signal+len_damped_signal-1) = noise(k*len_signal:k*len_signal+len_damped_signal-1) + damped_signal;
            reference_damping(k*len_signal:k*len_signal+len_damped_signal-1) = reference_damping(k*len_signal:k*len_signal+len_damped_signal-1) + damped_signal;
        end
    end
elseif a==4,
    %4 - Generates knock signal by random block with random amplitude
    %random length and fixed frequency
    for k = 1:NumberOfBlocks-1,
        if(rem(k,2))~= 0,
            if I(k) == -1,
                damped_signal = (knock_signal_amp * (sine_component.* (exp(-((0.001+(rand^2)/10))*ini_signal_size)))) * abs(sign(len_noise - k*len_signal+len_damped_signal)) * (heaviside(len_noise - k*len_signal+len_damped_signal))*(rand);        
                knock_signal(k*len_signal:k*len_signal+len_damped_signal-1) = noise(k*len_signal:k*len_signal+len_damped_signal-1) + damped_signal;
                reference_damping(k*len_signal:k*len_signal+len_damped_signal-1) = reference_damping(k*len_signal:k*len_signal+len_damped_signal-1) + damped_signal;
            end
        end
    end
    %
elseif a==5,
    %5 - Generates knock signal by random block with random amplitude and random
    %frequency
    for k = 1:NumberOfBlocks-1,
        if(rem(k,2))~= 0,
            if I(k) == -1,
                damped_signal = knock_signal_amp * ((sin(2*pi/10*rand*ini_signal_size).* exp_component)) * abs(sign(len_noise - k*len_signal+len_damped_signal)) * (heaviside(len_noise - k*len_signal+len_damped_signal))*(rand);        
                knock_signal(k*len_signal:k*len_signal+len_damped_signal-1) = noise(k*len_signal:k*len_signal+len_damped_signal-1) + damped_signal;
                reference_damping(k*len_signal:k*len_signal+len_damped_signal-1) = reference_damping(k*len_signal:k*len_signal+len_damped_signal-1) + damped_signal;
            end
        end
    end
elseif a==6,
    %6 - Generates knock signal by block with random amplitude and random
    %length and random frequency
    for k = 1:NumberOfBlocks-1,
        if(rem(k,2))~= 0,
            damped_signal = (knock_signal_amp * (sin(2*pi/10*rand*ini_signal_size).* (exp(-((0.001+(rand^2)/10))*ini_signal_size)))) * abs(sign(len_noise - k*len_signal+len_damped_signal)) * (heaviside(len_noise - k*len_signal+len_damped_signal))*(rand);
            knock_signal(k*len_signal:k*len_signal+len_damped_signal-1) = noise(k*len_signal:k*len_signal+len_damped_signal-1) + damped_signal;
            reference_damping(k*len_signal:k*len_signal+len_damped_signal-1) = reference_damping(k*len_signal:k*len_signal+len_damped_signal-1) + damped_signal;
        end
    end
elseif a==7,
    %7 - Generates knock signal by random block with random amplitude and
    %random length and random frequency
    for k = 1:NumberOfBlocks-1,
        if(rem(k,2))~= 0,
            if I(k) == -1,
                damped_signal = (knock_signal_amp * (sin(2*pi/10*rand*ini_signal_size).* (exp(-((0.001+(rand^2)/10))*ini_signal_size)))) * abs(sign(len_noise - k*len_signal+len_damped_signal)) * (heaviside(len_noise - k*len_signal+len_damped_signal))*(rand);        
                knock_signal(k*len_signal:k*len_signal+len_damped_signal-1) = noise(k*len_signal:k*len_signal+len_damped_signal-1) + damped_signal;
                reference_damping(k*len_signal:k*len_signal+len_damped_signal-1) = reference_damping(k*len_signal:k*len_signal+len_damped_signal-1) + damped_signal;
            end
        end
    end
elseif a==8,
    for k = NumberOfBlocks-1,
            if (rand - rand) > 0,
                damped_signal = (knock_signal_amp * (sin(2*pi/10*rand*ini_signal_size).* (exp(-((0.001+(rand^2)/10))*ini_signal_size)))) * abs(sign(len_noise - k*len_signal+len_damped_signal)) * (heaviside(len_noise - k*len_signal+len_damped_signal))*(rand);
                knock_signal(k*len_signal:k*len_signal+len_damped_signal-1) = noise(k*len_signal:k*len_signal+len_damped_signal-1) + damped_signal;
                reference_damping(k*len_signal:k*len_signal+len_damped_signal-1) = reference_damping(k*len_signal:k*len_signal+len_damped_signal-1) + damped_signal;
            end
    end
else    
    disp('!!Error in Data Insertion!!');
end

if a>0 && a<=8,
    KS_Signal = knock_signal;

    %Uncomment to see how the signals are
    %
    figure
    subplot(3,1,1)
    plot(sine_component)
    title(['n = ',num2str(N_sinusoid),'k = ',num2str(length(ini_signal_size))]);
    grid on;
    subplot(3,1,2)
    plot(exp_coef)
    grid on;
    subplot(3,1,3)
    plot(damped_signal)
    grid on;
    %
    figure
    plot(knock_signal,'k');
    grid on;
    %}   
    save('knock_reference.mat','knock_signal');
end
end