
%%  step1
% 根据模型公式，计算出A队和B队队员的个人能力

syms a1 a2 a3 a4 a5;
% 根据公式 计算A队五人的得分能力
eq1 = a1^2 + a2^2 == ((21 + 21 + 21) / 3)^2;
eq2 = a1^2 + a3^2 == ((19 + 21 + 21) / 3)^2;
eq3 = a1^2 + a4^2 == ((18 + 21 + 21) / 3)^2;
eq4 = a1^2 + a5^2 == ((18 + 21 + 21) / 3)^2;
eq5 = a4^2 + a5^2 == ((21 + 14) / 2)^2;

s = solve([eq1, eq2, eq3, eq4, eq5], [a1, a2, a3, a4, a5]);
decimal_solutions = vpa([s.a1, s.a2, s.a3, s.a4, s.a5], 6);

disp("Ai 五人的得分能力:")
disp(vpa(decimal_solutions(32,:),6));

syms b1 b2 b3 b4 b5;
% 根据公式 计算B队五人的得分能力
eq1 = b1^2 + b2^2 == ((19 + 19 + 19) / 3)^2;
eq3 = b1^2 + b5^2 == ((21 + 14 + 16) / 3)^2;
eq5 = b2^2 + b3^2 == ((12 + 15) / 2)^2;
eq6 = b3^2 + b4^2 == ((21 + 19) / 2)^2;
eq7 = b4^2 + b5^2 == 14^2;

c = solve([eq1,eq3,eq5,eq6,eq7], [ b1, b2, b3, b4, b5]);
decimal_solutions = vpa([c.b1, c.b2, c.b3, c.b4, c.b5], 6);  % 指定精度为6位小数

disp("Bi 五人的得分能力:")
disp(vpa(decimal_solutions(32,:),6));


%% step2
% 根据对方出场顺序（12345）得到我方的最优出场顺序
% 返回最优解胜率K以及对应的出场顺序

% 从'问题一.xlsx'导入表1数据
data = readmatrix('A582问题一.xlsx', 'Range', 'C4:L8');

% 对应的A队所有组合的标记
labels = {'A1A2', 'A1A3', 'A1A4', 'A1A5', 'A2A3', 'A2A4', 'A2A5', 'A3A4', 'A3A5', 'A4A5'};

% 初始化最大胜率和
maxSum = 0;

% 调用找单组解的递归函数
[BestSum, bestCombination] = A582findMaxSum(data, labels, [], [], 0, {});

% 输出结果
fprintf('符合要求的胜率求和最优解: %f\n', BestSum);
disp('我方最优出场顺序:');
disp(bestCombination);
