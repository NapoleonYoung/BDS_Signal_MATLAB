%���������ź�MATLAB������룺������
%�����signal:ĳ�������ź�

%�ź��ӳ٣��������źŵ��ӳ٣���������ɵ��ź����У����к�������ݰ��Ƶ�ǰ�棬��������źŵ��ӳ١�
%�����ǽ������Ľ��ز��ӳ��������֮�С�

clear all;
clc;

PRN_1 = input('���������Ǻ��Բ��������ǵ��źţ�');
%PRN_2 = input('���������Ǻ��Բ��������ǵ��źţ�');

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
sampledSignalCATable_1 = sampledCATable(PRN_1, :);
%sampledSignalCATable_2 = sampledCATable(PRN_2, :);

%-----�����ز��ź�------

carrySignal = round(sin(2 * pi * signalVariables.IF .* tCarry));
%�ӳ�n��֮һ������
%carrySignal_2 = round(sin(2 * pi * signalVariables.IF .* tCarry - 20 * pi));

%-----���������ز���C/A����ź�-----

signal_1 = sampledSignalCATable_1 .* carrySignal;

%һ��C/A��Ƭ����8�Σ����ڽ�����C/A�������ӳٰ˷�֮һ����Ƭ�����������е����һ��ֵ�Ƶ����е���λ
signal_2 = signal_1([samplesPerSignal 1 : (samplesPerSignal - 1)]);

signal =signal_2;
%signal = signal_1;
%signal = signal_1 + signal_2;

%subplot(3, 1, 1);
%plot(sampledSignalCATable);%ĳ�����ǵ�C/A���������
%subplot(3, 1, 2);
%plot(carrySignal);%�ز��ź�
%subplot(3, 1, 3);
%plot(signal);%�����ز���C/A����ź�

%-----�����������ݵ��ز���C/A���ź�����
%dataCASignal���������ݡ��ز���C/A��
%���У�����Ϊ1�� -1��ÿ20ms��һ��

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



