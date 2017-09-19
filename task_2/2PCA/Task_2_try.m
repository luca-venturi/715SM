function prob = Task_2_try(img_try)

load('reduced_basis.mat');
load('parametri.mat');

% img= 1-im2double(rgb2gray(imread('prova.jpeg')));
img_try = reshape(img_try,400,[]);
coeff_test = zeros(dim_pca,10,n_train);
for i=1:10
    for k=1:n_train
        coeff_test(:,i,k) = U_reduced(:,:,i,k)'*img_try;
    end
end
like = zeros(10,n_train);

for j=1:10
    for k=1:n_train
        like(j,k)=alpha(j)*sum((lambda(:,j,k)).*(coeff_test(:,j,k).^2))/sum(lambda(:,j,k));
    end
end

like_mod = zeros(n_train,10);
for i=1:n_train
    for k=1:10
        like_mod(i,k) = like(k,i)/sum(like(:,i));
    end
end

prob = zeros(10);
for k=1:10
    prob(k) = sum(like_mod(:,k))/n_train;
end

end