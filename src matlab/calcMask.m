% function calculates frequency mask
function imgMask = calcMask(h, w)

h1 = fix(h/4);
h2 = fix(3*h/4);
w1 = fix(w/4);
w2 = fix(3*w/4);
mask = zeros(h, w);
mask (h1:h2,w1:w2) = 1;

end
