close all; clear all;

cd ~/Desktop/pcaProject/


pca_orl(200);

plotPath = './results/';

% testDATA = orldata_test; % Get test images from orldata

%% Case 1: Test using trained image
% Fill to complete 3.(a)
% Use one image from the training data set 
load DATA;
img1 = DATA(:, 3); % fill
figure; imshow( reshape(img1, 112, 92), []);
print('-dtiffn', [plotPath 'orlImgTrain']);
orlImgTrain = img1;

% % Reconstruct the above image using the PCs
load psi;
zeroMeanImage = img1 - psi;

load w;
weightVector = w' * zeroMeanImage;

load pcaProj;
weightVectorDifferenceMat = pcaProj - repmat(weightVector, 1, size(pcaProj, 2));

faceClassErrors = zeros(size(weightVectorDifferenceMat, 2), 1);
for k = 1:size(weightVectorDifferenceMat, 2)
    faceClassErrors(k) = norm(weightVectorDifferenceMat(:, k));
end

[minError, minIndex] = min(faceClassErrors);
weightVectorEstimate = pcaProj(:, minIndex);
img1_est = zeros(size(w(:, 1)));
for k = 1:length(weightVectorEstimate)
    img1_est = img1_est + (weightVectorEstimate(k) * w(:, k));
end

img1_est = img1_est + psi;
figure; imshow( reshape(img1_est, 112, 92), []);
print('-dtiffn', [plotPath 'orlImgTrainEst']);
clear DATA; clear psi; clear w; clear pcaProj;
orlImgTrainEst = img1_est;

img1_err = norm(img1 - img1_est); % fill
trainMSE = (img1_err * img1_err)/length(img1(:));
save trainMSE trainMSE;

% % Case 2: Test using a test image from orl data base
% orlImgTest = testDATA(:,8);
% % Fill to complete 3.(b)
% 
% 
% % Case 3: Test using your face image 
% % Read in your image
% % Fill to complete 3.(c)
% 
% 
% % Generate plots to show original and reconstructed images
% 
