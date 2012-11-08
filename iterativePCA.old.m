function iterativePCA(data, subDim)

eigenFaces = getPrincipalComponentMatrix(data, subDim);
save eigenFaces eigenFaces;

% eigenValues = getEigenValueVector(data, eigenFaces);
% save eigenValues eigenValues;

end


%% get a principal component and the data for the next principal component
% calculation
function [principalComponent, nextData] = getPrincipalComponent(data, iterationNumber)

% generate random vector
[imageSize, dim] = size(data);
principalComponent = data(:, randi(dim));
difference = 1;
prevT = 0;
while difference > eps
    t = zeros(imageSize, 1);
    for m = 1:dim
        t = t + ((principalComponent' * data(:, m)) * (data(:, m)));
    end
    difference = abs(norm(t) - prevT);
    disp(['difference: ' num2str(iterationNumber) ' : ' num2str(difference)]);
    prevT = norm(t);
    principalComponent = t/norm(t);
end
disp('got a principal component...')

nextData = data - repmat(principalComponent, 1, dim);

end



%% get principal component matrix

function principalComponentMatrix = getPrincipalComponentMatrix(data, subDim)

imageSize = size(data, 1);

principalComponentMatrix = zeros(imageSize, subDim);
nextData = data;
for k = 1:subDim
    [principalComponent, nextData] = getPrincipalComponent(nextData, k);
    principalComponentMatrix(:, k) = principalComponent;
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

subDim = size(principalComponentMatrix, 2);
eigenValueVector = zeros(subDim, 1);

for k = 1:subDim
    eigenValueVector(k) = getEigenValue(data, principalComponentMatrix(:, k));
end

end

