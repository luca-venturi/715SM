clear all

load('reduced_basis_dim.mat');
load('parametri.mat');

data_test = 1e4;
[imgs_test,labels_test] = readMNIST('t10k_images','t10k_labels',data_test,0);
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
            like(i,j,k)=sum((lambda(:,j,k)).*(coeff_test(:,i,j,k).^2))/sum(lambda(:,j,k));
            % like(i,j,k)=sum(coeff_test(:,i,j,k).^2);
        end
    end
end

n_train_cifre = zeros(10,1);
for j=1:10
    n_train_cifre(j) = sum(ind(:,j));
end
n_train_max = max(n_train_cifre);
pos = zeros(n_train_max,10);
for j=1:10
    for i=1:n_train_cifre(j)
        m = i;
        while (sum(ind(1:m,j)) < i) && (m <= n_train_cifre(j))
            m = m+1;
        end
        pos(i,j) = m;
    end
end

like_mod = zeros(n_train_max,data_test,10);
for j=1:data_test 
    for i=1:n_train_max
        for k=1:10
            if i <= n_train_cifre(k)
                like_mod(i,j,k) = like(j,k,pos(i,k))/sum(like(j,:,pos(i,k)));
            end
        end
    end
end

prob = zeros(data_test,10);
for j=1:data_test
    s1 = sum(sum(like_mod(:,j,:)));
    for k=1:10
        prob(j,k) = sum(like_mod(:,j,k))/s1;
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