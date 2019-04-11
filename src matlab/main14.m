% 2016-01-06
% Watermarking in Fourier domain
% WM is short from watermark

close all, clc, clear all;

strFileNameOut = 'img_original_plus_wm.bmp';

% ***************************
% coder (start)
% ***************************
strPathIn = '..\input\';
strPathOut = '..\output\';
strFileNameIn = '2_800.jpg';
strFileNameInWM = 'nstu1.jpg';

SNR = 1/255;                %ampliture of embedded wm
imgOriginal = imread(strcat(strPathIn, strFileNameIn));
imgOriginal = double(rgb2gray(imgOriginal));
imgWM = imread(strcat(strPathIn, strFileNameInWM));

imgWM = imresize(imgWM, size(imgOriginal));
[img_watermarked, mask] = doWmCoding(imgOriginal, imgWM, SNR, strPathOut);
imwrite(img_watermarked, strcat(strPathOut, strFileNameOut));
imwrite(imNorm(mask), strcat(strPathOut, 'mask.jpg'));

% ***************************
% coder (stop)
% ***************************


%close all, clc, clear all;

% ***************************
% decoder (start)
% ***************************
strPathOut = '..\output\';
img_watermarked = double(imread(strcat(strPathOut, strFileNameOut)));

figure, imshow(uint8(img_watermarked), []);
title('An original image with embedded invisible watermark');

% robustness / attack
%img_watermarked = imrotate(img_watermarked, 1, 'bicubic', 'crop'); 
%img_watermarked = imresize(img_watermarked, 0.95); % robustness
%img_watermarked = img_watermarked(1:1000,1:1000);

figure, imshow(uint8(img_watermarked), []);
title('rotated');

imgWM_extracted = doWmDeCoding(img_watermarked);

imwrite(imgWM_extracted, strcat(strPathOut, 'wm_extracted.jpg'));
figure, imshow(imgWM_extracted,[]);
title('An extracted watermark');

% ***************************
% decoder (stop)
% ***************************

% MSE - mean-squared error
% PSNR - Peak signal to noise ratio
MSE = std2(imgOriginal - img_watermarked)^2
PSNR = 10*log10((max(max(imgOriginal))^2)/MSE)

% SNR calculation (start)
% SNR
% SNR_Amp_vl = std2(imgD)/std2(imgE_combined) %imgD - modulated signal, 
% SNR_P_v1 = SNR_Amp_vl^2
% SNR_P_DB_v1 = 10*log10(SNR_P_v1) %less accurate
% 
% SNR_P_DB_v2 = 10*log10(sum(sum(imgD_PSD))/sum(sum(imgA_PSD))) %by PSD (more accurate)
% 
% NSR = std2(imgE_combined)/std2(imgD);
% SNR_Amp_v3 = 1/(NSR-1)
% SNR_P_v3 = SNR_Amp_v3^2
% SNR_P_DB_v3 = 10*log10(SNR_P_v3)
%SNR calculation (stop)