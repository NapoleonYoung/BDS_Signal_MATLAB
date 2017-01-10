BDS_Signal_MATLAB

北斗基带信号MATLAB仿真代码

### 工程文件说明

工程函数

- generareCACode.m：北斗C/A码发生器
- makeSampledCATable.m：对C/A码进行采样
- main.m：创建含有数据、载波与C/A码的信号，工程主函数，其中，数据为1，－1，每20ms变一次，一共持续10s

验证函数

- BDS_CaOutput_binary.m：根据输入的卫星号产生北斗基带信号C/A码
- digitalCA.m：采样C/A码，即数字化C/A码表

### 版本说明

- v1.06:产生正常北斗信号、延迟的北斗信号（多路径信号）
- v1.05:产生北斗信号