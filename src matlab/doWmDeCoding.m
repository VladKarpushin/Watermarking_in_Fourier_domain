% function does watermark DeCoding
function imgOut = doWmDeCoding(img_watermarked)

[h w] = size(img_watermarked);
mask = calcMask(h, w);
img_fft_cut = fft2(img_watermarked) .* mask;
img_fft_cut(1, 1) = 0;

imgWM = abs(real(ifft2(img_fft_cut))); %demodulation
imgWM = imNorm(imgWM);

imgOut = imgWM;

end
