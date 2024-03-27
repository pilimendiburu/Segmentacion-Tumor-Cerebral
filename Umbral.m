function [LUT] = Umbral(U)
n=256;

LUT = zeros(1,n);
LUT(1,U:n) = n-1;

end