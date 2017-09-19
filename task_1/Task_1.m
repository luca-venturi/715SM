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
Y_train = Y(train,:);
Y_validation = Y(validation,:);
Y_validation_total = Y(validation_total,:);
Y_test = X_test*U_reduced;
x0 = [1e1;1e2;1e1];
ub = [1e10;1e10;1e10];
lb = [1e-10;1e-10;1e-10];
% save('dati.mat','Y_train','Y_validation','t_train','t_validation');
% [best_parameter,err] = fmincon(@test_err,x0,[],[],[],[],lb,ub);
% [mean,var,k] = GPregression_parameters(Y_train, t_train, best_parameter(1),best_parameter(2),best_parameter(3), Y_test, 'G')
% err = norm(mean-t_test')/norm(t_test)
% [best_parameter_n,err_n] = fmincon(@test_err_n,x0,[],[],[],[],lb,ub);
% [mean_n,var_n,k_n] = GPregression_parameters(Y_train, t_train, best_parameter_n(1),best_parameter_n(2),best_parameter_n(3), Y_test, 'G')
% err_n = norm(mean_n-t_test')/norm(t_test)
save('dati.mat','Y','t');
% optim_settage = optimoptions('fmincon','MaxIter',1000);
[best_parameter_0m,err_m] = fmincon(@test_err_m,x0,[],[],[],[],lb,ub);
[Y_train,t_train] = test_err_m_mod(best_parameter_m);
[mean_m,var_m,k_m] = GPregression_parameters(Y_train, t_train, best_parameter_m(1),best_parameter_m(2),best_parameter_m(3), Y_test, 'G')
err_m_fin = norm(mean_m-t_test')/norm(t_test)

% altra idea: peso errore su varianza

% PROVA GRAFICA
% Z_train = PCA(Y_train,1);
% z = linspace(floor(min(Z_train)),round(max(Z_train)),1001);
% [mean,var] = GPregression_parameters(Z_train, t_train, best_parameter(1),best_parameter(2),best_parameter(3), z, 'G');
% plot(Z_test,t_test,'ro',z,mean,'b')