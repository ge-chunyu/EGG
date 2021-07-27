function [cycle, dEGGpks, fo_c, fo_v, cq_c, sq_c, cq_h] = calcPara(Fs, dpeakidx, maxContact, opening, digit)
% calculate F0, CQ and SQ based on the marked landmarks
% input:
% - Fs: sampling frequency
% - peakidx
nCycles = length(opening) - 1;
fo_c = zeros(nCycles, 1); % fo using criterion-level
cq_c = zeros(nCycles, 1); % cq using criterion
sq_c = zeros(nCycles, 1); % sq using criterion
cycle = zeros(nCycles, 1); % the time of cycle start

for i = 2:length(opening)
    fo_c(i-1) = round(Fs/(opening{i, 2}-opening{i-1, 2}), digit);
    cq_c(i-1) = round((opening{i,1}-opening{i-1,2})/(opening{i,2}-opening{i-1,2}), digit);
    sq_c(i-1) = round((maxContact{i, 1}-opening{i-1,2})/(opening{i,2}-maxContact{i-1,2}), digit);
    cycle(i-1) = opening{i-1, 2} / Fs;
end

ndEGGpeaks = length(dpeakidx) - 1;
fo_v = zeros(ndEGGpeaks, 1); % fo using dEGG peak
%cq_v = zeros(ndEGGpeaks, 1); % cq using dEGG positive peak and negative peak
cq_h = zeros(ndEGGpeaks, 1); % cq using hybrid
%sq_v = zeros(ndEGGpeaks, 1); % sq using dEGG peak
dEGGpks = zeros(ndEGGpeaks, 1); % the time of dEGG pks

for j = 2:length(dpeakidx)
    fo_v(j-1) = round(Fs/(dpeakidx(j)-dpeakidx(j-1)), digit);
    cq_h(j-1) = round((opening{j-1, 1}-dpeakidx(j-1))/(dpeakidx(j)-dpeakidx(j-1)), digit);
    dEGGpks(j-1) = dpeakidx(j-1) / Fs;
end
end