clear all

load('reduced_basis.mat');
load('parametri.mat');

data_test = 1e4;
[imgs_test,labels_test] = readMNIST('Data/t10k_images','Data/t10k_labels',data_test,0);
imag_v_test = reshape(imgs_test,400,[]);
coeff_test = zeros(dim_pca,data_test,10,n_train);
for i=1:10
    for k=1:n_train
        coeff_test(:,:,i,k) = U_reduced(:,:,i,k)'*imag_v_test;
    end
end
like = zeros(data_test,10,n_train);
for i=1:data_test
    for j=1:10
        for k=1:n_train
            like(i,j,k)=alpha(j)*sum((lambda(:,j,k)).*(coeff_test(:,i,j,k).^2))/sum(lambda(:,j,k));
            % like(i,j,k)=sum(coeff_test(:,i,j,k).^2);
        end
    end
end

like_mod = zeros(n_train,data_test,10);
for j=1:data_test 
    for i=1:n_train
        for k=1:10
            like_mod(i,j,k) = like(j,k,i)/sum(like(j,:,i));
        end
    end
end

prob = zeros(data_test,10);
for j=1:data_test
    for k=1:10
        prob(j,k) = sum(like_mod(:,j,k))/n_train;
    end
end
for j=1:data_test
    [~,new_labels(j)] = max(prob(j,:)); 
end
new_labels = mod(new_labels,10);
perc = sum(new_labels==labels_test')/length(labels_test)
perc_cifre = zeros(10,2);
for i=1:10
    tt = (labels_test==mod(i,10));
    perc_cifre(i,2) = sum(new_labels(tt)==labels_test(tt)')/length(labels_test(tt));
    perc_cifre(i,1) = mod(i,10);
end
perc_cifre'