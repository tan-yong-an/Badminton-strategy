
%% step1
% 计算A6和B6的个人能力

syms x y;
% 计算A6的得分能力
qus = 15.7123^2+13.9329^2+3*x^2 == 21^2+((16+19)/2)^2+((17+21)/2)^2;
s = solve(qus,x);
A6 = vpa(s(2,:),6);
fprintf('A6的得分能力: %.4f\n', A6);

% 计算B6的得分能力
qus1 = 6.84653i^2+18.3269^2+5.01248^2+15.5844^2 +4*y^2 == ((20+17+21)/3)^2+((21+17+19)/3)^2+21^2+14^2;
p = solve(qus1,y);
B6 = vpa(p(2,:),6);
fprintf('B6的得分能力: %.4f\n\n',B6);


%% step2
% 以A队员平均能力来组队，评估B组合胜率最优解
% 返回胜率最高的十种排序对应的K和组合方式
% 得到B队要挑选的胜率最高的十种组合方式

% 导入数据
data = readmatrix('A582问题三.xlsx', 'Range', 'B4:K8');

% 对应的B队所有组合的标记
labels = {'B1B2', 'B1B3', 'B1B4', 'B1B6', 'B2B3', 'B2B4', 'B2B6', 'B3B4', 'B3B6', 'B4B6'};

% 初始化
BestSum = [];

% 调用找多组解的递归函数
BestSum = A582findMaxSums(data, labels, [], [], 0, {}, BestSum);

% 输出结果
fprintf('胜率最高的十种排序:\n');
for i = 1:min(10, length(BestSum))
    fprintf('%d: 胜率之和 = %f, B队组合方式 = %s\n', ...
        i, BestSum(i).sum, strjoin(labels(BestSum(i).combination), ', '));
end


%% step3
% 以B队挑选的十种组合方式的平均实力，得到A队最优排序
% 返回A队最优解胜率K以及对应的出场顺序

% 导入数据
data = readmatrix('A582问题三.xlsx', 'Range', 'N4:AB8');

% 对应的A队所有组合的标记
labels = {'A1A2', 'A1A3', 'A1A4', 'A1A5', 'A2A3', 'A2A4', 'A2A5', 'A3A4', 'A3A5', 'A4A5','A1A6','A2A6','A3A6','A4A6','A5A6'};

% 初始化
maxSum = 0;

% 调用找单组解的函数
[bestSum, bestComb] = A582findMaxSum(data, labels, [], {}, 0, {});

%输出结果
fprintf('符合要求的胜率求和最优解: %f\n', bestSum);
disp('A队最优出场顺序:');
disp(bestComb);


%% step4
% 以B队员平均能力来组队，评估A组合胜率最优解
% 返回胜率最高的十种排序对应的K和组合方式
% 得到A队要挑选的胜率最高的十种组合方式

% 导入数据
data = readmatrix('A582问题三.xlsx', 'Range', 'B13:P17');

% 对应的A队所有组合的标记
labels = {'A1A2', 'A1A3', 'A1A4', 'A1A5', 'A2A3', 'A2A4', 'A2A5', 'A3A4', 'A3A5', 'A4A5','A1A6','A2A6','A3A6','A4A6','A5A6'};

% 初始化
BestSum = [];

% 调用找多组解的递归函数
BestSum = A582findMaxSums(data, labels, [], [], 0, {}, BestSum);

% 输出结果
fprintf('胜率最高的十种排序:\n');
for i = 1:min(10, length(BestSum))
    fprintf('%d: 胜率之和 = %f, A队组合方式 = %s\n', i, BestSum(i).sum, strjoin(labels(BestSum(i).combination), ', '));
end


%% step5
% 以A队挑选的十种组合方式的平均实力，得到B队最优排序
% 返回B队最优解胜率K以及对应的出场顺序

% 导入数据
data = readmatrix('A582问题三.xlsx', 'Range', 'S13:AB17');

% 对应的A队所有组合的标记
labels = {'B1B2', 'B1B3', 'B1B4', 'B1B6', 'B2B3', 'B2B4', 'B2B6', 'B3B4', 'B3B6', 'B4B6'};

% 初始化
maxSum = 0;

% 调用找单组解的递归函数
[BestSum, bestCombination] = A582findMaxSum(data, labels, [], [], 0, {});

% 输出结果
fprintf('符合要求的胜率求和最优解: %f\n', BestSum);
disp('B队最优出场顺序:');
disp(bestCombination);
