
%% step1
% 根据我方原计划出场顺序（12345）得到对方胜率最高的三种出场顺序
% 返回三个最优解胜率K以及对应的组合出场方式

% 导入数据
data = readmatrix('A582问题二.xlsx', 'Range', 'C4:L8');

% 对应的B队所有组合的标记
labels = {'B1B2', 'B1B3', 'B1B4', 'B1B5', 'B2B3', 'B2B4', 'B2B5', 'B3B4', 'B3B5', 'B4B5'};

% 初始化
BestSum = [];

% 调用找多组解的递归函数
BestSum = A582findMaxSums(data, labels, [], [], 0, {}, BestSum);

% 输出结果
fprintf('胜率最高的三种排序:\n');
for i = 1:min(3, length(BestSum))
    fprintf('%d: 胜率之和 = %f, 对方组合方式 = %s\n', i, BestSum(i).sum, strjoin(labels(BestSum(i).combination), ', '));
end


%% step2
% 根据对方胜率最高的组合的平均，得到我方的最优出场顺序
% 返回最优解胜率K以及对应的出场顺序

% 导入数据
data = readmatrix('A582问题二.xlsx', 'Range', 'P4:Y8');
% 对应的A队所有组合的标记
labels = {'A1A2', 'A1A3', 'A1A4', 'A1A5', 'A2A3', 'A2A4', 'A2A5', 'A3A4', 'A3A5', 'A4A5'};

maxSum = 0;

% 调用找单组解的递归函数
[BestSum, bestCombination] = A582findMaxSum(data, labels, [], [], 0, {});

% 输出结果
fprintf('符合要求的胜率求和最优解: %f\n', BestSum);
disp('我方最优出场顺序:');
disp(bestCombination);
