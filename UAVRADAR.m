% Objects for each component
%All amplifiers will have different gain potentially
amplifier1 = Amplifier(2);
amplifier2 = Amplifier(2);
amplifier3 = Amplifier(2);
amplifier4 = Amplifier(2);
localOscillator = LocalOscillator(9000000); %Will change later
mixerUp = Mixer();
mixerDown = Mixer();
receivingAntenna = ReceivingAntenna(); %WIP
splitter1 = Splitter();
splitter2 = Splitter();
splitter3 = Splitter();
target = Target();
transmittingAntenna = TransmittingAntenna(); %WIP
usrpN210 = USRPN210(); %Must add properties here
% Generate a waveform
waveform = usrpN210.generateWaveform(); %Wave form parameters

% Pass the waveform through the circuit
outputWaveform = amplifier1.amplify(waveform);
outputWaveform = mixerDown.downConvert(outputWaveform, localOscillator.outputFrequency);
outputWaveformToTransmitAntenna = splitter1.splitSignal(outputWaveform);
outputWaveformToReceivingAntenna = splitter2.splitSignal(outputWaveform);
transmittingAntenna.launchWaveform(outputWaveformToTransmitAntenna);
outputWaveformToUpConverter = splitter3.splitSignal(localOscillator.outputWaveform);
outputWaveform = mixerUp.upConvert(outputWaveformToReceivingAntenna, outputWaveformToUpConverter);
outputWaveform = amplifier2.amplify(outputWaveform);
receivedWaveform = receivingAntenna.receiveWaveform(outputWaveform);

% Display received waveform
disp('Received waveform:');
disp(receivedWaveform);
