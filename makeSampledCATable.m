function [ sampledCATable ] = makeSampledCATable( signalVariables )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

%����һ�����ڵ�C/A���ܵĲ�������
samplesPerPeriod = round(signalVariables.samplingFre / signalVariables.CodeFre * signalVariables.CodeLength);

%����Ĳ���C/A����
sampledCATable = zeros(37, samplesPerPeriod);

%����һ�ε�ʱ�䳤��
ts = 1 / signalVariables.samplingFre;

%һ����Ƭ��ʱ�䳤��
tc = 1 / signalVariables.CodeFre;

%PRN = 37ԭ��37������
for PRN = 1 : 37
    
    %����C/A��
    CACode = generareCACode(PRN);
    
    %-----���ֻ�C/A��-----
    
    %��������C/A���λ������
    codeValueIndex = ceil((ts / tc) * (1 : samplesPerPeriod));
    
    %���һ�����������ɵ�λ��һ����C/A���һ��ֵ
    codeValueIndex(end) = signalVariables.CodeLength;
    
    sampledCATable(PRN, :) =  CACode(codeValueIndex);
end
    
end

