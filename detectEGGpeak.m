function peakidx = detectEGGpeak(sig, Fs, ampfloor, freqceiling)
% detect the peaks of the EGG signal
% input:
% - sig: the EGG signal
% - the samplign frequency
% - ampfloor: the minimum for EGG peaks
% - freqceiling: the maximum value of fundamental frequency
% output:
% - peakidx: a vector of all the indices of EGG peaks
sigSize = length(sig);
% initialize peaknum (number of peaks)
peaknum = 0;
for i = 2:sigSize-1
    if sig(i) - sig(i-1) >= 0 && sig(i) - sig(i+1) >= 0 && sig(i) > ampfloor
        peaknum = peaknum + 1;
        peakidx(peaknum) = i;
    end
end
pseudopeak = 0;
for p = 2:peaknum
    if peakidx(p) - peakidx(p-1) <= Fs/freqceiling
        pseudopeak = pseudopeak + 1;
        if sig(peakidx(p)) > sig(peakidx(p-1))
            rejectpeak(pseudopeak) = peakidx(p-1);
        else
            rejectpeak(pseudopeak) = peakidx(p);
        end
    end
end
if pseudopeak ~= 0
    peakidx = setdiff(peakidx, rejectpeak);
    pseudopeak2 = 0;
    for p = 2:length(peakidx)
        if peakidx(p) - peakidx(p-1) <= Fs/freqceiling
            pseudopeak2 = pseudopeak2 + 1;
            if sig(peakidx(p)) > sig(peakidx(p-1))
                rejectpeak2(pseudopeak2) = peakidx(p-1);
            else
                rejectpeak2(pseudopeak2) = peakidx(p);
            end
        end
    end
    if pseudopeak2 ~= 0
        peakidx = setdiff(peakidx, rejectpeak2);
    end
end
end