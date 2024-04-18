classdef USRPN210
    properties
        % Properties for the original waveform parameters
        originalCarrierFrequency % The carrier frequency of the original waveform in Hertz (Hz)
        originalPhase            % The phase offset of the original waveform in radians
        originalAmplitude        % The maximum amplitude of the original waveform
        originalSamplingFrequency % The sampling frequency of the original waveform, in samples per second (Hz)
        originalDuration         % The duration of the original waveform in seconds
        
        ReceivedWaveformParameters   % Properties of the received waveform
    end
    
    methods
        function obj = USRPN210()
            % Constructor (optional)
            % Set example values for the properties
            obj.originalCarrierFrequency = 1000000;   % 1 MHz
            obj.originalPhase = 0;                % 0 radians
            obj.originalAmplitude = 1;            % Amplitude of 1
            obj.originalSamplingFrequency = 1.01e6; % 10 MS/s
            obj.originalDuration = 1e-3;          % 1 millisecond
        end
        
        function waveform = generateWaveform(obj)
            % Generate waveform using the USRP N210
            
            % Time vector
            t = linspace(0, obj.originalDuration, obj.originalSamplingFrequency * obj.originalDuration);
            
            % Generate continuous sinusoidal waveform
            waveform = obj.originalAmplitude * sin(2*pi*obj.originalCarrierFrequency*t + obj.originalPhase);
        end
        
        function receiveWaveform(obj, receivedWaveform)
        s = receivedWaveform;
        figure
        plot(t,s)
        xlabel('Time (seconds)');
        ylabel('Amplitude');
        title('Time Domain Plot')
        
        s = s.*hamming(N)';
        figure
        plot(s)
        xlabel('Samples');
        ylabel('Amplitude');
        title('Signal After Windowing')

        s = [s zeros(1,2000)];
        
        N2 = length(s);
        figure
        plot(s);
        xlabel('Samples');
        ylabel('Amplitude');
        title('Signal After Zero Padding')
        
        S = fft(s);
        figure
        plot(abs(S))
        xlabel('Samples');
        ylabel('Magnitude');
        title('Frequency Domain Plot')
        
        S_OneSide = S(1:N2/2);
        f = fs*(0:N2/2-1)/N2;
        S_meg = abs(S_OneSide)/(N/4);
        figure
        plot(f,S_meg)
        xlabel('Frequenzy (Hz)');
        ylabel('Amplitude');
        title('Frequency Domain Plot')
        end
    end
end
