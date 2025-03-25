% 对于要输出多组解的，需要适当修改以上递归函数
function BestSum = A582findMaxSums(data, labels, currentComb, usedLabels, currentSum, lastRowLabels, BestSum)
    if length(currentComb) == 5
        labelCounts = histcounts(categorical(usedLabels));
        if all(labelCounts == 2)
            % 对新结果赋予sum和combi属性，便于输出前三的结果
            newResult.sum = currentSum;
            newResult.combination = currentComb;
            % 调用topResults函数，将函数输出的前三赋给BestSum
            BestSum = Results(BestSum, newResult);
            return;
        else
            return;
        end
    end
    for i = 1:size(data, 2)
        if ~ismember(i, currentComb)
            newLabels = regexp(labels{i}, '[A-B]\d', 'match');
            tempLabels = [usedLabels newLabels];
            labelCounts = histcounts(categorical(tempLabels));
            if all(labelCounts <= 2) && (isempty(lastRowLabels) || any(ismember(newLabels, lastRowLabels)))
                newComb = [currentComb, i];
                newSum = currentSum + data(length(newComb), i);
                BestSum = A582findMaxSums(data, labels, newComb, tempLabels, newSum, newLabels, BestSum);
            end
        end
    end

end

function TopResults = Results(TopResults, newResult)
    % 将新结果添加到结果集
    TopResults = [TopResults, newResult];
    % 将各结果按降序排序
    [~, index] = sort([TopResults.sum], 'descend');
    TopResults = TopResults(index);
    % 只保留前三个最大值
    if length(TopResults) > 10
        TopResults = TopResults(1:10);
    end
end

