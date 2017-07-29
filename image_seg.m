clear;clc;close all;
string = input('Input the image file name --->> ','s');
acIMG = imread(string); %to take the image in a matrix
A = reshape(acIMG,size(acIMG,1)*size(acIMG,2),size(acIMG,3)); %reshaping the matrix in a 2D matrix where each row contains the R,G,B values for one pixel
csvwrite('imagedata.txt',A); %the matrix will be stored in a file named imagedata.txt
data = load('imagedata.txt'); 
data = normalize(data); %normalizing the matrix,for each feature
n = input('How many color segments? -> '); %Taking the number of color segments of the image you want 
IMG = reshape(data,size(acIMG,1),size(acIMG,2),size(acIMG,3)); %Just to show the image of which the filename you have entered,to ensure everything is right upto now
imshow(IMG); %showing the image
title('Actual Image');
tic;
nocn = n;    % number of competitive neurons,which is equal to the number of color segments
noin = columns(data);   % number of input neurons = number of input features 
learning_rate  = 0.01;
max_iter = 100; %You can change iterations
weight = rand(nocn,noin); %weights are initialized
 
for iter = 1:max_iter 
for i = 1:rows(data)
 output = distance(weight,data(i,:)); %distance is calculated for competition
 [max_value index_winner] = max(output);
 delta_weight = learning_rate*(data(i,:)-weight(index_winner,:));
 weight(index_winner,:) = weight(index_winner,:) + delta_weight;
endfor
endfor

value_max = zeros(rows(data),1);winner_index = zeros(rows(data),1);
for i = 1:rows(data)
  output = distance(weight,data(i,:));
  [value_max(i,:) winner_index(i,:)] = max(output);
endfor

count = zeros(nocn,1);
for i = 1:rows(data)
  for k = 1:nocn
    if(winner_index(i) == k)
      count(k)++;
    endif
  endfor
endfor

for j = 1:nocn
p = 1;
  for i = 1:rows(winner_index)
    if(winner_index(i,1)==j)
      index_matrix(j,p) = i;
      p++;
    endif  
  endfor
endfor

for region = 1:nocn
index_vector = index_matrix(region,:)';
index_vector(~any(index_vector,2),:) = [];
blacker(data,index_vector,size(acIMG,1),size(acIMG,2),size(acIMG,3));
endfor
toc;
