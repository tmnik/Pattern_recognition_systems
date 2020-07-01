clear variables; 
close all;
clc;

set(0, 'DefaultFigureWindowStyle', 'docked');
%%
    
if (~exist('./imgs/', 'dir'))
    mkdir('./imgs/')
end
%% Лабораторная работа №2 по системам распознавания образов

name = 'cameraman.tif';

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
fname = sprintf('./imgs/1_1.jpg');
print(h, '-dpng', '-r150', fname);

h1 = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

plot(imhist(A));
title({'Гистограмма исходного изображения';name});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h1, 'PaperUnits', 'centimeters'); 
set(h1, 'PaperSize', [wdth hght]); 
set(h1, 'PaperPositionMode', 'manual'); 
set(h1, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/1_2.jpg');
print(h1, '-dpng', '-r150', fname);
%% Бинаризация

L = 75/255  %Нормированный порог
B = im2bw(A,L);

h2 = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

imshow(B);
title({'Бинаризованное изображение L = 75';name});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h2, 'PaperUnits', 'centimeters'); 
set(h2, 'PaperSize', [wdth hght]); 
set(h2, 'PaperPositionMode', 'manual'); 
set(h2, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/1_3.jpg');
print(h2, '-dpng', '-r150', fname);



L1 = 50/255  %Нормированный порог
B1 = im2bw(A,L1);

h3 = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

imshow(B1);
title({'Бинаризованное изображение L = 50';name});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h3, 'PaperUnits', 'centimeters'); 
set(h3, 'PaperSize', [wdth hght]); 
set(h3, 'PaperPositionMode', 'manual'); 
set(h3, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/1_4.jpg');
print(h3, '-dpng', '-r150', fname);
%% Бинаризация методом Оцу

L2 = graythresh(A)

B2 = im2bw(A,L2);

h4 = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

imshow(B2);
title({'Бинаризованное изображение L по методу Оцу';name});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h4, 'PaperUnits', 'centimeters'); 
set(h4, 'PaperSize', [wdth hght]); 
set(h4, 'PaperPositionMode', 'manual'); 
set(h4, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/1_5.jpg');
print(h4, '-dpng', '-r150', fname);
%%


h5 = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

imshow(imcomplement(B2));
title({'Инвертированное бинаризованное изображение L по методу Оцу';name});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h5, 'PaperUnits', 'centimeters'); 
set(h5, 'PaperSize', [wdth hght]); 
set(h5, 'PaperPositionMode', 'manual'); 
set(h5, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/1_6.jpg');
print(h5, '-dpng', '-r150', fname);