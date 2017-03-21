clc;
clear;

% Load the original image 
% img = imread('Hand Fractured X ray images/hand1.jpg'); 
% InfoImage = imfinfo('Hand Fractured X ray images/hand1.jpg');
img = imread('images/train_b5.tif'); 
InfoImage = imfinfo('images/train_b5.tif');

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

% Detect the Egde
Gx = [-1 0 1; 
      -2 0 2;
      -1 0 1];

Gy = [ 1 2 1; 
       0 0 0;
      -1 -2 -1];

edge_x = filter2(Gx,gray);
edge_y = filter2(Gy,gray);

edge = abs(edge_x) + abs(edge_y);


% % Display the result image
% subplot(131);
% imshow(uint8(gray));
% title('input'); 
% 
% subplot(132);
% imshow(uint8(edge));
% title('edge'); 
% 
% % Calculate the GLCM(Gray Level Cooccurrence Matrix) features
[height, width] = size(edge);
% 
% % Entropy:
% % entropy(I) returns E, a scalar value representing the entropy of 
% % grayscale image I. Entropy is a statistical measure of randomness that 
% % can be used to characterize the texture of the input image. 
% % Entropy is defined as:
% %                   -sum(p.*log2(p)) 
% entorpy = entropy(edge);
% 
% % Contrast: 
% % measures the difference of contrast among all pixels of the image.
% contrast = 0;
% for i = 1 :1: height
%     for j = 1 :1: width
%         contrast = contrast + (i-j)^2 * edge(1,j);
%     end;
% end;
% 
% % Correlation: 
% % measures how the pixels are correlated to each other.
% correlation = 0;
% sigma_i = 0;
% sigma_j = 0;
% mu_i = 0;
% mu_j = 0;
% for i = 1 :1: height
%     for j = 1 :1: width
%         correlation = correlation + (i-mu_i)*(j-mu_j)*edge(i,j)/(sigma_i*sigma_j);
%     end;
% end;
% 
% % Homogeneity:
% % is the opposite of contrast feature that measures the closeness among
% % the pixels of the image.
% homogeneity = 0;
% for i = 1 :1: height
%     for j = 1 :1: width
%         homogeneity = homogeneity + edge(i,j)/(1+abs(i-j));
%     end;
% end;

M = edge;

options.nbscales = ceil(log2(size(M,1))-2);
options.n = width;
C = perform_curvelet_transform(M,options);

options.wavelet_type = 'daubechies'; % kind of wavelet
options.wavelet_vm = 4; % number of vanishing moments
Jmin = 7; %  minimum scale
% At last we actually perform the transform.
MW = perform_wavelet_transform(M, Jmin, +1, options);
M_HL = MW(1:256, 257:512);
M_LH = MW(257:512, 1:256);

figure;
imshow(MW)


glcm_edge = graycomatrix(edge);
stat_edge = graycoprops(glcm_edge);

glcm = graycomatrix(M_HL);
stat = graycoprops(glcm);

stat1 = [stat.Contrast, stat.Correlation, stat.Energy, stat.Homogeneity];
stat2 = [stat_edge.Contrast, stat_edge.Correlation, stat_edge.Energy, stat_edge.Homogeneity];
line = [reshape(C{1,1}{1},[1, 121]), stat1, stat2]

save('line.mat','line');
