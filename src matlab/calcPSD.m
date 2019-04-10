% function calculates PSD (Power spectrum density)
function imgPSD = calcPSD(img)

img_fft = fft2(img);
img_fft(1,1) = 0;                      % removing of constant component
imgPSD = img_fft.*conj(img_fft);    % PSD
imgPSD = fftshift(255*(imgPSD - min(min(imgPSD))) / (max(max(imgPSD)) - min(min(imgPSD))));

end
