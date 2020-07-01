clear variables; 
close all;
clc;

set(0, 'DefaultFigureWindowStyle', 'docked');
%%
    
if (~exist('./imgs/', 'dir'))
    mkdir('./imgs/')
end
%% Лабораторная работа №2 по системам распознавания образов. Часть 3

name = 'detali.bmp';

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
fname = sprintf('./imgs/3_1.jpg');
print(h, '-dpng', '-r150', fname);


L = graythresh(A) % Нормированный порог
L*255             % Порог

B = im2bw(A,L);

h1 = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

imshow(imcomplement(B));
title({'Бинаризованное изображение L по методу Оцу';name});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h1, 'PaperUnits', 'centimeters'); 
set(h1, 'PaperSize', [wdth hght]); 
set(h1, 'PaperPositionMode', 'manual'); 
set(h1, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/3_2.jpg');
print(h1, '-dpng', '-r150', fname);



%% Эрозия

se = ones(3);      % Матрица структурного элемента
C  = imerode(B,se);



h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

imshow(imcomplement(C));
title({'Эрозия';name});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/3_3.jpg');
print(h, '-dpng', '-r150', fname);



%% Дилатация

se = ones(3);      % Матрица структурного элемента
D  = imdilate(B,se);



h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

imshow(imcomplement(D));
title({'Дилатация';name});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/3_4.jpg');
print(h, '-dpng', '-r150', fname);


%% Эррозия + Дилатация = Размыкание

se = ones(3);      % Матрица структурного элемента
E  = imdilate(imerode(B,se), se); %E = imopen(B,se);



h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

imshow(imcomplement(E));
title({'Эрозия + Дилатация = Размыкание';name});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/3_5.jpg');
print(h, '-dpng', '-r150', fname);



%% Дилатация + Эрозия = Замыкание

se = ones(3);      % Матрица структурного элемента
E1  = imerode(imdilate(B,se), se); %E = imclose(B,se);


h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

imshow(imcomplement(E1));
title({'Дилатация + Эрозия = Замыкание';name});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/3_6.jpg');
print(h, '-dpng', '-r150', fname);




%% Размыкание + Замыкание

se_1 = ones(2);      % Матрица структурного элемента
se_2 = ones(9);      % Матрица структурного элемента

E1 = imopen(B,se_1);
E2 = imclose(E1,se_2);

E3 = imclose(B,se_1);
E4 = imopen(E3,se_2);

h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

subplot(1,2,1);
imshow(imcomplement(E2));
title({'Размыкание + Замыкание';name});
set(gca,'fontsize',16);

subplot(1,2,2);
imshow(imcomplement(E4));
title({' Замыкание + Размыкание';name});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/3_7.jpg');
print(h, '-dpng', '-r150', fname);


%% Удаление объектов

C = bwareaopen(imcomplement(E4),1000); % Удаляет объекты меньше чем порог


h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;


subplot(1,2,1);
imshow(imcomplement(E4));
title({' Замыкание + Размыкание - исходное';name});
set(gca,'fontsize',16);

subplot(1,2,2);
imshow(C);
title({' Замыкание + Размыкание - после удаление объектов';name});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/3_8.jpg');
print(h, '-dpng', '-r150', fname);



%% Скелетная линия 

S  = bwmorph(C,'skel',Inf);
S1 = bwmorph(S, 'spur', 50);% Удаление отрочтков 
S2 = bwmorph(C, 'thin', Inf);% Удаление отроcтков 
           

h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

subplot(1,3,1);
imshow(S);
title({'Скелетная линия';name});
set(gca,'fontsize',16);

subplot(1,3,2);
imshow(S1);
title({'Скелетная линия без шпор';name});
set(gca,'fontsize',16);

subplot(1,3,3);
imshow(S2);
title({'Скелетная линия THIN';name});
set(gca,'fontsize',16);

wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/3_9.jpg');
print(h, '-dpng', '-r150', fname);



%% Периметр объекта

Edge = bwperim(C);

h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;


imshow(Edge);
title({'Периметр объектов';name});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/3_10.jpg');
print(h, '-dpng', '-r150', fname);


%% Разметка объекта

M = bwlabel(C);

h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;


imshow(M,[]);
title({'Разметка объекта';name});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/3_11.jpg');
print(h, '-dpng', '-r150', fname);

%%

F1 = zeros(size(M));
F1(find(M == 1)) = 1;

F2 = zeros(size(M));
F2(find(M == 2)) = 1;

F3 = zeros(size(M));
F3(find(M == 3)) = 1;

h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

subplot(1,3,1);
imshow(F1);
title({'Первая деталь';name});
set(gca,'fontsize',16);

subplot(1,3,2);
imshow(F2);
title({'Вторая деталь';name});
set(gca,'fontsize',16);

subplot(1,3,3);
imshow(F3);
title({'Третья деталь';name});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/3_12.jpg');
print(h, '-dpng', '-r150', fname);
