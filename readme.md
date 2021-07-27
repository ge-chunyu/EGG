# Analyze EGG signals

This repo contains some scripts which analyze EGG signals and calculate the common EGG parameters in batch.

The scripts do the following things:

- high-pass the EGG signal using the threshold of 20 Hz
- detect single cycles in the EGG signal
- compute the dEGG signal and detect the dEGG peak during each cycle of the EGG signal
- get the positions of different events (e.g., opening, contact) using critical threshold
- calculate EGG measurements:
	+ nCqc: normalized value of CQ using the critical threshold method
	+ nSqc: normalized value of SQ using the critical threshold method 
	+ nSqh: normalized value of SQ using the max contact and decontact in the EGG signal
	+ nCqh: normalized value of CQ using the hybrid method (the peak of the dEGG signal and 0.25 threshold)
	+ nPic: normalized value of PIC (peak increase in contact or DECPA), i.e., the amplitude of the dEGG peak
- also calculate Fo based on the EGG/dEGG signal
	+ nFoc: Fo calculated by dividing the sampling frequency by the EGG cycle
	+ nFov: Fo calculated by dividing the sampling frequency by the dEGG cycle

Some parameters of the scripts can be modified:

- `freqCeiling`: the maximum Fo
- `maxThresh`: the threshold of contact (default 0.9)
- `noThresh`: the threshold of no contact (default 0.1)
- `openThresh`: the threshold of opening (default 0.25)
- `nPoint`: the number of measurement points during each segment

## Usage

Open `analyzeEGG.m` and change the path of EGG signals and the path of the corresponding TextGrid files. A file named `cq.txt` will be generated in the EGG folder.



