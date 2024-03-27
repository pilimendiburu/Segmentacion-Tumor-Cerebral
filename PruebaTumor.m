im1='Y1.jpg';
im2='Y2.jpg';
im3='Y3.jpg';
im4='Y7.jpg';
im5='Y16.jpg';
im6='Y26.jpg';

%% Imagen 1
[p1,a1] = tumor(im1);
disp(['Area Tumor ', num2str(a1)]);
disp(['Perimetro Tumor ', num2str(p1)]);

%% Imagen 2
[p2,a2] = tumor(im2);
disp(['Area Tumor ', num2str(a2)]);
disp(['Perimetro Tumor ', num2str(p2)]);

%% Imagen 3
[p3,a3] = tumor(im3);
disp(['Area Tumor ', num2str(a3)]);
disp(['Perimetro Tumor ', num2str(p3)]);

%% Imagen 4
[p4,a4] = tumor(im4);
disp(['Area Tumor ', num2str(a4)]);
disp(['Perimetro Tumor ', num2str(p4)]);
%% Imagen 5 (fail)
[p5,a5] = tumor(im5);
disp(['Area Tumor ', num2str(a5)]);
disp(['Perimetro Tumor ', num2str(p5)]);
%% Imagen 6 (fail)
[p6,a6] = tumor(im6);
disp(['Area Tumor ', num2str(a6)]);
disp(['Perimetro Tumor ', num2str(p6)]);
