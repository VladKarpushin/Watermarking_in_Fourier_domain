% function does watermark coding
function imgOut = doWmCoding(imgOriginal, imgWM, SNR, strPathOut)

figure, imshow(uint8(imgOriginal), []);
title('Original image');
imwrite(uint8(imgOriginal), strcat(strPathOut, 'img_original.jpg'));

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
img_watermarked = real(ifft2(imgOriginal_fft_cut+imgWM_modulated_fft_cut));
img_watermarked = imNorm(img_watermarked);
imwrite(img_watermarked, strcat(strPathOut, 'img_original_plus_wm.bmp'));
% filtering (stop)

imgOut = img_watermarked;
end
