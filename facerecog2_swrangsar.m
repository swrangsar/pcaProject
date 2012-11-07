close all; clear all;

cd ~/Desktop/pcaProject/

tic
pca_orl(100);
toc

plotPath = './results/subDim100/';

testDATA = orldata_test; % Get test images from orldata

%% Case 1: Test using trained image
% Fill to complete 3.(a)
% Use one image from the training data set 
load DATA;
orlImgTrain = DATA(:, 3); % fill
figure; imshow( reshape(orlImgTrain, 112, 92), []);
print('-dtiffn', [plotPath 'orlImgTrain100']);

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
print('-dtiffn', [plotPath 'orlImgTrainEst100']);
clear DATA; clear psi; clear w;

img1_err = norm(orlImgTrain - orlImgTrainEst); % fill
trainMSE100 = (img1_err * img1_err)/length(orlImgTrainEst(:));
save trainMSE100 trainMSE100;



%% Case 2: Test using a test image from orl data base



orlImgTest = testDATA(:, 13);
% Fill to complete 3.(b)
figure; imshow( reshape(orlImgTest, 112, 92), []);
print('-dtiffn', [plotPath 'orlImgTest100']);

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
print('-dtiffn', [plotPath 'orlImgTestEst100']);
clear testDATA; clear psi; clear w;

imgTestError = norm(orlImgTest - orlImgTestEst); % fill
testMSE100 = (imgTestError * imgTestError)/length(orlImgTestEst(:));
save testMSE100 testMSE100;




%% Case 3: Test using your face image 
% Read in your image
% Fill to complete 3.(c)

load myImg
myImg = double(myImg(:));
figure; imshow( reshape(myImg, 112, 92), []);
print('-dtiffn', [plotPath 'myImg100']);

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
print('-dtiffn', [plotPath 'myImgEst100']);
clear psi; clear w;

myImgError = norm(myImg - myImgEst); % fill
myImgMSE100 = (myImgError * myImgError)/length(myImg);
save myImgMSE100 myImgMSE100;



% Generate plots to show original and reconstructed images

