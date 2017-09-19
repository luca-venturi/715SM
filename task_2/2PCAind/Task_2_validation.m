function ind = Task_2_validation(n_train,dim_pca_max,U_reduced,lambda,imgs_test,labels_test,tolerance)
    
data_test = size(imgs_test,3);
imag_v_test = reshape(imgs_test,400,[]);
coeff_test = zeros(dim_pca_max,data_test,10,n_train);
for i=1:10
    for k=1:n_train
        coeff_test(:,:,i,k) = U_reduced(:,:,i,k)'*imag_v_test;
    end
end
like = zeros(data_test,10,n_train);
for i=1:data_test
    for j=1:10
        for k=1:n_train
            like(i,j,k)=sum(lambda(:,j,k).*(coeff_test(:,i,j,k).^2))/sum(lambda(:,j,k));
        end
    end
end
new_labels = zeros(data_test,n_train);
new_labels_mode = zeros(data_test,1);
giustezza = zeros(data_test,n_train);
for j=1:data_test
    for k=1:n_train
        [giustezza(j,k),new_labels(j,k)] = max(like(j,:,k));
    end
    new_labels_mode(j) = mode(new_labels(j,:));
end
new_labels = mod(new_labels,10);
buonezza_train = zeros(n_train,10);
for i=1:n_train
    for j=1:10
        r = (labels_test==mod(j,10));
        buonezza_train(i,j)=sum(labels_test(r)==new_labels(r,i))/sum(r); 
    end
end
ind = zeros(n_train,10);
for j=1:10
    ind(:,j) = (buonezza_train(:,j)>tolerance);
end

end