function err = test_err_n(parameter)

tic

h = 8;
l = 1/h;
load('dati.mat');
n = size(Y_validation,1);
valid_set = zeros(h+1,1);
for i=1:h+1
    valid_set(i) = floor(n*((i-1)*l))+1;
end
for i=1:h
    Z = Y_validation([valid_set(i):valid_set(i+1)-1],:);
    tt = t_validation([valid_set(i):valid_set(i+1)-1]);
    [meanz,var] = GPregression_parameters(Y_train, t_train, parameter(1), parameter(2), parameter(3), Z, 'G');
    % X_validation = Y*U_reduced';
    % s = norm(t_validation);
    % err = norm(mean-t_validation')/s*(1e6);
    % err = norm(mean-t_validation')*(1e10);
    errv(i) = norm(meanz-tt');
    % err*(1e-10)/norm(t_validation)
    errv_norm(i) = errv(i)/norm(tt);
    % err = 0;
    % for j=1:r
    %     if
end

% err = norm(errv);
% err_norm = norm(errv_norm)
err = mean(errv);
err_norm = mean(errv_norm)

disp('giro')
toc

end

