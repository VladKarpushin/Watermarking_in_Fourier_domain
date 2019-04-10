% 2016-01-06
% Watermarking in Fourier domain
% WM is short from watermark

close all, clc, clear all;


% ***************************
% coder (start)
% ***************************


strPathIn = '..\input\';
strPathOut = '..\output\';
strFileNameIn = '2.jpg';
strFileNameInWM = 'nstu1.jpg';

SNR = 1/255;                %ampliture of embedded wm
imgOriginal = imread(strcat(strPathIn, strFileNameIn));
imgWM = imread(strcat(strPathIn, strFileNameInWM));
img_watermarked = doWmCoding(imgOriginal, imgWM, SNR, strPathOut);
imwrite(img_watermarked, strcat(strPathOut, 'img_original_plus_wm.bmp'));

% ***************************
% coder (stop)
% ***************************


close all, clc, clear all;

% ***************************
% decoder (start)
% ***************************
strPathOut = '..\output\';
img_watermarked = double(imread(strcat(strPathOut, 'img_original_plus_wm.bmp')));
figure, imshow(uint8(img_watermarked), []);
title('An original image with embedded invisible watermark');

[h w] = size(img_watermarked);
mask = calcMask(h, w);
img_fft_cut = fft2(img_watermarked) .* mask;
img_fft_cut(1, 1) = 0;

imgWM = abs(real(ifft2(img_fft_cut))); %demodulation
imgWM = imNorm(imgWM);
imwrite(imgWM, strcat(strPathOut, 'wm_extracted.jpg'));
figure; imshow(imgWM,[]);
title('An extracted watermark');

% ***************************
% decoder (stop)
% ***************************
% SNR calculation (start)
SNR
SNR_Amp_vl = std2(imgD)/std2(imgE_combined) %imgD - modulated signal, 
SNR_P_v1 = SNR_Amp_vl^2
SNR_P_DB_v1 = 10*log10(SNR_P_v1) %less accurate

SNR_P_DB_v2 = 10*log10(sum(sum(imgD_PSD))/sum(sum(imgA_PSD))) %by PSD (more accurate)

NSR = std2(imgE_combined)/std2(imgD);
SNR_Amp_v3 = 1/(NSR-1)
SNR_P_v3 = SNR_Amp_v3^2
SNR_P_DB_v3 = 10*log10(SNR_P_v3)
%SNR calculation (stop)