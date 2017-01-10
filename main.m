%北斗基带信号MATLAB仿真代码：主函数
%输出：signal:某颗卫星信号

%信号延迟：是整个信号的延迟，即产生完成的信号序列，序列后面的数据搬移到前面，即完成了信号的延迟。
%并不是将单独的将载波延迟例如二分之π。

clear all;
clc;

PRN_1 = input('请输入卫星号以产生该卫星的信号：');
%PRN_2 = input('请输入卫星号以产生该卫星的信号：');

%基带信号相关参数
signalVariables = initSignalVariables();

%-----计算每个采样点的时刻tCarry-----

%计算每个信号周期的总采样点数
samplesPerSignal = round(signalVariables.samplingFre / signalVariables.CodeFre * signalVariables.CodeLength);

%采样时间间隔
ts = 1 / signalVariables.samplingFre;

%计算每个采样时刻
tCarry = (0 : (samplesPerSignal - 1)) .* ts;

%-----提取某颗卫星C/A码采样数据-----

%所有卫星的总C/A码表
sampledCATable = makeSampledCATable(signalVariables);

%某颗卫星的C/A码采样数据
sampledSignalCATable_1 = sampledCATable(PRN_1, :);
%sampledSignalCATable_2 = sampledCATable(PRN_2, :);

%-----创建载波信号------

carrySignal = round(sin(2 * pi * signalVariables.IF .* tCarry));
%延迟n分之一个周期
%carrySignal_2 = round(sin(2 * pi * signalVariables.IF .* tCarry - 20 * pi));

%-----创建含有载波与C/A码的信号-----

signal_1 = sampledSignalCATable_1 .* carrySignal;

%一个C/A码片采样8次，现在将整个C/A码序列延迟八分之一个码片，即将码序列的最后一个值移到序列的首位
signal_2 = signal_1([samplesPerSignal 1 : (samplesPerSignal - 1)]);

signal =signal_2;
%signal = signal_1;
%signal = signal_1 + signal_2;

%subplot(3, 1, 1);
%plot(sampledSignalCATable);%某颗卫星的C/A码采样数据
%subplot(3, 1, 2);
%plot(carrySignal);%载波信号
%subplot(3, 1, 3);
%plot(signal);%含有载波与C/A码的信号

%-----创建含有数据的载波、C/A码信号数据
%dataCASignal：含有数据、载波、C/A码
%其中，数据为1， -1，每20ms变一次

fid = fopen('dataCASignal.bin', 'wb');
for j = 1 : 500
    if (mod(j, 2))
        for i = 1 : 20
            dataCASignal = 1 * signal;
            fwrite(fid, dataCASignal, 'int8');
        end
    else
        for i = 1 : 20
            dataCASignal = -1 * signal;
            fwrite(fid, dataCASignal, 'int8');
        end
    end
end

fclose(fid);



