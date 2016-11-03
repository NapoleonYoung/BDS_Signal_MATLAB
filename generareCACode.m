function [ caCode ] = generareCACode( PRN )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%����C/A�뷢����
%��������1�����ǵ�α�����
idSatelite = [1,3; 1,4; 1,5; 1,6; 1,8; 1,9; 1,10; 1,11; %8��
              2,7;                                      %1��
              3,4; 3,5; 3,6; 3,8; 3,9; 3,10; 3,11;      %7��
              4,5; 4,6; 4,8; 4,9; 4,10; 4,11;           %6��
              5,6; 5,8; 5,9; 5,10; 5,11;                %5��
              6,8; 6,9; 6,10; 6,11;                     %4��
              8,9; 8,10; 8,11;                          %3��
              9,10; 9,11;                               %2��
              10,11];                                   %1��

%G1������

%G1����������λ��������ʼֵ01010101010
regOfG1=[1,-1,1,-1,1,-1,1,-1,1,-1,1];
for i=1:2047;
    g1(i)=regOfG1(11);
    firstBitofG1=regOfG1(1)*regOfG1(7)*regOfG1(8)*regOfG1(9)*regOfG1(10)*regOfG1(11);
    regOfG1(2:11)=regOfG1(1:10);
    regOfG1(1)=firstBitofG1;           %G1������
end
%G2������
regOfG2=[1,-1,1,-1,1,-1,1,-1,1,-1,1];
for j=1:2047;
    g2Oup(j) = regOfG2(idSatelite(PRN, 1)) * regOfG2(idSatelite(PRN, 2));
    firstBit=regOfG2(1)*regOfG2(2)*regOfG2(3)*regOfG2(4)*regOfG2(5)*regOfG2(8)*regOfG2(9)*regOfG2(11);
    regOfG2(2:11)=regOfG2(1:10);
    regOfG2(1)=firstBit;
end

caCode=-1 * (g1.*g2Oup);
end

