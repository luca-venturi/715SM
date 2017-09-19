function [mean,var,k,d] = GPregression_parameters(X, t, hyperparameters_1, hyperparameters_2, sigma, x, type)

n = length(t);
d = size(x,1);

if type == 'G' 
    kernel = getGaussianKernel(n, hyperparameters_1, hyperparameters_2);
elseif type == 'M'
    kernel = getMaternKernel(n, hyperparameters_1, hyperparameters_2);
elseif type == 'A'
    kernel = getARDGaussianKernel(n, hyperparameters_1, hyperparameters_2);
end
eval = kernel.eval;

K = zeros(n);
k = zeros(n,d);
for i=1:n
    for j=1:n
        K(i,j) = eval(X(i,:),X(j,:),kernel);
    end
    for j=1:d
        k(i,j) = eval(x(j,:),X(i,:),kernel);
    end
end
I = diag(ones(1,n));
L = chol(K + sigma^2*I);
q = L'\(L\t);

mean = zeros(1,d);
var = zeros(1,d);
for j=1:d
    mean(1,j) = k(:,j)'*q;
    var(j) = eval(x(j,:),x(j,:),kernel) - k(:,j)'*(L'\(L\k(:,j)));
end

end
