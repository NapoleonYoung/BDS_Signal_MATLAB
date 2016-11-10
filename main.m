%北斗基带信号MATLAB仿真代码：主函数
%输出：signal:某颗卫星信号

clear all;
clc;

PRN = input('请输入卫星号以产生该卫星的信号：');

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
sampledSignalCATable = sampledCATable(PRN, :);


%-----创建载波信号------

carrySignal = round(sin(2 * pi * signalVariables.IF .* tCarry));

%-----创建含有载波与C/A码的信号-----

signal = sampledSignalCATable .* carrySignal;


%subplot(3, 1, 1);
%plot(sampledSignalCATable);%某颗卫星的C/A码采样数据
%subplot(3, 1, 2);
%plot(carrySignal);%载波信号
%subplot(3, 1, 3);
%plot(signal);%含有载波与C/A码的信号



