function [F] = Sliding2(path)


%cd ('D:\My Matlab\OCR project');        %changing the path
A = imread(path);      %reading image
BW = imresize(A,0.1);
BW = im2bw(BW) ;             %binaraizing image
BW = imcomplement(BW) ; 
BW = flip(BW,2) ;


%imshow(BW) ;

W_image = size(BW,2) ;    %getting image width
H_image = size(BW,1) ;    %getting image hight

col = 1;
for c = 1 : W_image
    if (sum(BW(:,c))~=0)
        BWc(:,col) = BW(:,c);
        col = col+1;
    end
end

%figure,imshow(BWc)

%[l w]=size(BWc);
row = 1;
for r = 1 : H_image
    if (sum(BWc(r,:))~=0)
        BWcc(row,:) = BWc(r,:);
        row = row+1;
    end
end

%figure,imshow(BWcc)

W_image = size(BWcc,2) ;    %getting image width
H_image = size(BWcc,1) ;    %getting image hight
Wn_hight = uint16(H_image/8)-1  ;
F = zeros(1,W_image-2) ;
%R_pix = H_image - Wn_hight*8 ;


for i = 1 : W_image-2
    
    for j = 1 : H_image
        temp = BWcc(:,i:i+2);
        F(i) = sum(sum(temp));
        
    end
end


F = F + 1;

% Ft = transpose(F);


%-----------------------------Quantization--------------------------------

%[FQ,m] = pcaa(Ft,1);

%Ret = transpose(FQ);

end