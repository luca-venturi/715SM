clear all

% load('reduced_basis.mat');
load('reduced_basis_dim.mat');

n_validation = 10;
data_validation = 1000;
ind = zeros(n_train,10);
ind_val = zeros(n_train,n_validation,10);

tolerance = 0;

for k=1:n_validation
   
    % voglio avere una matrice ind che mi darà gli indici buoni per
    % cifra e validation
    % finito tale ciclo prendo solo quelli migliori per ogni validation
    
    [imgs_val,labels_val] = readMNIST('train_images','train_labels',data_validation,n_train*data+(k-1)*data_validation);
    
    ind_val(:,k,:) = Task_2_validation(n_train,dim_pca_max,U_reduced,lambda,imgs_val,labels_val,tolerance);
    
end
for i=1:n_train
    for j=1:10
        ind(i,j) = min(ind_val(i,:,j));
    end
end

good = zeros(10,1);
for j=1:10
    good(j) = max(ind(:,j));
end
safe = min(good);

if safe==0
    disp('tolleranza troppo alta -> dati non salvati')
else     
    disp('tolleranza ok -> dati salvati')
    % save('reduced_basis.mat','n_train','dim_pca','U_reduced','lambda','ind','data');
    save('reduced_basis_dim.mat','n_train','data','dim_pca','dim_pca_max','U_reduced','lambda');
end