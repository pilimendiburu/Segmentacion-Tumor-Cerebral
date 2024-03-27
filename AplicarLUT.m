function [imlut] = AplicarLUT(imGris,LUT)
N = length(LUT);
[f,c] = size(imGris);
imlut = uint8(zeros(f,c));

for i=1:f
    for j=1:c
        imlut(i,j) =  uint8(LUT(imGris(i,j) + 1 ));
    end
end


