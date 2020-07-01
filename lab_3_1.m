clear variables; 
close all;
clc;

set(0, 'DefaultFigureWindowStyle', 'docked');
%%
    
if (~exist('./imgs/', 'dir'))
    mkdir('./imgs/')
end
%% Лабораторная работа №3 по системам распознавания образов. Часть 1\

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
fname = sprintf('./imgs/3_1.jpg');
print(h, '-dpng', '-r150', fname);


%% Определение границ с помощью фильтра Собела

S = [-1 0 1; -2 0 2; -1 0 1];

B = rgb2gray(A);
B = double(B);

Cx = imfilter(B,S);

h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

imshow(Cx);
title({'Вертикальные границы'});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/3_2.jpg');
print(h, '-dpng', '-r150', fname);


Cy = imfilter(B,S'); % Транспонируем матрицу Собеля

h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

imshow(Cy);
title({'Горизонтальные границы'});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/3_3.jpg');
print(h, '-dpng', '-r150', fname);




%% Вычисление градиента вручную


G = sqrt(Cx.^2 + Cy.^2);

h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

imshow(G, []);
title({'Градиент'});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/3_4.jpg');
print(h, '-dpng', '-r150', fname);

%% Вычисление градиента

G1 = imgradient(B,'Sobel'); % Применяем фильтр Собеля



h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

imshow(G1, []);
title({'Градиент автоматически'});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/3_5.jpg');
print(h, '-dpng', '-r150', fname);



%% Подавление градиента - границы помечены 0 и 1
% подходит и тогда, когда ничего про объект не известы, но границы могут и
% не быть замкнуты, эррозия и дилатация невозможны, так как выделяем только
% границы


Edge = edge(B,'Sobel'); % Внутри функции вызывается imgradient



h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

imshow(Edge, []);
title({'Edge'});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/3_6.jpg');
print(h, '-dpng', '-r150', fname);


%% Опишем объект в виде набора прямых

% представим пространство в виде массива счетчиков H
% теперь мы ищем не прямые, а точки - преобразование Хафа

% горизонтальные или вертикальные линии не могут быть найдены, т. к.
% вертикальные линии не описываются уравнением y = kx + b

Kmax = 1000;
Bmax = 1000;

H = zeros(Kmax, Bmax);
kmax = 5;
bmax = 4000;

[he,we] = size(Edge);

for x = 1:we
    for y = 1:he
        
        if Edge(y,x) == 1
            for KI = 1:Kmax
                k = (KI - 1)*2*kmax/(Kmax - 1) - kmax;
                b = -x*k+y;
                BI = (b + bmax)*(Bmax - 1)/(2*bmax) +1;
                BI = round(BI);
                
                if (BI >0) && (BI <= Bmax)
                    H(KI,BI) = H(KI,BI)+1;
                end
            end
        end
    end
end



h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

imshow(-H, []);
title({'Дуальное пространство'});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/3_7.jpg');
print(h, '-dpng', '-r150', fname);



%% Найдем максимум в дуальном пространстве

for pass = 1:10
KIbest = 0;
BIbest = 0;
Hbest  = 0;



    for KI  = 1:Kmax
        for BI = 1:Bmax
            if H(KI,BI) > Hbest
                Hbest = H(KI,BI);
                KIbest = KI;
                BIbest = BI;
            end
        end
    end


    kbest = (KIbest - 1)*2*kmax/(Kmax - 1) - kmax;
    bbest = (BIbest - 1)*2*bmax/(Bmax - 1) - bmax;

    for x = 1:we
        y = kbest * x + bbest;
        y = round(y);
        if (y > 0)&&(y <= he)
            B(y,x) = 0;
        end 
    end



    % Удаляем найденный максимум


    for KI = KIbest - 10 : KIbest + 10
        for BI = BIbest - 10 : BIbest + 10

            H(KI,BI) = 10;

        end
    end
    
       
end
        
        

    h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
    clf;

    imshow(-H, []);
    title({'Дуальное пространство'});

    set(gca,'fontsize',16);
    wdth = 35;
    hght = 19; 
    set(h, 'PaperUnits', 'centimeters'); 
    set(h, 'PaperSize', [wdth hght]); 
    set(h, 'PaperPositionMode', 'manual'); 
    set(h, 'PaperPosition', [0 0 wdth hght]); 
    fname = sprintf('./imgs/3_8.jpg');
    print(h, '-dpng', '-r150', fname);
    

    h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
    clf;

    imshow(B);
    title({'Найденные прямые'});

    set(gca,'fontsize',16);
    wdth = 35;
    hght = 19; 
    set(h, 'PaperUnits', 'centimeters'); 
    set(h, 'PaperSize', [wdth hght]); 
    set(h, 'PaperPositionMode', 'manual'); 
    set(h, 'PaperPosition', [0 0 wdth hght]); 
    fname = sprintf('./imgs/3_9.jpg');
    print(h, '-dpng', '-r150', fname);



