function plotSig(sig, idx, pch, msize)
% plot signal and add points as specified by idx
% input:
% - sig: the signal
% - idx: the index of the points
% - pch: marker specifications, e.g. r*, g.
% - msize: marker size
[r, c] = size(idx);
plot(sig)
hold on
if c > 1
    for p = 1:c
        for i = 1:r
            plot(idx{i, p}, sig(idx{i, p}), pch(p), "MarkerSize", msize(p))
        end
    end
else
    for j = 1:r
        plot(idx(j), sig(idx(j)), pch(1), "MarkerSize", msize(1))
    end
end
end