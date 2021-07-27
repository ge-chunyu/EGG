function analyzeEGG()
    %path = uigetdir(cd, "Choose folder");
    speaker = "F20";
    path = "/Users/Chunyu/Desktop/suzhou/egg/";
    path = strcat(path, speaker);
    path = strcat(path, filesep);
    files = dir(strcat(path, "*.wav"));
    fileNum = length(files);

    %labelPath = uigetdir(cd, "Choose TextGrid folder");
    labelPath = "/Users/chunyu/Desktop/suzhou/";
    labelPath = strcat(labelPath, speaker);
    labelPath = strcat(labelPath, filesep);
    labelFiles = dir(strcat(labelPath, "*.TextGrid"));

    % specify coefficients
    ampfloor = 0.1;
    freqceiling = 450;
    maxThresh = 0.9;
    noThresh = 0.1;
    openThresh = 0.25;
    nPoint = 12;
    
    data = table([speaker], ["a"],[0],[0],[0],[0],[0],[0],[0],[0],...
                 'VariableNames',{'filename', 'label', 'normTime',...
                 'point', 'nFoc', 'nFov', 'nCqc', 'nSqc', 'nCqh', 'nPic'});
    
    for i = 1:fileNum
        tokenPath = strcat(path, files(i).name);
        
        textGridPath = strcat(labelPath, labelFiles(i).name);
        [sig, Fs] = audioread(tokenPath);

        % denoise
        sig=sig/32767;
        wl_1=iPan_wdenoise(sig,3);
        wl_2=iPan_wdenoise(sig,8);
        sig=wl_1(:,2)-wl_2(:,2);
        sig=0.9*sig/max(abs(sig));

        %sig = highpass(sig, 20, 44100);
        % get the start and end time of the interval to be analysed
        [rhyme, startTime, endTime] = readLabel(textGridPath, 2);
        if startTime ~= 0
            
            [peakidx, dpeakidx, maxContact, noContact, opening, pic] = ...
            markEGG(sig, Fs, startTime, endTime, ampfloor, freqceiling, maxThresh, noThresh, openThresh);
            if length(peakidx) >= 13
                [cycle, dEGGpks, fo_c, fo_v, cq_c, sq_c, cq_h] = calcPara(Fs, dpeakidx, maxContact, opening, 4);
                [normTime, nFoc, nFov, nCqc, nSqc, nCqh, nPic] = normPara(startTime, endTime, nPoint, cycle, fo_c, fo_v, cq_c, sq_c, cq_h, pic);
                filename = repmat(files(i).name, 12, 1);
                label = repmat(rhyme, 12, 1);
                point = [1:12]';
                normTime = round(normTime', 2);
                temp = table(filename, label, normTime, point, nFoc, nFov, nCqc, nSqc, nCqh, nPic);
                data = vertcat(data, temp);  
                fprintf("%s done!\n", files(i).name)
            end
        end
    end
    data([1],:) = [];
    writetable(data, strcat(path, "cq.txt"), "Delimiter", "\t");
    
end