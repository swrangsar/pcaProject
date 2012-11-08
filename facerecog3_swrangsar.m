close all; clear all;

cd ~/Desktop/pcaProject/

tic
pcaModified(50);
toc

plotPath = './resultsModified/';
imgFormat = '-dtiffn';

testDATA = orldata_test; % Get test images from orldata

%% Case 1: Test using trained image
% Fill to complete 3.(a)
% Use one image from the training data set 
load DATA;
modImgTrain = DATA(:, 3); % fill
figure; imshow( reshape(modImgTrain, 112, 92), []);
print(imgFormat, [plotPath 'modImgTrainS']);

% % Reconstruct the above image using the PCs
load psi;
zeroMeanImage = modImgTrain - psi;

load eigenFaces;
weightVector = eigenFaces' * zeroMeanImage;

modImgTrainEst = zeros(size(eigenFaces(:, 1)));
for k = 1:length(weightVector)
    modImgTrainEst = modImgTrainEst + (weightVector(k) * eigenFaces(:, k));
end

modImgTrainEst = modImgTrainEst + psi;
figure; imshow( reshape(modImgTrainEst, 112, 92), []);
print(imgFormat, [plotPath 'modImgTrainEstS']);
clear DATA; clear psi; clear eigenFaces;

img1_err = norm(modImgTrain - modImgTrainEst); % fill
trainModMSE = (img1_err * img1_err)/length(modImgTrainEst(:));
save trainModMSE trainModMSE;



%% Case 2: Test using a test image from orl data base



modImgTest = testDATA(:, 13);
% Fill to complete 3.(b)
figure; imshow( reshape(modImgTest, 112, 92), []);
print(imgFormat, [plotPath 'modImgTestS']);

% % Reconstruct the above image using the PCs
load psi;
zeroMeanImage = modImgTest - psi;

load eigenFaces;
weightVector = eigenFaces' * zeroMeanImage;


modImgTestEst = zeros(size(eigenFaces(:, 1)));
for k = 1:length(weightVector)
    modImgTestEst = modImgTestEst + (weightVector(k) * eigenFaces(:, k));
end

modImgTestEst = modImgTestEst + psi;
figure; imshow( reshape(modImgTestEst, 112, 92), []);
print(imgFormat, [plotPath 'modImgTestEstS']);
clear testDATA; clear psi; clear eigenFaces;

imgTestError = norm(modImgTest - modImgTestEst); % fill
testModMSE = (imgTestError * imgTestError)/length(modImgTestEst(:));
save testModMSE testModMSE;




%% Case 3: Test using your face image 
% Read in your image
% Fill to complete 3.(c)

load myImg
modmyImg = double(myImg(:));
figure; imshow( reshape(modmyImg, 112, 92), []);
print(imgFormat, [plotPath 'modmyImgS']);

% % Reconstruct the above image using the PCs
load psi;
zeroMeanImage = modmyImg - psi;

load eigenFaces;
weightVector = eigenFaces' * zeroMeanImage;


modmyImgEst = zeros(size(eigenFaces(:, 1)));
for k = 1:length(weightVector)
    modmyImgEst = modmyImgEst + (weightVector(k) * eigenFaces(:, k));
end

modmyImgEst = modmyImgEst + psi;
figure; imshow( reshape(modmyImgEst, 112, 92), []);
print(imgFormat, [plotPath 'modmyImgEstS']);
clear psi; clear eigenFaces;

myImgError = norm(modmyImg - modmyImgEst); % fill
myImgModMSE = (myImgError * myImgError)/length(modmyImg);
save myImgModMSE myImgModMSE;

% Generate plots to show original and reconstructed images