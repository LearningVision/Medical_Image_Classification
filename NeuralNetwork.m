clear;
clc;

% === Neural Network Training Model ===

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

x = matrix.';  % Training data
t = species.'; % Target label

% Create a neural network that will learn to classify
setdemorandstream(391418381);
 
net = patternnet(10);
[net,tr] = train(net, x, t);

view(net);
nntraintool;

plotperform(tr);

% Predict the net with training data
testX = x;%(:,tr.testInd);
testT = t;%(:,tr.testInd);

testY = net(testX);
testIndices = vec2ind(testY);

plotconfusion(testT,testY);

% overall percentages of correct and incorrect classification.
[c, cMat_NNet] = confusion(testT,testY)

% Accuracy measurment
TP = cMat_NNet(1,1);
FP = cMat_NNet(1,2);
FN = cMat_NNet(2,1);
TN = cMat_NNet(2,2);

Precision = TP/(TP+FP)
Recall = TP/(TP+FN)
F = 2*(Precision*Recall)/(Precision+Recall)









