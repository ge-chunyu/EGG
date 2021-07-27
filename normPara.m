function [normTime, nFoc, nFov, nCqc, nSqc, nCqh, nPic, nSqh] = normPara(startTime, endTime, nPoint, cycle, fo_c, fo_v, cq_c, sq_c, cq_h, pic, sq_h)
% normalize parameters by finding the nearest parameter to the normalizing
% point
% input:
% - startTime: the start time of the EGG signal
% - endTime: the end time
% - nPoint: number of points for the interval
% - cycle: the vector of time corresponding to each measurement
% - cq: non-normalized CQ, output of `calcPara.m`, the same for the
% following
% - sq: non-normalized SQ
% output:
% - normTime: the time nearest to the normalized parameter
% - normCQ: normalized CQ
% - normSQ: normalized SQ
duration = endTime - startTime;
normTime = duration / nPoint .* [1:nPoint];
nFoc = zeros(nPoint, 1);
nFov = zeros(nPoint, 1);
nCqc = zeros(nPoint, 1);
nSqc = zeros(nPoint, 1);
nCqh = zeros(nPoint, 1);
nPic = zeros(nPoint, 1);
nSqh = zeros(nPoint, 1);

for i = 1:nPoint
    [~, minx] = min(abs(cycle - normTime(i)));
    nFoc(i) = fo_c(minx);
    nFov(i) = fo_v(minx);
    nCqc(i) = cq_c(minx);
    nSqc(i) = sq_c(minx);
    nCqh(i) = cq_h(minx);
    nPic(i) = pic(minx);
    nSqh(i) = sq_h(minx);
end
end