function threshArray = getThresh(sig, peakidx, thresh)
% Get the index of the point of which the amplitude is the closet to the
% threshold.
% (peakAmp - valleyAmp) * thresh
% input:
% - thresh: the threshold
% - peakidx: the peak index of EGG signals, the output of `detectEGGpeak.m`
% - sig: the EGG signal
threshArray = cell(length(peakidx)-1, 2);
for i = 2:length(peakidx)
    cycle = sig(peakidx(i-1):peakidx(i));
    [minVal, minIdx] = min(cycle);
    leftPeak = cycle(1);
    rightPeak = cycle(end);
    idealThreshL = minVal + (leftPeak - minVal)*thresh;
    idealThreshR = minVal + (rightPeak - minVal)*thresh;
    [~, crLIdx] = min(abs(cycle(1:minIdx) - idealThreshL));
    [~, crRIdx] = min(abs(cycle(minIdx:length(cycle)) - idealThreshR));
    crLIdx = crLIdx-1;
    crRIdx = crRIdx+minIdx-1;
    threshArray{i, 1} = peakidx(i-1) + crLIdx;
    threshArray{i, 2} = peakidx(i-1) + crRIdx;
end
end