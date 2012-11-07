function iterativePCA(data, subDim)

principalComponentMatrix = getPrincipalComponentMatrix(data, subDim);
save eigenFaces principalComponentMatrix;

eigenValueVector = getEigenValueVector(data, principalComponentMatrix);
save eigenValues eigenValueVector;
clear principalComponentMatrix eigenValueVector;

end


%% get a principal component and the data for the next principal component
% calculation
function [principalComponent, nextData] = getPrincipalComponent(data)

% generate random vector
[imageSize, dim] = size(data);
principalComponent = rand(imageSize, 1);

numberOfIterations = 10;
for k = 1:numberOfIterations
    t = zeros(imageSize, 1);
    for m = 1:dim
        t = t + ((principalComponent' * data(:, m)) * (data(:, m)));
    end
%     norm(t)
    principalComponent = t/norm(t);
end

nextData = data - repmat(principalComponent, 1, dim);

end



%% get principal component matrix

function principalComponentMatrix = getPrincipalComponentMatrix(data, subDim)

[imageSize, dim] = size(data);

principalComponentMatrix = zeros(imageSize, min(subDim, dim));
nextData = data;
for k = 1:subDim
    [principalComponent, nextData] = getPrincipalComponent(nextData);
    principalComponentMatrix(:, k) = principalComponent;
    if subDim == k
        break;
    end
end

end



%% get eigenvalue for a principal component

function eigenValue = getEigenValue(data, principalComponent)

dim = size(data, 2);
% before subtracting principal component
dataMean = mean(data, 2);
dataDistance = data - repmat(dataMean, 1, dim);
dataDistanceSquared = dataDistance .* dataDistance;
dataDistanceSquaredSum = sum(dataDistanceSquared(:));
% after subtracting principal component
newData = data - repmat(principalComponent, 1, dim);
newDataMean = mean(newData, 2);
newDataDistance = newData - repmat(newDataMean, 1, dim);
newDataDistanceSquared = newDataDistance .* newDataDistance;
newDataDistanceSquaredSum = sum(newDataDistanceSquared(:));

eigenValue = abs(dataDistanceSquaredSum - newDataDistanceSquaredSum);

end



%% get eigenvalue matrix 
function eigenValueVector = getEigenValueVector(data, principalComponentMatrix)

[~, subDim] = size(principalComponentMatrix);
eigenValueVector = zeros(subDim, 1);

for k = 1:subDim
    eigenValueVector(k) = getEigenValue(data, principalComponentMatrix(:, k));
end

end

