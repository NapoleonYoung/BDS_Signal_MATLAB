%北斗C/A码发生器
%产生北斗1号卫星的伪随机码
clear;
prn = input('please input the number:');
idSatelite = [1,3; 1,4; 1,5; 1,6; 1,8; 1,9; 1,10; 1,11; %8颗
              2,7;                                      %1颗
              3,4; 3,5; 3,6; 3,8; 3,9; 3,10; 3,11;      %7颗
              4,5; 4,6; 4,8; 4,9; 4,10; 4,11;           %6颗
              5,6; 5,8; 5,9; 5,10; 5,11;                %5颗
              6,8; 6,9; 6,10; 6,11;                     %4颗
              8,9; 8,10; 8,11;                          %3颗
              9,10; 9,11;                               %2颗
              10,11];                                   %1颗

%G1发生器

%G1序列线性移位反馈器初始值01010101010
regOfG1=[1,-1,1,-1,1,-1,1,-1,1,-1,1];
for i=1:2047;
    g1(i)=regOfG1(11);
    firstBitofG1=regOfG1(1)*regOfG1(7)*regOfG1(8)*regOfG1(9)*regOfG1(10)*regOfG1(11);
    regOfG1(2:11)=regOfG1(1:10);
    regOfG1(1)=firstBitofG1;           %G1产生器
end
%G2发生器
regOfG2=[1,-1,1,-1,1,-1,1,-1,1,-1,1];
for j=1:2047;
    g2Oup(j) = regOfG2(idSatelite(prn, 1)) * regOfG2(idSatelite(prn, 2));
    firstBit=regOfG2(1)*regOfG2(2)*regOfG2(3)*regOfG2(4)*regOfG2(5)*regOfG2(8)*regOfG2(9)*regOfG2(11);
    regOfG2(2:11)=regOfG2(1:10);
    regOfG2(1)=firstBit;
end

ca=g1.*g2Oup;

ind1=find(ca==-1);                     %找到-1（实际是0，1中的1）所在的坐标
ind2=find(ca==1);                      %找到1（实际是0，1中的0）所在的坐标
caOutput(ind1)=ones(1,length(ind1));                          
caOutput(ind2)=zeros(1,length(ind2));           %变换0，1 

ca_Binary=caOutput(1)*2^9+caOutput(2)*2^8+caOutput(3)*2^7+caOutput(4)*2^6+caOutput(5)*2^5+caOutput(6)*16+caOutput(7)*8+caOutput(8)*4+caOutput(9)*2+caOutput(10);%将C/A码序列前十个码片转换为一个十进制数
ca_Octonary=dec2base(ca_Binary,8)%将上一步所得的十进制数转换为一个八进制数
caOutput


