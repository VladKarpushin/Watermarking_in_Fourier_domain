% function normalized an image 0 to 255
function imgOut = imNorm(img)

imgOut = uint8(255*(img-min(min(img)))/(max(max(img))-min(min(img))));

end
