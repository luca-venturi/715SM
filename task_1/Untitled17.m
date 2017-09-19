clear all
T = readtable('completeData.xlsx');
W = table2array(T(:,[6:30,32:101,119:121,126,128]));
X = W(:,1:99);
t = W(:,100);
n = size(t,1);
% n = round(size(t,1)/4);
train = [1:floor(.05*n)];
validation = [floor(.8*n)+1:floor(.9*n)];
validation_total = [floor(.05*n)+1:floor(.9*n)];
total = [1:floor(.9*n)];
test = [floor(.9*n)+1:n];
X = W(total,1:99);
X_train = W(train,1:99);
X_validation = W(validation,1:99);
X_validation_total = W(validation_total,1:99);
X_test = W(test,1:99);
t = W(total,100);
t_train= W(train,100);
t_validation = W(validation,100);
t_validation_total = W(validation_total,100);
t_test = W(test,100);
alpha1 = 0.75;
alpha2 = 0.9;
% [Y_train,m1,var_perc_gained1,U_reduced1] = PreProcessingForward(X_train,alpha1);
% disp('fatto')
% % [Y,m2,var_perc_gained2,U_reduced2] = PreProcessingForward(Y',alpha2);
% % disp('fatto')
% % Y = Y';
% % [Z,l1,var_perc_gained1,U_reduced1] = PreProcessingForward(X',alpha2);
% % disp('fatto')
% % [Z,l2,var_perc_gained2,U_reduced2] = PreProcessingForward(Z',alpha1);
% % disp('fatto')
% Y_validation = X_validation*U_reduced1;
% Y_validation_total = X_validation_total*U_reduced1;
% Y_test = X_test*U_reduced1;
m = 7;
disp('fatto')
[Y,U,U_reduced,L,L_reduced,var,var_reduced,alpha] = PCA(X,m);

[X1,X2] = meshgrid(0:0.2:1,0:0.2:1);
I = [reshape(X1,[],1),reshape(X2,[],1)];

gamma_gauss_model = 1;
[hyperparameters,S_N_inv,m_N] = optimal_hyperparameters_gauss_regression(t,X,I,gamma_gauss_model)
alpha = hyperparameters(1);
beta = hyperparameters(2);
