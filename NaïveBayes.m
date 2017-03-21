clc;
clear;

% === Naive Bayes Train Model ===

% Loading the training data as negative and positive matrix
load neg_matrix
load pos_matrix

matrix = [neg_matrix; pos_matrix];
species = [];
for i = 1:size(neg_matrix, 1)
    species = [species ; {'Fractured'}];
end

for i = 1:size(pos_matrix, 1)
    species = [species ; {'Normal'}];
end

% Create teh NaiveBayes Classifier
NBayes = fitNaiveBayes(matrix, species);

% Predict with above classifier
yPredict = NBayes.predict(matrix);

% Confusion Matrix
cMat_NBayes = confusionmat(species,yPredict)

% Accuracy measurment
TP = cMat_NBayes(1,1);
FP = cMat_NBayes(1,2);
FN = cMat_NBayes(2,1);
TN = cMat_NBayes(2,2);

Precision = TP/(TP+FP)
Recall = TP/(TP+FN)
F = 2*(Precision*Recall)/(Precision+Recall)

