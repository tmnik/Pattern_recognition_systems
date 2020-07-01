clear variables; 

close all;
clc;

set(0, 'DefaultFigureWindowStyle', 'docked');
%%
    
if (~exist('./imgs/', 'dir'))
    mkdir('./imgs/')
end
%% Лабораторная работа №5 по системам распознавания образов. Часть 2
% 
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
fname = sprintf('./imgs/1_2.jpg');
print(h, '-dpng', '-r150', fname);




%% Ускоренный алгоритм с использованием градиента 

H = GHT(A,B);


h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

imshow(imcomplement(H),[]);
title('Найденное положение через ускоренный алгоритм');

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/1_5.jpg');
print(h, '-dpng', '-r150', fname);


[q,w]   = size(A);
[q1,w1] = size(B);
Xbest = 0;
Ybest = 0;
Hbest = 0;

for x = 1:w-w1-1
    for y = 1:q-q1-1
        if H(y,x) > Hbest
            Hbest = H(y,x);
            Xbest = x;
            Ybest = y;
        end
    end
end

A(Ybest:Ybest + q1 - 1, Xbest:Xbest + w1 - 1) = B + 100;


% Вывод изображений на экран
h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

imshow(A);
title({'Найденное положение. Ускоренный алгоритм'});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/1_6.jpg');
print(h, '-dpng', '-r150', fname);   


return
%% УГОЛ

angle = (0:1:20);
X  = zeros(length(angle),1);
Y  = zeros(length(angle),1);

 for i = 0:1:angle(end)
     
     Bn = imrotate(B,i); % поворот изображения
     H = GHT(A,Bn);
     H = imfilter(H,ones(11));


    [q,w]   = size(A);
    [q1,w1] = size(Bn);
    Xbest = 0;
    Ybest = 0;
    Hbest = 0;

    for x = 1:w-w1-1
        for y = 1:q-q1-1
            if H(y,x) > Hbest
                Hbest = H(y,x);
                Xbest = x;
                Ybest = y;
            end
        end
    end
    X(i+1) = Xbest;
    Y(i+1) = Ybest;
 end

% Вывод изображений на экран
h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

plot(angle,X,'LineWidth',2);
title({'Исследования влияния угла',''});

ylabel('Х');
xlabel('Угол поворота, град');
grid on;
grid minor;


set(gca,'fontsize',10);
wdth = 10;
hght = 7; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/1_7.jpg');
print(h, '-dpng', '-r150', fname);   


% Вывод изображений на экран
h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

plot(angle,Y,'LineWidth',2);
title({'Исследования влияния угла',''});

ylabel('Y');
xlabel('Угол поворота, град');
grid on;
grid minor;


set(gca,'fontsize',10);
wdth = 10;
hght = 7; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/1_8.jpg');
print(h, '-dpng', '-r150', fname);



%% ШУМ

noise = (0:0.1:0.7);

X  = zeros(length(noise),1);
Y  = zeros(length(noise),1);
B = imread(name2);

 for i = 1:1:length(noise)
     
     Bn1 = imnoise(B,'salt & pepper',noise(i));% добавляем шум соль-перец
     H = GHT(A,Bn1);
     H = imfilter(H,ones(11));


    [q,w]   = size(A);
    [q1,w1] = size(Bn1);
    Xbest = 0;
    Ybest = 0;
    Hbest = 0;

    for x = 1:w-w1-1
        for y = 1:q-q1-1
            if H(y,x) > Hbest
                Hbest = H(y,x);
                Xbest = x;
                Ybest = y;
            end
        end
    end
    X(i) = Xbest;
    Y(i) = Ybest;
 end

% Вывод изображений на экран
h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

plot(noise,X,'LineWidth',2);
title({'Исследования влияния шума',''});

ylabel('Х');
xlabel('Шум');
grid on;
grid minor;


set(gca,'fontsize',10);
wdth = 10;
hght = 7; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/1_9.jpg');
print(h, '-dpng', '-r150', fname);   


% Вывод изображений на экран
h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

plot(noise,Y,'LineWidth',2);
title({'Исследования влияния шума',''});

ylabel('Y');
xlabel('Шум');
grid on;
grid minor;


set(gca,'fontsize',10);
wdth = 10;
hght = 7; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/1_10.jpg');
print(h, '-dpng', '-r150', fname);


%% МАСШТАБ

scale = (0.5:0.1:1.5);

X  = zeros(length(scale),1);
Y  = zeros(length(scale),1);


 for i = 1:1:length(scale)
     
     Bn2 = imresize(B, scale(i));
     H = GHT(A,Bn2);
     H = imfilter(H,ones(11));


    [q,w]   = size(A);
    [q1,w1] = size(Bn2);
    Xbest = 0;
    Ybest = 0;
    Hbest = 0;

    for x = 1:w-w1-1
        for y = 1:q-q1-1
            if H(y,x) > Hbest
                Hbest = H(y,x);
                Xbest = x;
                Ybest = y;
            end
        end
    end
    X(i) = Xbest;
    Y(i) = Ybest;
 end

% Вывод изображений на экран
h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

plot(scale,X,'LineWidth',2);
title({'Исследования влияния масштабирования',''});

ylabel('Х');
xlabel('Масштаб');
grid on;
grid minor;


set(gca,'fontsize',10);
wdth = 10;
hght = 7; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/1_11.jpg');
print(h, '-dpng', '-r150', fname);   


% Вывод изображений на экран
h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

plot(scale,Y,'LineWidth',2);
title({'Исследования влияния масштабирования',''});

ylabel('Y');
xlabel('Масштаб');
grid on;
grid minor;


set(gca,'fontsize',10);
wdth = 10;
hght = 7;  
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/1_12.jpg');
print(h, '-dpng', '-r150', fname);