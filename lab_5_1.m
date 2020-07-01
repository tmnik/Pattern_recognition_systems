clear variables; 
close all;
clc;

set(0, 'DefaultFigureWindowStyle', 'docked');
%%
    
if (~exist('./imgs/', 'dir'))
    mkdir('./imgs/')
end
%% Лабораторная работа №5 по системам распознавания образов. Часть 1
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


%контур 

Ca = edge(A,'Sobel');
Cb = edge(B,'Sobel');
[y1,x1] = find(Cb == 1);
n = length(x1);

[q,w]   = size(A);
[q1,w1] = size(B);

H = zeros(q,w);


for x = 1:w
    for y = 1:q
        if Ca(y,x) == 1
            for i = 1:n
                dx = x - x1(i);
                dy = y - y1(i);
                if (dx>0)&&(dy>0)&&(dx<=w)&&(dy<=q)
                    H(dy,dx) = H(dy,dx)+1;
                end
            end
        end
    end
end


h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

imshow(imcomplement(H),[]);
title({'Найденное положение',''});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/1_3.jpg');
print(h, '-dpng', '-r150', fname);




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
title({'Максимум корреляционной функции. Найденное положение',''});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/1_4.jpg');
print(h, '-dpng', '-r150', fname);   












