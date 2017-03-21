clc;
clear;

% Training matrix
negativeDir = 'Hand Fractured X ray images';
allNegFiles = dir(negativeDir);
allNegNames = {allNegFiles.name};

neg_matrix = [];

for i= 1 : length(allNegNames)
    
    if allNegFiles(i).isdir == 1
        continue
    end
    str = strcat(negativeDir, '/' , allNegNames(i));
    % Load the original image 
    img = imread(str{1, 1}); 
    
    InfoImage = imfinfo(str{1,1});
    
    % Convert image RGB to GRAY
    if strcmp(InfoImage.ColorType, 'grayscale') == 1
        gray = img(:,:,1);
    elseif length(size(img)) == 2
        gray = img(:,:);
    else  
        gray = rgb2gray(img);    
    end

    % Resize the image as (700,500)
    gray = imresize(gray, [512 512]);

    % Remove the noise
    flt = ones(3,3)/9;
    re_noise = filter2(flt, gray);    
        
    % Detect the Egde with gradient x and y
    Gx = [-1  0  1; 
          -2  0  2;
          -1  0  1];

    Gy = [ 1  2  1; 
           0  0  0;
          -1 -2 -1];

    edge_x = filter2(Gx,gray);
    edge_y = filter2(Gy,gray);

    edge = abs(edge_x) + abs(edge_y);    
     
    [height, width] = size(edge);
    
    M = edge;
    % Curvelet Transform
    options.nbscales = ceil(log2(size(M,1))-2);
    options.n = width;
    M_C = perform_curvelet_transform(M,options);    

    % Wavelet Transform
    options.wavelet_type = 'daubechies'; % kind of wavelet
    options.wavelet_vm = 4; % number of vanishing moments
    Jmin = 7; %  minimum scale
    % At last we actually perform the transform.
    M_W = perform_wavelet_transform(M, Jmin, +1, options);
    
    M_W_HL = M_W(1:256, 257:512);
    M_W_LH = M_W(1:256, 257:512);

    % Calculate the GLCM(Gray Level Cooccurrence Matrix) features   
    glcm_edge = graycomatrix(edge);
    stat_edge = graycoprops(glcm_edge);
    
    glcm_HL = graycomatrix(M_W_HL);
    stat_HL = graycoprops(glcm_HL);
    
    glcm_LH = graycomatrix(M_W_LH);
    stat_LH = graycoprops(glcm_LH);
    
    vector_edge = [stat_edge.Contrast, stat_edge.Correlation, stat_edge.Energy, stat_edge.Homogeneity];
    vector_HL = [stat_HL.Contrast, stat_HL.Correlation, stat_HL.Energy, stat_HL.Homogeneity];
    vector_LH = [stat_LH.Contrast, stat_LH.Correlation, stat_LH.Energy, stat_LH.Homogeneity];   
    
    % Creating a training data as a matrix
    % In case with Curvlet
    % line = [reshape(M_C{1,1}{1},[1, 121])];
    
    % In case with Wevelet
    % line = [vector_edge, vector_HL, vector_LH];
    
    % Both of them
    line = [reshape(M_C{1,1}{1},[1, 121])];%, vector_edge, vector_HL, vector_LH];
    neg_matrix = [neg_matrix ; line];

end
save('neg_matrix.mat','neg_matrix')




% Trainning data for Positive iamges
positiveDir = 'Normal Hand X ray images';
allPosFiles = dir(positiveDir);
allPosNames = {allPosFiles.name};

pos_matrix = [];
for i= 1 : length(allPosNames)
    
    if allPosFiles(i).isdir == 1
        continue
    end
    str = strcat(positiveDir, '/' , allPosNames(i));
    % Load the original image 
    img = imread(str{1, 1}); 
    InfoImage = imfinfo(str{1,1});
    
    % Convert image RGB to GRAY
    if strcmp(InfoImage.ColorType, 'grayscale') == 1
        gray = img(:,:,1);
    elseif length(size(img)) == 2
        gray = img(:,:);
    else  
        gray = rgb2gray(img);    
    end

    % Resize the image as (700,500)
    gray = imresize(gray, [512 512]);

    % Remove the noise
    flt = ones(3,3)/9;
    re_noise = filter2(flt, gray);    
        
    % Detect the Egde with gradient x and y
    Gx = [-1  0  1; 
          -2  0  2;
          -1  0  1];

    Gy = [ 1  2  1; 
           0  0  0;
          -1 -2 -1];

    edge_x = filter2(Gx,gray);
    edge_y = filter2(Gy,gray);

    edge = abs(edge_x) + abs(edge_y);    
     
    [height, width] = size(edge);
    
    M = edge;
    % Curvelet Transform
    options.nbscales = ceil(log2(size(M,1))-2);
    options.n = width;
    M_C = perform_curvelet_transform(M,options);    

    % Wavelet Transform
    options.wavelet_type = 'daubechies'; % kind of wavelet
    options.wavelet_vm = 4; % number of vanishing moments
    Jmin = 7; %  minimum scale
    % At last we actually perform the transform.
    M_W = perform_wavelet_transform(M, Jmin, +1, options);
    
    M_W_HL = M_W(1:256, 257:512);
    M_W_LH = M_W(1:256, 257:512);

    % Calculate the GLCM(Gray Level Cooccurrence Matrix) features   
    glcm_edge = graycomatrix(edge);
    stat_edge = graycoprops(glcm_edge);
    
    glcm_HL = graycomatrix(M_W_HL);
    stat_HL = graycoprops(glcm_HL);
    
    glcm_LH = graycomatrix(M_W_LH);
    stat_LH = graycoprops(glcm_LH);
    
    vector_edge = [stat_edge.Contrast, stat_edge.Correlation, stat_edge.Energy, stat_edge.Homogeneity];
    vector_HL = [stat_HL.Contrast, stat_HL.Correlation, stat_HL.Energy, stat_HL.Homogeneity];
    vector_LH = [stat_LH.Contrast, stat_LH.Correlation, stat_LH.Energy, stat_LH.Homogeneity];   
    
    % Creating a training data as a matrix
    % In case with Curvlet
    % line = [reshape(M_C{1,1}{1},[1, 121])];
    
    % In case with Wevelet
    % line = [vector_edge, vector_HL, vector_LH];
    
    % Both of them
    line = [reshape(M_C{1,1}{1},[1, 121])];%, vector_edge, vector_HL, vector_LH];
    
    pos_matrix = [pos_matrix ; line];

end

save('pos_matrix.mat','pos_matrix')



