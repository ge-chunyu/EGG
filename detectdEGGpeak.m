function [dpeakidx, pic] = detectdEGGpeak(sig, peakidx)
% detect the indices of dEGG peaks during the given EGG signal
% input: 
% - sig, the EGG signal
% - peakidx: the peak index of EGG signal, the output of `detectEGGpeak.m`
% or `findEGGpeak.m`
% - ampfloor: the minimum threshold for EGG peak
% - freqceiling: the maximum F0
% Format: detectdEGGpeak(sig)
% output: a vector of indices of the peaks of the dEGG signal
dEGG = diff(sig);
leftidx = 1;
rightidx = 1;
dpeakidx = zeros(length(peakidx), 1);
pic = zeros(length(peakidx), 1);
for i = 1:length(peakidx)
    leftidx = rightidx;
    rightidx = peakidx(i);
    [~, maxidx] = max(dEGG(leftidx:rightidx));
    dpeakidx(i) = maxidx + leftidx - 1;
    pic(i) = dEGG(dpeakidx(i));
end
end