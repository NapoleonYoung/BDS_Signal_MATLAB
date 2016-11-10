%���������ź�MATLAB������룺������
%�����signal:ĳ�������ź�

clear all;
clc;

PRN = input('���������Ǻ��Բ��������ǵ��źţ�');

%�����ź���ز���
signalVariables = initSignalVariables();

%-----����ÿ���������ʱ��tCarry-----

%����ÿ���ź����ڵ��ܲ�������
samplesPerSignal = round(signalVariables.samplingFre / signalVariables.CodeFre * signalVariables.CodeLength);

%����ʱ����
ts = 1 / signalVariables.samplingFre;

%����ÿ������ʱ��
tCarry = (0 : (samplesPerSignal - 1)) .* ts;

%-----��ȡĳ������C/A���������-----

%�������ǵ���C/A���
sampledCATable = makeSampledCATable(signalVariables);

%ĳ�����ǵ�C/A���������
sampledSignalCATable = sampledCATable(PRN, :);


%-----�����ز��ź�------

carrySignal = round(sin(2 * pi * signalVariables.IF .* tCarry));

%-----���������ز���C/A����ź�-----

signal = sampledSignalCATable .* carrySignal;


%subplot(3, 1, 1);
%plot(sampledSignalCATable);%ĳ�����ǵ�C/A���������
%subplot(3, 1, 2);
%plot(carrySignal);%�ز��ź�
%subplot(3, 1, 3);
%plot(signal);%�����ز���C/A����ź�



