clear variables; 
close all;
clc;

set(0, 'DefaultFigureWindowStyle', 'docked');
%%
    
if (~exist('./imgs/', 'dir'))
    mkdir('./imgs/')
end
%% Лабораторная работа №4 по системам распознавания образов. Часть 4

name1 = 'ConcordOrthoPhoto.png';

A = imread(name1);

% Вывод изображений на экран
h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

imshow(A);
title({'Изображение карты';name1});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/1_1.jpg');
print(h, '-dpng', '-r150', fname);


name2 = 'WestConcordOrthoPhoto.png';

B = imread(name2);

% Вывод изображений на экран
h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

imshow(B);
title({'Изображение кадра';name2});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/4_2.jpg');
print(h, '-dpng', '-r150', fname);




%% Теорема о свертке. Преобразование Фурье с помощью градиента

[q_a, w_a]  = size(A);
[q_b, w_b]  = size(B);

Ga = imgradient(A); % Градиент
Gb = imgradient(B);

R = zeros(q_a,w_a);


Sa    = fft2(Ga);
Sb    = fft2(Gb,q_a,w_a);
Sb_sh = conj(Sb);
Sr    = Sa.*Sb_sh;
R     = ifft2(Sr);

% Вывод изображений на экран
h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

imshow(R,[]);
title({'Корреляционная функция. Преобразование Фурье с использованием градиента'});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/4_3.jpg');
print(h, '-dpng', '-r150', fname);   



%%


Xbest = 0;
Ybest = 0;
Hbest = 0;

for x = 1:w_a
    for y = 1:q_a
        if R(y,x) > Hbest
            Hbest = R(y,x);
            Xbest = x;
            Ybest = y;
        end
    end
end

A(Ybest:Ybest + q_b - 1, Xbest:Xbest + w_b - 1) = B + 100;


% Вывод изображений на экран
h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

imshow(A);
title({'Максимум корреляционной функции. Найденное положение с использованием градиента'});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/4_4.jpg');
print(h, '-dpng', '-r150', fname);   





%% Повернем изображение кадра


A = imread(name1);
B = imread(name2);
B = imrotate(B,5); % поворот изображения

% Вывод изображений на экран
h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

imshow(B);
title({'Изображение кадра при повороте изображения';name2});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/4_5.jpg');
print(h, '-dpng', '-r150', fname);



% Теорема о свертке. Преобразование Фурье с помощью градиента

[q_a, w_a]  = size(A);
[q_b, w_b]  = size(B);

Ga = imgradient(A); % Градиент
Gb = imgradient(B);

R = zeros(q_a,w_a);


Sa    = fft2(Ga);
Sb    = fft2(Gb,q_a,w_a);
Sb_sh = conj(Sb);
Sr    = Sa.*Sb_sh;
R     = ifft2(Sr);

% Вывод изображений на экран
h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

imshow(R,[]);
title({'Корреляционная функция. Преобразование Фурье с использованием градиента при повороте изображения'});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/4_6.jpg');
print(h, '-dpng', '-r150', fname);   



%
Xbest = 0;
Ybest = 0;
Hbest = 0;

for x = 1:w_a
    for y = 1:q_a
        if R(y,x) > Hbest
            Hbest = R(y,x);
            Xbest = x;
            Ybest = y;
        end
    end
end

A(Ybest:Ybest + q_b - 1, Xbest:Xbest + w_b - 1) = B + 100;


% Вывод изображений на экран
h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

imshow(A);
title({'Максимум корреляционной функции. Найденное положение с использованием градиента при повороте изображения'});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/4_7.jpg');
print(h, '-dpng', '-r150', fname);   



%% Добавим шум


A = imread(name1);
B = imread(name2);
B = imnoise(B,'salt & pepper');% добавляем шум соль-перец

% Вывод изображений на экран
h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

imshow(B);
title({'Изображение кадра при шуме';name2});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/4_8.jpg');
print(h, '-dpng', '-r150', fname);



% Теорема о свертке. Преобразование Фурье с помощью градиента

[q_a, w_a]  = size(A);
[q_b, w_b]  = size(B);

Ga = imgradient(A); % Градиент
Gb = imgradient(B);

R = zeros(q_a,w_a);


Sa    = fft2(Ga);
Sb    = fft2(Gb,q_a,w_a);
Sb_sh = conj(Sb);
Sr    = Sa.*Sb_sh;
R     = ifft2(Sr);

% Вывод изображений на экран
h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

imshow(R,[]);
title({'Корреляционная функция. Преобразование Фурье с использованием градиента при шуме'});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/4_9.jpg');
print(h, '-dpng', '-r150', fname);   



%
Xbest = 0;
Ybest = 0;
Hbest = 0;

for x = 1:w_a
    for y = 1:q_a
        if R(y,x) > Hbest
            Hbest = R(y,x);
            Xbest = x;
            Ybest = y;
        end
    end
end

A(Ybest:Ybest + q_b - 1, Xbest:Xbest + w_b - 1) = B + 100;


% Вывод изображений на экран
h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

imshow(A);
title({'Максимум корреляционной функции. Найденное положение с использованием градиента при шуме'});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/4_10.jpg');
print(h, '-dpng', '-r150', fname);  






%% Изменим размер


A = imread(name1);
B = imread(name2);
B = imresize(B, 0.8);% добавляем шум соль-перец

% Вывод изображений на экран
h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

imshow(B);
title({'Изображение кадра при масштабировании';name2});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/4_11.jpg');
print(h, '-dpng', '-r150', fname);



% Теорема о свертке. Преобразование Фурье с помощью градиента

[q_a, w_a]  = size(A);
[q_b, w_b]  = size(B);

Ga = imgradient(A); % Градиент
Gb = imgradient(B);

R = zeros(q_a,w_a);


Sa    = fft2(Ga);
Sb    = fft2(Gb,q_a,w_a);
Sb_sh = conj(Sb);
Sr    = Sa.*Sb_sh;
R     = ifft2(Sr);

% Вывод изображений на экран
h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

imshow(R,[]);
title({'Корреляционная функция. Преобразование Фурье с использованием градиента при масштабировании'});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/4_12.jpg');
print(h, '-dpng', '-r150', fname);   



%
Xbest = 0;
Ybest = 0;
Hbest = 0;

for x = 1:w_a
    for y = 1:q_a
        if R(y,x) > Hbest
            Hbest = R(y,x);
            Xbest = x;
            Ybest = y;
        end
    end
end

A(Ybest:Ybest + q_b - 1, Xbest:Xbest + w_b - 1) = B + 100;


% Вывод изображений на экран
h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

imshow(A);
title({'Максимум корреляционной функции. Найденное положение с использованием градиента при масштабировании'});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/4_13.jpg');
print(h, '-dpng', '-r150', fname);  






















