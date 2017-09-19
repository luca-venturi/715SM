img=1-im2double(rgb2gray(imread('prova.png')));

load('base_italiana.mat')
cif=[1:9,0];

perc=zeros(10,10);


Xtest=reshape(img,400,[])'*U_red;

        
score_match=zeros(size(Xtest,1),45);


k=0;
for i=0:8
    for j=i+1:9
        k=k+1;
        score_match(:,k)=class_binary_ita_match(Xtest,k);
    end
end

predict=mode(score_match,2)

