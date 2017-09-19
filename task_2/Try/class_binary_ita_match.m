function labels_pred= class_binary_ita_match(Xtest,k)

filename = ['file',num2str(k),'.mat'];
load(filename);
labels_pred=predict(SVMModel,Xtest);  

end
