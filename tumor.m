function [p,a] = tumor(im_cln)
%% Abrir imagen
imagen_rgb=imread(im_cln);
figure,
subplot(2,2,1)
imshow(imagen_rgb);
title('Imagen original');

%% Pre-procesamiento
%en el preprcesamiento primero paso la imágen a escala de grises. Después
%le saco el ruido usando el filtro de mediana y luego realzo los contrastes
%con contrast streaching. Lo mismo se puede hacer con la equalización del
%histograma como dice el paper.

imagen_gray=rgb2gray(imagen_rgb);
subplot(2,2,2)
imshow(imagen_gray);
title('Imagen escala de grises');

imagen_gray1=medfilt2(imagen_gray);
subplot(2,2,3)
imshow(imagen_gray1);
title('Imagen escala de grises sin ruido');

imagen_realzada = imadjust(imagen_gray1,stretchlim(imagen_gray1),[]);
subplot(2,2,4)
imshow(imagen_realzada);
title('Imagen con contrastes realzados');



%% Contornos
%se probaron distintas tecnicas (sobel, canny y prewitt) para realzar los
%contornos. Se concluyó que la mejor es Canny para marcar los contonroa swl
%tumor
im_canny=edge(imagen_realzada,'canny');
im_sobel=edge(imagen_realzada,'sobel');
im_prewitt=edge(imagen_realzada,'prewitt');

figure,
subplot(1,4,1)
imshow(imagen_realzada)
title('Imagen');

subplot(1,4,2)
imshow(im_canny)
title('Imagen Canny');

subplot(1,4,3)
imshow(im_sobel)
title('Imagen Sobel');

subplot(1,4,4)
imshow(im_prewitt)
title('Imagen Prewitt');

%% Segmentacion->Nos quedamos con Canny
imagen_realzada = uint8(255 * mat2gray(imagen_realzada)); %lo pone en formato de una imágen 8 bits

[F,C]=size(imagen_realzada);

B = multithresh(imagen_realzada,2); % Obtención del umbral automática (Metodo de Otsu)
% Umbralizo a partir del umbral superior
U=double(B(2));
n=256;
%creo una lut, todos los valores de intensidad de píxeles en la imagen que sean iguales o 
% mayores al valor de U se asignarán al valor máximo (n-1) en la LUT. 
%Todos los valores por debajo del umbral U permanecerán en cero en la LUT.
LUT = zeros(1,n);
LUT(1,U:n) = n-1;
%Aplico la lut
IM_bin = AplicarLUT(imagen_realzada,LUT); % Imagen binarizada


%% forma automática

EE = strel('disk',10); % Creo el elemento estructurante .

%grafico imagen binnarizada
figure,
subplot(1,3,1);
imshow(imagen_realzada);
title('Imagen realzada');
subplot(1,3,2);
imshow(IM_bin);
title('Imagen Binarizada');

BW = imopen(IM_bin,EE); % Borra imprefecciones del binarizado.
% figure, subplot(1,3,1);
% imshow(BW);
% title('Apertura');

BW = imdilate(BW,EE);
% subplot(1,3,2);
% imshow(BW);
% title('Dilatación');

BW = imclose(BW,EE);
% subplot(1,3,3);
% imshow(BW);
% title('Cierre');

BW = BW.* IM_bin; % Segmento binarizado

subplot(1,3,3);
imshow(BW);
titulo = {'Segmentación automática', 'del fitrado morfológico'};
title(titulo);
impixelinfo


% if (BW(:,:) == 0)
%     error('El valor del elemento estructurante es muy grande para la imagen (Sugerencia: Cambiar tamaño del EE a < 5)')
% end
% 
figure,
subplot(1,2,1);
imshow(imagen_rgb);
title('Imagen Original');
[peri_aux,area_aux,label_max,area_max] = PeriArea(BW);


a = area_max;
p= peri_aux(label_max);




end
