function kernel = getGaussianKernel(dim, lengthscale, amplitude)
    
    kernel.dimension = dim;
    kernel.hyperparameter = [amplitude, lengthscale]; 
    kernel.hyp_dimension = 2;
    kernel.eval = @eval;
    
    function k = eval(x,y,kernel) 
        z = norm(x-y);
        k = kernel.hyperparameter(1) * exp(-z^2/kernel.hyperparameter(2)^2 );
    end

end
