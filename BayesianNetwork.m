clear;
clc;

% === Bayesian Network Training Model ===

% Loading the training data as negative and positive matrix
load neg_matrix
load pos_matrix

matrix = [neg_matrix; pos_matrix];
species = [];
for i = 1:size(neg_matrix, 1)
    species = [species ; 0];
end

for i = 1:size(pos_matrix, 1)
    species = [species ; 1];
end

% Bayesian Networks  Classification
training_data = matrix; 
target_class = species;

class  = classify(training_data ,training_data, target_class, 'diaglinear');

% Confusion matrix
cMat_BNet = confusionmat(target_class,class)

% Accuracy measurment
TP = cMat_BNet(1,1);
FP = cMat_BNet(1,2);
FN = cMat_BNet(2,1);
TN = cMat_BNet(2,2);

Precision = TP/(TP+FP)
Recall = TP/(TP+FN)
F = 2*(Precision*Recall)/(Precision+Recall)


