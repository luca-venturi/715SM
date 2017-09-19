function [X_reduced,U,U_reduced,L,L_reduced,var,var_reduced,alpha] = PCA(X,m)

d = length(X(1,:));
N = length(X(:,1));

x = mean(X)';
S = zeros(d);
for i=1:N
    S = S + (X(i,:)'-x)*(X(i,:)'-x)';
end
S = S/N;

[U,L] = eig(S,'vector');
[L,ordine] = sort(L,'descend');
U = U(:,ordine);
[U_reduced,L_reduced] = eigs(S,m);
L_reduced = diag(L_reduced);

% var = sqrt(sum(L.^2));
% var = sum(L);
var = trace(S);
% var_reduced = sqrt(sum(L_reduced.^2));
% var_reduced = sum(L_reduced);
var_reduced = trace(U_reduced'*S*U_reduced);
X_reduced = X*U_reduced;
alpha = var_reduced/var;

end