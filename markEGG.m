function [peakidx, dpeakidx, maxContact, noContact, opening, pic] = ...
    markEGG(sig, Fs, startTime, endTime, ampfloor, freqceiling, maxThresh, noThresh, openThresh)

sig = sig(round(startTime*Fs):round(endTime*Fs));
%sig = highpass(sig, 20, 44100);
peakidx = detectEGGpeak(sig, Fs, ampfloor, freqceiling);
[dpeakidx, pic] = detectdEGGpeak(sig, peakidx);
maxContact = getThresh(sig, peakidx, maxThresh);
noContact = getThresh(sig, peakidx, noThresh);
opening = getThresh(sig, peakidx, openThresh);
end