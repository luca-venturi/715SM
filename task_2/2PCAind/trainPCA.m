% trainPCA

clear all
n_train = 100;
data = 500;

dim_pca = 5;
U_reduced = zeros(400,dim_pca,10,n_train);
lambda = zeros(dim_pca,10,n_train);

for k=1:n_train
    
    [imgs,labels] = readMNIST('train_images','train_labels',data,(k-1)*data);

    n_labels = zeros(10,1);
    for i=0:9
        n_labels(i+1) = sum(labels==i);
    end
    m = min(n_labels);

    imag = zeros(20,20,m,10);
    for i=1:10
        A = imgs(:,:,labels==mod(i,10));
        imag(:,:,:,i) = A(:,:,1:m);
        clear A
    end

    imag_v = reshape(imag,400,m,10);
    for i=1:10
        [~,~,U_reduced(:,:,i,k),~,lambda(:,i,k)] = PCA(imag_v(:,:,i)',dim_pca);
    end
    
end

save('reduced_basis.mat','n_train','data','dim_pca','U_reduced','lambda');