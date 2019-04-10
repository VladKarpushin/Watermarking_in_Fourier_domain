% 2016-01-06
% Watermarking in Fourier domain
% WM is short from watermark

close all,clc,clear all;

SNR = 1/255;    %ampliture of embedded wm

strPathIn = '..\input\';
strPathOut = '..\output\';
strFileNameIn = '2.jpg';
strFileNameInWM = 'nstu1.jpg';

imgOriginal = imread(strcat(strPathIn, strFileNameIn));
imgOriginal = double(rgb2gray(imgOriginal));
figure, imshow(uint8(imgOriginal), []);
title('Original image');
imwrite(uint8(imgOriginal), strcat(strPathOut, 'original_img.jpg'));

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
figure, imshow(imgOriginalPSD);
title('Power spectrum density of an original image');
imwrite(imgOriginalPSD, strcat(strPathOut, 'original_img_psd.jpg'));

imgWM_PSD = calcPSD(imgWM);         % spectrum 
figure, imshow(imgWM_PSD);
title('Power spectrum density of WM');
imwrite(imgWM_PSD, strcat(strPathOut, 'wm_psd.jpg'));

imgWM_modulated_PSD = calcPSD(imgWM_modulated);   % spectrum 
figure, imshow(imgWM_modulated_PSD);
title('Power spectrum density of modulated WM');
imwrite(imgWM_modulated_PSD, strcat(strPathOut, 'wm_modulated_psd.jpg'));
% PSD calculation (start)

% filtering(start)
h1 = fix(h/4);
h2 = fix(3*h/4);
w1 = fix(w/4);
w2 = fix(3*w/4);

imgA_fft_cut = imgA_fft;
imgD_fft_cut = zeros([h w]);
imgD_fft_filter = zeros([h w]);
imgD_fft_filter(h1:h2,w1:w2) = 1;

imgA_fft_cut = imgA_fft.*~imgD_fft_filter;  %filtering
imgD_fft_cut = imgD_fft.*imgD_fft_filter;
imgE_combined = real(ifft2(imgA_fft_cut+imgD_fft_cut));
imgE_combined = uint8(255*(imgE_combined-min(min(imgE_combined)))/(max(max(imgE_combined))-min(min(imgE_combined))));
imwrite(imgE_combined,'output\combined.bmp');
%filtering(stop)

%demodulation(start)
imgE_combined = double(imread('output\combined.bmp'));
figure; imshow(uint8(imgE_combined));
title('cimbined image');
imgE_fft_combined = fft2(imgE_combined);   %spectrum 
imgE_fft_combined(1,1) = 0;   %removing of constant component
imgE_fft_combined_cut = imgE_fft_combined.*imgD_fft_filter;
imgF_new = abs(real(ifft2(imgE_fft_combined_cut))); %demodulation
imgF_newA = uint8(255*(imgF_new-min(min(imgF_new)))/(max(max(imgF_new))-min(min(imgF_new))));
imwrite(imgF_newA,'output\extracted image.bmp');
figure; imshow(imgF_newA,[]);
title('extracted hidden image');
%demodulation(stop)

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