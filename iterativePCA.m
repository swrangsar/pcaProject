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
% [imageSize, dim] = size(data);
data = data';
scoreVector = data(:, randi(size(data,2)));
prevScoreVector = scoreVector;
difference = 1;

while difference > 1.0e-8
    loadingVector = (data' * scoreVector) / (scoreVector' * scoreVector);
    loadingVector = loadingVector / norm(loadingVector);
    prevScoreVector = scoreVector;
    scoreVector = (data * loadingVector) / (loadingVector' * loadingVector);
    difference = norm(prevScoreVector - scoreVector);
    principalComponent = loadingVector; 
    
    disp(['difference: ' num2str(iterationNumber) ' : ' num2str(difference)]);
end
disp('got a principal component...')

nextData = data - (scoreVector * principalComponent');
nextData = nextData';
principalComponent = principalComponent(:);

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



% %% get eigenvalue for a principal component
% 
% function eigenValue = getEigenValue(data, principalComponent)
% 
% dim = size(data, 2);
% % before subtracting principal component
% dataMean = mean(data, 2);
% dataDistance = data - repmat(dataMean, 1, dim);
% dataDistanceSquared = dataDistance .* dataDistance;
% dataDistanceSquaredSum = sum(dataDistanceSquared(:));
% % after subtracting principal component
% newData = data - repmat(principalComponent, 1, dim);
% newDataMean = mean(newData, 2);
% newDataDistance = newData - repmat(newDataMean, 1, dim);
% newDataDistanceSquared = newDataDistance .* newDataDistance;
% newDataDistanceSquaredSum = sum(newDataDistanceSquared(:));
% 
% eigenValue = abs(dataDistanceSquaredSum - newDataDistanceSquaredSum);
% 
% end
% 
% 
% 
% %% get eigenvalue matrix 
% function eigenValueVector = getEigenValueVector(data, principalComponentMatrix)
% 
% subDim = size(principalComponentMatrix, 2);
% eigenValueVector = zeros(subDim, 1);
% 
% for k = 1:subDim
%     eigenValueVector(k) = getEigenValue(data, principalComponentMatrix(:, k));
% end
% 
% end

