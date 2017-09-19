function err = test_err(parameter)

tic
load('dati.mat');
[mean,var] = GPregression_parameters(Y_train, t_train, parameter(1), parameter(2), parameter(3), Y_validation, 'G');
% X_validation = Y*U_reduced';
% s = norm(t_validation);
% err = norm(mean-t_validation')/s*(1e6);
% err = norm(mean-t_validation')*(1e10);
err = norm(mean-t_validation');
% err*(1e-10)/norm(t_validation)
err/norm(t_validation)
% err = 0;
% for j=1:r
%     if 
disp('giro')

toc

end

