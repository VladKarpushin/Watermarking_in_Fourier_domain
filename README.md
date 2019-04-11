Watermarking in Fourier domain
==========================

Goal
----

In this tutorial you will learn:

-   how to embed an invisible watermark in the Fourier domain

Theory
------

Watermark theory is described in well known Digital Image Processing (Gonzalez) book. Current work offers new watermark embedding method. 
The algorithm keeps robustness to imrotate, imresize, imcrop and imcompress attacks.
A watermark (wm) is modulated first and then added on high frequencies of the host image.
So, the algorithm is below:
- both original image and wm are filtered
- high freq carrier generation
- the carrier is modulated by wm
- adding original image and high freq wm

Result
------

MSE - mean-squared error.
PSNR - Peak signal to noise ratio.
PSD - Power spectrum density

MSE =  19

PSNR = 35

The figure below shows an invisible watermark
![Image corrupted by periodic noise](/www/images/wm.jpg)

The figure below shows an original image with embedded invisible watermark in the Fourier domain
![Image corrupted by periodic noise](/www/images/img_original_plus_wm.jpg)

The figure below shows an extracted watermark
![Image corrupted by periodic noise](/www/images/wm_extracted.jpg)

The figure below shows high-frequency carrier
![Image corrupted by periodic noise](/www/images/carrier.jpg)

The figure below shows PSD of a watermark
![Image corrupted by periodic noise](/www/images/wm_psd.jpg)

The figure below shows PSD of a modulated watermark
![Image corrupted by periodic noise](/www/images/wm_modulated_psd.jpg)

The figure below shows a modulated watermark
![Image corrupted by periodic noise](/www/images/wm_modulated.jpg)

The figure below shows the PSD of an original image
![Image corrupted by periodic noise](/www/images/img_original_psd.jpg)

The figure below shows the frequency filter
![Image corrupted by periodic noise](/www/images/mask.jpg)