function err = test_err_m(parameter)

tic

h = 4;
l = 1/h;
load('dati.mat');
n = size(Y,1);
valid_set = zeros(h+1,1);
for i=1:h+1
    valid_set(i) = floor(n*((i-1)*l))+1;
end
for j=1:h
    for i=1:h
        Z_train = Y([valid_set(j):valid_set(j+1)-1],:);
        Z_val = Y([valid_set(i):valid_set(i+1)-1],:);
        tt_train = t([valid_set(j):valid_set(j+1)-1]);
        tt_val = t([valid_set(i):valid_set(i+1)-1]);
        [meanz,var] = GPregression_parameters(Z_train, tt_train, parameter(1), parameter(2), parameter(3), Z_val, 'G');
        errm(i,j) = norm(meanz-tt_val');
        errm_norm(i,j) = errm(i,j)/norm(tt_val);
end

err = max(max(errm));
err_norm = max(max(errm_norm))*1e3

disp('giro')
toc

end