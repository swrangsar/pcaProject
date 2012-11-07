close all; clear all;

cd ~/Desktop/pcaProject/

tic
pcaModified(200);
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


% 
% %% Case 2: Test using a test image from orl data base
% 
% 
% 
% orlImgTest = testDATA(:, 13);
% % Fill to complete 3.(b)
% figure; imshow( reshape(orlImgTest, 112, 92), []);
% print(imgFormat, [plotPath 'orlImgTestS']);
% 
% % % Reconstruct the above image using the PCs
% load psi;
% zeroMeanImage = orlImgTest - psi;
% 
% load w;
% weightVector = w' * zeroMeanImage;
% 
% 
% orlImgTestEst = zeros(size(w(:, 1)));
% for k = 1:length(weightVector)
%     orlImgTestEst = orlImgTestEst + (weightVector(k) * w(:, k));
% end
% 
% orlImgTestEst = orlImgTestEst + psi;
% figure; imshow( reshape(orlImgTestEst, 112, 92), []);
% print(imgFormat, [plotPath 'orlImgTestEstS']);
% clear testDATA; clear psi; clear w;
% 
% imgTestError = norm(orlImgTest - orlImgTestEst); % fill
% testMSE = (imgTestError * imgTestError)/length(orlImgTestEst(:));
% save testMSE testMSE;
% 
% 
% 
% 
% %% Case 3: Test using your face image 
% % Read in your image
% % Fill to complete 3.(c)
% 
% load myImg
% myImg = double(myImg(:));
% figure; imshow( reshape(myImg, 112, 92), []);
% print(imgFormat, [plotPath 'myImgS']);
% 
% % % Reconstruct the above image using the PCs
% load psi;
% zeroMeanImage = myImg - psi;
% 
% load w;
% weightVector = w' * zeroMeanImage;
% 
% 
% myImgEst = zeros(size(w(:, 1)));
% for k = 1:length(weightVector)
%     myImgEst = myImgEst + (weightVector(k) * w(:, k));
% end
% 
% myImgEst = myImgEst + psi;
% figure; imshow( reshape(myImgEst, 112, 92), []);
% print(imgFormat, [plotPath 'myImgEstS']);
% clear psi; clear w;
% 
% myImgError = norm(myImg - myImgEst); % fill
% myImgMSE = (myImgError * myImgError)/length(myImg);
% save myImgMSE myImgMSE;
% 
% % Generate plots to show original and reconstructed images