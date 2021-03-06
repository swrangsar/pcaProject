close all; clear all;

cd ~/Desktop/pcaProject/

tic
pca_orl(200);
toc

plotPath = './results/';
imgFormat = '-dtiffn';

testDATA = orldata_test; % Get test images from orldata

%% Case 1: Test using trained image
% Fill to complete 3.(a)
% Use one image from the training data set 
load DATA;
orlImgTrain = DATA(:, 3); % fill
figure; imshow( reshape(orlImgTrain, 112, 92), []);
print(imgFormat, [plotPath 'orlImgTrainS']);

% % Reconstruct the above image using the PCs
load psi;
zeroMeanImage = orlImgTrain - psi;

load w;
weightVector = w' * zeroMeanImage;

orlImgTrainEst = zeros(size(w(:, 1)));
for k = 1:length(weightVector)
    orlImgTrainEst = orlImgTrainEst + (weightVector(k) * w(:, k));
end

orlImgTrainEst = orlImgTrainEst + psi;
figure; imshow( reshape(orlImgTrainEst, 112, 92), []);
print(imgFormat, [plotPath 'orlImgTrainEstS']);
clear DATA; clear psi; clear w;

img1_err = norm(orlImgTrain - orlImgTrainEst); % fill
trainMSE = (img1_err * img1_err)/length(orlImgTrainEst(:));
save trainMSE trainMSE;



%% Case 2: Test using a test image from orl data base



orlImgTest = testDATA(:, 13);
% Fill to complete 3.(b)
figure; imshow( reshape(orlImgTest, 112, 92), []);
print(imgFormat, [plotPath 'orlImgTestS']);

% % Reconstruct the above image using the PCs
load psi;
zeroMeanImage = orlImgTest - psi;

load w;
weightVector = w' * zeroMeanImage;


orlImgTestEst = zeros(size(w(:, 1)));
for k = 1:length(weightVector)
    orlImgTestEst = orlImgTestEst + (weightVector(k) * w(:, k));
end

orlImgTestEst = orlImgTestEst + psi;
figure; imshow( reshape(orlImgTestEst, 112, 92), []);
print(imgFormat, [plotPath 'orlImgTestEstS']);
clear testDATA; clear psi; clear w;

imgTestError = norm(orlImgTest - orlImgTestEst); % fill
testMSE = (imgTestError * imgTestError)/length(orlImgTestEst(:));
save testMSE testMSE;




%% Case 3: Test using your face image 
% Read in your image
% Fill to complete 3.(c)

load myImg
myImg = double(myImg(:));
figure; imshow( reshape(myImg, 112, 92), []);
print(imgFormat, [plotPath 'myImgS']);

% % Reconstruct the above image using the PCs
load psi;
zeroMeanImage = myImg - psi;

load w;
weightVector = w' * zeroMeanImage;


myImgEst = zeros(size(w(:, 1)));
for k = 1:length(weightVector)
    myImgEst = myImgEst + (weightVector(k) * w(:, k));
end

myImgEst = myImgEst + psi;
figure; imshow( reshape(myImgEst, 112, 92), []);
print(imgFormat, [plotPath 'myImgEstS']);
clear psi; clear w;

myImgError = norm(myImg - myImgEst); % fill
myImgMSE = (myImgError * myImgError)/length(myImg);
save myImgMSE myImgMSE;

% Generate plots to show original and reconstructed images