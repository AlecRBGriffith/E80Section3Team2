function rawData(filename)
% this function plots the data from a .DAT data file produced by the
% datalogger
% 
% Inputs:
%     - filename: a string, the full filename of the input .DAT file

% Load the input file using the provided function
[X,Y] = ReadBinaryFileTX(filename,12,120000,3.3);
disp('Loaded data')

% plot all 14 channels in a single subplot
for i = 1:12
    subplot(3,4,i)
    plot(X(:,i),Y(:,i))
    ylim([-1 4])
    fprintf('Plotted %d\n',i);
end

