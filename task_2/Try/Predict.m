img = 1-im2double(rgb2gray(imread('prova.png')));

Proba_Davide = Prob_Davide(img);
Proba_Luca = Prob_Luca(img);
prob = (Proba_Davide+Proba_Luca)/2;

[~,predict] = max(prob);
[~,predict_Luca] = max(Proba_Luca); 
[~,predict_Davide] = max(Proba_Davide);

predict_Luca = mod(predict_Luca,10);
predict_Davide = mod(predict_Davide,10);
predict = mod(predict,10)
