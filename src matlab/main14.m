% 2016-01-06
% Watermarking in Fourier domain
% WM is short from watermark

close all, clc, clear all;

SNR = 1/255;    %ampliture of embedded wm

strPathIn = '..\input\';
strPathOut = '..\output\';
strFileNameIn = '2.jpg';
strFileNameInWM = 'nstu1.jpg';

imgOriginal = imread(strcat(strPathIn, strFileNameIn));
imgOriginal = double(rgb2gray(imgOriginal));
figure, imshow(uint8(imgOriginal), []);
title('Original image');
imwrite(uint8(imgOriginal), strcat(strPathOut, 'img_original.jpg'));

imgWM = imread(strcat(strPathIn, strFileNameInWM));
imgWM = double(rgb2gray(imgWM));
figure, imshow(uint8(imgWM), []);
title('Watermark');
imwrite(uint8(imgWM), strcat(strPathOut, 'wm.jpg'));


% high frequency carrier generation (start)
[h w] = size(imgWM);
imgC = ones([h w]);
for i =1:h
     for j =1:w
            imgC(i,j) = (-1)^(i+j);
     end
end
imwrite(imgC, strcat(strPathOut, 'carrier.jpg'));
% high frequency carrier generation (stop)

% WM modulation (start)
imgWM_modulated = imgC.*imgWM*SNR;
imwrite(imgWM_modulated, strcat(strPathOut, 'wm_modulated.jpg'));
% modulation (stop)

% PSD calculation (start)
imgOriginalPSD = calcPSD(imgOriginal);
figure, imshow(imgOriginalPSD, []);
title('Power spectrum density of an original image');
imwrite(imgOriginalPSD, strcat(strPathOut, 'img_original_psd.jpg'));

imgWM_PSD = calcPSD(imgWM);         % spectrum 
figure, imshow(imgWM_PSD, []);
title('Power spectrum density of WM');
imwrite(imgWM_PSD, strcat(strPathOut, 'wm_psd.jpg'));

imgWM_modulated_PSD = calcPSD(imgWM_modulated);   % spectrum 
figure, imshow(imgWM_modulated_PSD, []);
title('Power spectrum density of modulated WM');
imwrite(imgWM_modulated_PSD, strcat(strPathOut, 'wm_modulated_psd.jpg'));
% PSD calculation (start)

% filtering (start)
mask = calcMask(h, w);


imgOriginal_fft_cut = fft2(imgOriginal) .* ~mask;  % filtering
imgWM_modulated_fft_cut = fft2(imgWM_modulated) .* mask;
img_combined = real(ifft2(imgOriginal_fft_cut+imgWM_modulated_fft_cut));
img_combined = imNorm(img_combined);
imwrite(img_combined, strcat(strPathOut, 'img_original_plus_wm.bmp'));
% filtering (stop)

close all, clc, clear all;

% ***************************
% demodulation (start)
% ***************************
strPathOut = '..\output\';
img_combined = double(imread(strcat(strPathOut, 'img_original_plus_wm.bmp')));
figure, imshow(uint8(img_combined), []);
title('An original image with embedded invisible watermark');

[h w] = size(img_combined);
mask = calcMask(h, w);
img_fft_cut = fft2(img_combined) .* mask;
img_fft_cut(1, 1) = 0;

imgWM = abs(real(ifft2(img_fft_cut))); %demodulation
imgWM = imNorm(imgWM);
imwrite(imgWM, strcat(strPathOut, 'wm_extracted.jpg'));
figure; imshow(imgWM,[]);
title('An extracted watermark');

% ***************************
% demodulation (stop)
% ***************************
%SNR calculation (start)
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