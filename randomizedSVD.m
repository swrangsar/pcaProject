function randomizedSVD(data, subDim)

[m, n] = size(data);
Omega = randn(n, subDim);
Y = data * Omega;
clear Omega;
[Q, R] = qr(Y);
clear Y R;
B = Q' * data;
[Uhat, Sigma, V] = svd(B);
clear V;
U = Q * Uhat;
clear Uhat Q;

eigenFaces = U;
save eigenFaces eigenFaces;

% eigenValues = diag(Sigma);
% save eigenValues eigenValues;

end