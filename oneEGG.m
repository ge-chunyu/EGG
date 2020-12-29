function [peakidx, dpeakidx, maxContact, noContact, opening] = ...
    oneEGG(file, interval, ampfloor, freqceiling, maxThresh, noThresh, openThresh)
[sig, Fs] = audioread(file);
startTime = interval(1);
endTime = interval(2);
sig = sig(round(startTime*Fs):round(endTime*Fs));
peakidx = findEGGpeak(sig, Fs, ampfloor, freqceiling);
dpeakidx = detectdEGGpeak(sig, peakidx);
maxContact = getThresh(sig, peakidx, maxThresh);
noContact = getThresh(sig, peakidx, noThresh);
opening = getThresh(sig, peakidx, openThresh);
end