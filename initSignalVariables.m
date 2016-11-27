function [ signalVariables ] = initSignalVariables()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%没有多普勒频移的信号中频
signalVariables.IF = 4.1304e6;

%采样频率
signalVariables.samplingFre = 16.3676e6;

%C/A码频率
signalVariables.CodeFre = 2.046e6;


%C/A码长度
signalVariables.CodeLength = 2046;



end

