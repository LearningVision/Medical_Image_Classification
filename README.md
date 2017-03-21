# Medical_Image_Classification
Project Title:
X-ray Hand Image Classification in MATLAB

1.	Prepare the training images 

Paste the two folder for negative and positive images:

 Negative image Folder name: ’Hand Fractured X ray images’
 Positive image Folder name  : ’Normal Hand X ray images’

2.	Extract the features from the training data
(step2_get_training_matrix.m)

Load the whole images from negative image folder
 

If RGB image, then Convert it to gray
 

Remove the noise
 

Detect the edge
 

Curvelet Transform
 

Wavelet Transform
 

Get GLCM features(entropy, Contrast, Correlation, Homogeneity)
 

Write the features to a vector as a line of matrix
In case of wavelet: configure the line with only wavelet features
In case of Curvelet: configure the line with only curvlet features
In case of GLCM : configure the line with only GLCM features

 
 
 

Save the matrix as neg_matrix.mat file
 

(# Do the same progress for the positive image folder and save the result matrix as a ‘pos_matrix.m’ )


3.	Naive Bayes Machine Learning Model
(step3_NB_train.m)

Load the training data (two feature matrixes)

 

Labeling for each classes in ‘species’
 

(# These above loading training data and Labeling are the same in each machine learning modules)
Create the Naïve Bayes classifier
Predict the class with input matrix
Calculate the confusion matrix
 

Calculate the accuracy with confusion matrix
 

Result:
cMat_NBayes =

    32     8
     7    37


Precision =

    0.8000


Recall =

    0.8205


F =
	
    0.8101

4.	Neural Network Machine learning Model
(step4_NN_train.m)

Load the training data (two feature matrixes)
Labeling for each classes
(# Same as the above)

Create the Neural Network classifier
 
 	  For initial classifier, use the random integer(‘391418381’)


Predict the class with input matrix
 


Calculate the confusion matrix
 
Result:
cMat_NNet =

     3    37
     0    44


Precision =

    0.0750


Recall =

     1


F =

    0.1395



5.	Decision Tree Machine learning Model
(step5_DT_train.m)


Load the training data (two feature matrixes)
Labeling for each classes
(# Same as the above)

Create the Decision Tree classifier
 


Predict the class with input matrix
 

Calculate the confusion matrix
 

Result:
cMat_DTree =

    38     2
     0    44


Precision =

    0.9500


Recall =

     1


F =

    0.9744


6.	Bayesian Network Machine learning Model
(step6_BN_train.m)

Load the training data (two feature matrixes)
Labeling for each classes
(# Same as the above)


Create the Bayesian Network classifier and Predict
 

Calculate the confusion matrix
 

Result:
cMat_BNet =

    30    10
    12    32


Precision =

    0.7500


Recall =

    0.7143


F =

    0.7317

Final Result: (Accuracy analysis.xlsx)
Using the Both features of Curvlet and Wevelet
 	Naïve Bayes	Neural Network	Decision Tree	Bayesian  Network
Precision 	0.8	0.725	0.95	0.725
Recall 	0.7805	0.7838	1	0.6905
F 	0.7901	0.7532	0.9744	0.7073
				
				
Using only the features of Curvlet
 	Naïve Bayes	Neural Network	Decision Tree	Bayesian  Network
Precision 	0.8	0.075	0.95	0.75
Recall 	0.8205	1	1	0.7143
F 	0.8101	0.1395	0.9744	0.7317
				
				
Using only the features of Wevelet
 	Naïve Bayes	Neural Network	Decision Tree	Bayesian  Network
Precision 	0.75	0.725	1	0.65
Recall 	0.5	0.8056	0.8333	0.5778
F 	0.6	0.7632	0.9091	0.6118



