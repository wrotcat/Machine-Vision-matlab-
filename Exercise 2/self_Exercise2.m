%Exercise 1
%Display the result in two images:
%1:an image in which the grey value is proportional to the gradient length
%2:an image in which the grey value is proportional to the gradient angle

I=imread('postit2g.png')
Id=im2double(I); 
% so the range of grey value is 0-1
sobel_u=1/8*fspecial('sobel');
sobel_v=sobel_u';
prewitt_u=1/6*fspecial('prewitt');
prewitt_v=prewitt_u';
Id_sobel_u=conv2(Id,sobel_u);
Id_sobel_v=conv2(Id,sobel_v);
Id_prewitt_u=conv2(Id,prewitt_u);
Id_prewitt_v=conv2(Id,prewitt_v);

sobel_glength=sqrt(Id_sobel_u.^2+Id_sobel_v.^2);
sobel_angle=atan2(Id_sobel_v,Id_sobel_u);
sobel_angle_norm=sobel_angle/(2*pi)+0.5;
% the original range of angle is from -pi to pi. After this operation the
% range is 0-1.
prewitt_glength=sqrt(Id_prewitt_u.^2+Id_prewitt_v.^2);
prewitt_angle=atan2(Id_prewitt_v,Id_prewitt_u);
prewitt_angle_norm=prewitt_angle/(2*pi)+0.5;

figure;
subplot(2,2,1);
imshow(sobel_glength,[]);
subplot(2,2,2);
imshow(sobel_angle_norm,'colormap',hsv);
subplot(2,2,3);
imshow(prewitt_glength,[]);
subplot(2,2,4);
imshow(prewitt_angle,'colormap',hsv);


%Exercise 2
I=imread('postit2g.png');
Id=im2double(I);
Canny_pic=edge(I,'canny',[0.08,0.13]);
%man can add standard deviation of gaussian filter(sigma)
LoG_pic=edge(I,'log',0.0028);
%For the 'log' and 'zerocross' methods, if you specify the threshold value 0, 
%then the output image has closed contours because it includes all the zero-crossings 
%in the input image.
%%%%%%
%Scalar value that specifies the standard deviation of the Laplacian of 
%Gaussian filter. The default is 2. The size of the filter is n-by-n, 
%where n=ceil(sigma*3)*2+1.
figure;
subplot(2,1,1);
imshow(Canny_pic);
subplot(2,1,2);
imshow(LoG_pic);



%Exercise 3
hough_data=robust_hough(Canny_pic);
hough_data.accumulator;
n_lines=11;
hough_lines=robust_hough_lines( hough_data, n_lines,Canny_pic );
robust_hough_plot_lines( I, hough_lines )
%two part as one 

%output the picture of hough space
[~, index]= sort(hough_data.peaks(:, 3));
peaks = hough_data.peaks(index, :);
peaks = peaks(end - n_lines:end, :);

figure;
imagesc(hough_data.accumulator);
colormap hot;
hold on;
plot(peaks(:,2),peaks(:,1),'wo');
hold off;





