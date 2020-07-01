clear variables; 
close all;
clc;

set(0, 'DefaultFigureWindowStyle', 'docked');

%% 
% Загрузка изображения

name = 'moon.tif';

A = imread(name);
%%
% Обращение к элементам матрицы картинки A(строка,столбец); 
 
% Запись изображения
% imwrite(A,newname);

% Информация о файле с изображением
% imfinfo имя файла
info = imfinfo(name);

h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

% Вывод изображений на экран
imshow(A);
title({'Исходное изображение';name});

h1 = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

% Гистограмма ярокости изображения
imhist(A);
title({'Гистограмма исходного изображения';name});

%% Коррекция яркости
% B = imadjust(A,[исходный диапазон яркости],[диапазон резкости])

B1 = imadjust(A,[75/255 175/255],[0 1]);

% Выравнивание гистограммы

B2 = histeq(A);
imshow(A,[]);


h2 = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

subplot(2,1,1);
imhist(B1);
title('Коррекция яркости');

subplot(2,1,2);
imshow(B2);
title('Выравнивание гистограммы');

%% Коррекция

C = imresize(A, 4);  % масштабирования
B = imrotate(A, 15); % поворот на угол в градусах

C1 = imadjust(A,[75/255 175/255],[0 1],0.5);
C2 = imadjust(A,[75/255 175/255],[0 1],1.5);


h4 = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

subplot(2,2,1);
imshow(C);
title('Изменение масштаба');

subplot(2,2,2);
imshow(B);
title('Поворот изображения');

subplot(2,2,3);
imshow(C1);
title('\gamma = 0.5');

subplot(2,2,4);
imshow(C2);
title('\gamma = 1.5');

%% Интерполяция

E1 = imresize(A,4,'bilinear');
E2 = imresize(A,4,'bicubic');
E3 = imresize(A,4,'nearest');

h4 = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

subplot(3,1,1);
imshow(E1);
title('Билинейная интерполяция');

subplot(3,1,2);
imshow(E2);
title('Бикубическая интерполяция');

subplot(3,1,3);
imshow(E3);
title('Интерполяция методом ближайшего соседа');

%% Коррекция шумов и помех


N = imnoise(A,'salt & pepper', 0.25); % шум

win = ones(5)/25;
W = imfilter(N,win);

win = fspecial('gaussian', 30);
G = imfilter(N,win);

med = medfilt2(A);
W_m = imfilter(N,med);


h5 = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

subplot(3,1,1);
imshow(W);
title('Коррекция');

subplot(3,1,2);
imshow(G);
title('Гаусовская коррекция');

subplot(3,1,3);
imshow(W_m);
title('Медианная коррекция');


%% Матрица используется для поиска границ

win = [0 -1 0; -1 4 -1; 0 -1 0]

I = imfilter(A,win);

h6 = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

subplot(2,1,1);
imshow(I);
title('Контур изображения');

subplot(2,1,2);
imshow(imcomplement(I),[]); %инвертирование цвета
title('Инверсия');


