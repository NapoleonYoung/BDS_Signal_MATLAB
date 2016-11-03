
signalVariables = initSignalVariables();

%计算一个周期的C/A码总的采样点数
samplesPerPeriod = round(signalVariables.samplingFre / signalVariables.CodeFre * signalVariables.CodeLength);

%输出的采样C/A码后点
sampledCATable = zeros(37, samplesPerPeriod);

%采样一次的时间长度
ts = 1 / signalVariables.samplingFre;

%一个码片的时间长度
tc = 1 / signalVariables.CodeFre;

%PRN = 37原因：37颗卫星
for PRN = 1 : 37
    
    %产生C/A码
    CACode = generareCACode(PRN);
    
    %-----数字化C/A码-----
    
    %产生采样C/A码的位置坐标
    codeValueIndex = ceil((ts / tc) * (1 : samplesPerPeriod));
    
    %最后一个采样点所采的位置一定是C/A最后一个值
    codeValueIndex(end) = signalVariables.CodeLength;
    
    sampledCATable(PRN, :) =  CACode(codeValueIndex);
end
x = input('please input PRN');
sampledCATable(x, :)
