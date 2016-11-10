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



