function [Y,m,var_perc_gained,U_reduced] = PreProcessingForward(X,var_perc)

m = 0;
var_reduced = 0;
var = 1;
% riscalamento
while var_reduced/var < var_perc
    m = m +1;
    [Y,U,U_reduced,L,L_reduced,var,var_reduced] = PCA(X,m);
end
var_perc_gained = var_reduced/var;

end

