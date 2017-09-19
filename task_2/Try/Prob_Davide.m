function prob = Prob_Davide(Xtest)

load('reduced_basis_Davide.mat');

alfa=[0.88 1.08 1.05 1.23 1.13 0.98 1 1.09 1.05 1.21];


n_test=size(Xtest,3);

test=reshape(Xtest,400,[]);

test_coeff=zeros(d,n_test,10,n_train);
for clas=1:10
    for k=1:n_train
        test_coeff(:,:,clas,k)=(test'*U_red(:,:,clas,k))';
    end
end

like=zeros(n_test,10,n_train);
for i=1:n_test
    for j=1:10
        for k=1:n_train
            coeffic=zeros(400,1);
            coeffic(1:d)=test_coeff(:,i,j,k);
            coeffic(d+1:400)=mediacoeff(clas,:,k);
            like(i,j,k)=sum(alfa(j)*lambda_tot(:,j,k).*(coeffic).^2)/sum(lambda_tot(:,j,k).^2);
        end
    end
end

for i=1:n_test
    for j=1:10
        prob_dav(i,j)=sum(like(i,j,:))/sum(sum(like(i,:,:)));
    end
end
prob = prob_dav';

end