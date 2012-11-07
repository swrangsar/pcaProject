function pcaModified(subDim)

% using orldata_train code 
%
% RELATED FUNCTIONS (SEE ALSO)
% pgma_read, orldata, orldata_test, orldata_train 
% 
% ABOUT
% Created:        03 Sep 2005
% Last Update:    -
% Revision:       1.0
% 
% AUTHOR:   Kresimir Delac
% mailto:   kdelac@ieee.org
% URL:      http://www.vcl.fer.hr/kdelac
%
% WHEN PUBLISHING A PAPER AS A RESULT OF RESEARCH CONDUCTED BY USING THIS CODE
% OR ANY PART OF IT, MAKE A REFERENCE TO THE FOLLOWING PAPER:
% Delac K., Grgic M., Grgic S., Independent Comparative Study of PCA, ICA, and LDA 
% on the FERET Data Set, International Journal of Imaging Systems and Technology,
% Vol. 15, Issue 5, 2006, pp. 252-260
%

global imloadfunc;

imloadfunc =  'pgma_read'; 
disp(' ');
disp('Running PCA modified by Swrangsar Basumatary')

DATA = orldata_train;
save DATA DATA;
[imageSize, numberOfImages] = size(DATA);
imageSpace = DATA;
save imageSpace imageSpace;
%clear DATA;

% Calculating mean face from training images
fprintf('Zero mean\n')
psi = mean(imageSpace, 2);
disp('psi calculated')
save psi psi;

dim = numberOfImages;
zeroMeanSpace = zeros(size(imageSpace));
for k = 1:dim
    zeroMeanSpace(:, k) = double(imageSpace(:, k)) - psi;
end
save zeroMeanSpace zeroMeanSpace;
clear imageSpace;
disp('zeroMeanSpace calculated')

L = zeroMeanSpace' * zeroMeanSpace;


% % tempSpace = zeroMeanSpace'/sqrt(dim - 1);
% % [~, S, V] = svd(tempSpace);
% % clear zeroMeanSpace;
% % clear tempSpace;
% % disp('svd done')
% % 
% % % the eigenvalues
% % S = diag(S);
% % eigenValues = S .* S;
% % save eigenValues eigenValues;
% % clear S;
% % eigenFaces = V;
% % save eigenFaces eigenFaces;
% % 
% % clear V;
% % eigenFaces = eigenFaces(:, 1:subDim);
% % load zeroMeanSpace;
% % projectedData = eigenFaces' * zeroMeanSpace;
% % clear zeroMeanSpace;
% % clear psi;
% % eigenValues = eigenValues(:, 1:subDim);
% % clear eigenValues;
% % save projectedData projectedData;
% % clear eigenValues eigenFaces projectedData;

end