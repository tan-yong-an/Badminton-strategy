% 编写递归函数，寻找 1.每个队员出现两次2.所选组合的队员能连贯比赛3.约束下的胜率求和最大
function [BestSum, bestComb] = A582findMaxSum(data, labels, currentComb, usedLabels, currentSum, lastRowLabels)
    % 初始化最大和和最优组合
    BestSum = -inf;
    bestComb = {};
    % 当前组合的长度为5时，说明已经选择了5组比赛
    if length(currentComb) == 5
        % 计算每个标签出现的次数
        labelCounts = histcounts(categorical(usedLabels));
        % 如果每个标签都出现了两次，说明是一个有效的组合
        if all(labelCounts == 2)
            % 当前总胜率求和即为最大值
            BestSum = currentSum;
            % 转换组合中的标签为格式化字符串
            formattedComb = formatCombination(labels(currentComb));
            bestComb = formattedComb;
            return;
        else
            return;% 结束递归
        end
    end

    % 遍历数据的每一列
    for i = 1:size(data, 2)
        % 确保当前列未被选中
        if ~ismember(i, currentComb)
            % 获取当前标签，并添加到已使用的标签中
            newLabels = regexp(labels{i}, '[A-B]\d', 'match');
            tempLabels = [usedLabels newLabels];
            % 计算每个标签出现的次数
            labelCounts = histcounts(categorical(tempLabels));        
            % 检查新的标签情况，如果每个标签出现次数都不超过2次，且当前标签与上一行选择的标签有交集 或为第一行
            if all(labelCounts <= 2) && (isempty(lastRowLabels) || any(ismember(newLabels, lastRowLabels)))
                % 更新当前组合和总和
                newComb = [currentComb, i];
                newSum = currentSum + data(length(newComb), i);
                % 递归调用，寻找更大的和
                [tempSum, tempComb] = A582findMaxSum(data, labels, newComb, tempLabels, newSum, newLabels);
                % 如果找到了更大的和，则更新局部最大和和最优组合
                if tempSum > BestSum
                    BestSum = tempSum;
                    bestComb = tempComb;
                end
            end
        end
    end

end

% 将组合中的标签转换为格式化字符串 {A1, A2, ...}
function formattedComb = formatCombination(combination)
    formattedComb = ['{' strjoin(combination, ', ') '}'];
end
