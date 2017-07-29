function blacker(data,index_vector,R,C,L)
D = zeros(rows(data),columns(data)); %to initialize a matrix equal to the imagedata size with all zeros
for i = 1:rows(index_vector)
D(index_vector(i,1),:) = data(index_vector(i,1),:); %to store only one segment,rest will remain zeros
endfor
IMG = reshape(D,R,C,3);
figure;
imshow(IMG);
end
