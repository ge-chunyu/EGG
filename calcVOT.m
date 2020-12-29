function VOT = calcVOT(sig, Fs, ampfloor, freqceiling)
% calculates VOT as the duration between release and the first peak
% of the dEGG in the signal
% input: 
% - sig: the signal begins at the release
% - Fs: the sampling frequency
% output: VOT in ms
% Format: calcVOT(sig, Fs)
peakidx = findEGGpeak(sig, Fs, ampfloor, freqceiling);
dpeakidx = detectdEGGpeak(sig, peakidx);
VOT = (1/Fs) * dpeakidx(1) * 1000;
end