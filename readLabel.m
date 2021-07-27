function [rhyme, startTime, endTime] = readLabel(labelFile, tier)
% read label (TextGrid) files
% input:
% - labelFile: the directory of label files
% - tier: the number of the label tier
% output:
% - rhyme: the label of the rhyme
% - startTime: the start time of the rhyme portion
% - endTime: the end time

% read TextGrid file
tgfile = fopen(labelFile, "r");
n = 0;
while ~feof(tgfile)
    n = n + 1;
    tgText{n} = fgetl(tgfile);
end

fclose(tgfile);
for l = 1:n
    if startsWith(tgText{l}, "    item")
        ntier = extractBetween(tgText{l}, "[", "]");
        if str2double(ntier) == tier
            stier = l;
        elseif str2double(ntier) == tier + 1
            etier = l;
        else
            etier = n;
        end
    end
end
vpat = "[aei]{1,2}q?";
rn = 0;
for nl = stier:etier
    if startsWith(tgText{nl}, "            text = ")
        label = extractBetween(tgText{nl}, '"', '"');
        label = convertCharsToStrings(label);
        containRhyme = ~isempty(regexp(label, vpat, 'once'));
        if containRhyme
            rn = nl;
        else
            nrn = nl;
        end
    end
end
if rn
    label = extractBetween(tgText{rn}, '"', '"');
    rhyme = convertCharsToStrings(label);
    startTime = str2double(erase(tgText{rn-2}, "xmin = "));
    endTime = str2double(erase(tgText{rn-1}, "xmax = "));
else
   rhyme = "NA";
   startTime = 0;
   endTime = 0;
end
end
