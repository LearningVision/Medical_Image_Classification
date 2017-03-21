clear;
clc;

% === Decision Tree Training Model ===

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

% Train classification decision tree
DTree = classregtree(matrix, species);
view(DTree);

% Predict with above Decision Tree
yPredicted = eval(DTree, matrix);

% confusion matrix
cMat_DTree = confusionmat(species, yPredicted)
N = sum(cMat_DTree(:));
err = ( N-sum(diag(cMat_DTree)) ) / N;

% Accuracy measurment
TP = cMat_DTree(1,1);
FP = cMat_DTree(1,2);
FN = cMat_DTree(2,1);
TN = cMat_DTree(2,2);

Precision = TP/(TP+FP)
Recall = TP/(TP+FN)
F = 2*(Precision*Recall)/(Precision+Recall)
