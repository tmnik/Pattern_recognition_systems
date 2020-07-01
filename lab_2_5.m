clear variables; 
close all;
clc;

set(0, 'DefaultFigureWindowStyle', 'docked');
%%
    
if (~exist('./imgs/', 'dir'))
    mkdir('./imgs/')
end
%% Лабораторная работа №2 по системам распознавания образов. Часть 3

name = 'pentagon.bmp';

A = imread(name);


% Вывод изображений на экран
h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

imshow(A);
title({'Исходное изображение';name});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/5_1.jpg');
print(h, '-dpng', '-r150', fname);


L = graythresh(A) % Нормированный порог
L*255             % Порог

B = im2bw(A,L);

h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

imshow(imcomplement(B));
title({'Бинаризованное изображение L по методу Оцу';name});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/5_2.jpg');
print(h, '-dpng', '-r150', fname);



%%

% Центр масс
[y,x] = find(B == 1);
xc = round(mean(x))
yc = round(mean(y))

% Границы
E = bwperim(B);


[y,x] = find(E == 1);

n = length(x);
R = zeros(360,1);

for i = 1:n
    dx = x(i) - xc;
    dy = y(i) - yc;
    ro = sqrt(dx^2 + dy^2);
    fi = round(atan2d(dy,dx) + 180 + 1);
    R(fi) = ro;
end

R = R/mean(R); % Нормировка, среднее, потому что max это шум, а среднее устойчиво к шуму



h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

stem(R);
title({'Расстояние от центра масс до границ (Центродальный нормированный профиль)';name});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/5_3.jpg');
print(h, '-dpng', '-r150', fname);







%% Поворот и масштабирование



C = imresize(B, 1/5);  % масштабирования
D = imrotate(B, 15); % поворот на угол в градусах



h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

subplot(1,3,1);
imshow(imcomplement(B));
title({'Исходное изображение';name});
set(gca,'fontsize',16);

subplot(1,3,2);
imshow(imcomplement(C));
title({'Масштабирование';name});
set(gca,'fontsize',16);

subplot(1,3,3);
imshow(imcomplement(D));
title({'Поворот';name});
set(gca,'fontsize',16);

wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/5_4.jpg');
print(h, '-dpng', '-r150', fname);



