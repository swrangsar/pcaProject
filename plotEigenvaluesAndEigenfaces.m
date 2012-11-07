close all; clear all;

cd ~/Desktop/pcaProject/

tic
pca_orl(200);
toc

plotPath = './results/eigenFaces/';
imgFormat = '-dtiffn';



%% plotting eigenvalues
load pcaEigVals;
figure;
plot(pcaEigVals); axis tight;
title('Eigenvalus for PCA orl with subdimension 200');
ylabel('Magnitude of eigenvalues');
print(imgFormat, [plotPath 'eigenValues']);
clear pcaEigVals;


%% plotting eigenfaces

load w;
% plotting first 5 eigenfaces
numberOfEigenfaces = 7;

for k = 1:numberOfEigenfaces
    figure; imshow( reshape(w(:,k), 112, 92), []);
    print(imgFormat, [plotPath 'eigenface' num2str(k)]);
end
clear w;
