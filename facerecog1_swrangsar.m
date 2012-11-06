close all; clear all;

cd ~/Desktop/pcaProject/


pca_orl(200);

testDATA = orldata_test; % Get test images from orldata

% Case 1: Test using trained image
% Fill to complete 3.(a)
% Use one image from the training data set 
img1 = DATA(); % fill
% Reconstruct the above image using the PCs
img1_est = ; % fill
img1_err = ; % fill

% Case 2: Test using a test image from orl data base
orlImgTest = testDATA(:,8);
% Fill to complete 3.(b)


% Case 3: Test using your face image 
% Read in your image
% Fill to complete 3.(c)


% Generate plots to show original and reconstructed images

