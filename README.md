Watermarking in Fourier domain
==========================

Goal
----

In this tutorial you will learn:

-   how to embed an invisible watermark in the Fourier domain

Theory
------

Watermark theory is described in well known Digital Image Processing (Gonsalez) book. Current work offers new watermark embedding method.
A watermark is modulated first and then added on high frequencies of the host image.

Result
------

MSE - mean-squared error.
PSNR - Peak signal to noise ratio.

MSE =  7.7866

PSNR = 39.2173

The figure below shows an invisible watermark
![Image corrupted by periodic noise](/www/images/wm.jpg)

The figure below shows an original image with embedded invisible watermark in the Fourier domain
![Image corrupted by periodic noise](/www/images/img_original_plus_wm.jpg)

The figure below shows an extracted watermark
![Image corrupted by periodic noise](/www/images/wm_extracted.jpg)