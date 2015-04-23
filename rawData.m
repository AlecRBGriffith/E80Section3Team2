function rawData(filename)
% rawData.m

%Load the input file using the provided function
[X,Y] = ReadBinaryFileTX(filename,14,300000,3.3);
disp('Loaded data')

for i = 1:14
    subplot(3,5,i)
    plot(X(:,i),Y(:,i))
    ylim([0 4])
    disp(sprintf('Plotted %d',i));
end

