clear variables; 
close all;
clc;

set(0, 'DefaultFigureWindowStyle', 'docked');
%%
    
if (~exist('./imgs/', 'dir'))
    mkdir('./imgs/')
end
%% Лабораторная работа №4 по системам распознавания образов. Часть 1

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


%% Корреляционная функция - ВНИМАНИЕ считает 1.5 часа



[q_a, w_a] = size(A);
[q_b, w_b] = size(B);

R = zeros(q_a,w_a);


% % for dx = 1:w_a - w_b - 1
% %     disp(dx);
% %     for dy = 1:q_a - q_b - 1
% %         S = 0;
% %         for x = 1:w_b
% %             for y = 1:q_b
% %                 S = S + A(y+dy,x+dx)*B(y,x);
% %             end
% %         end
% %         R(dy,dx) = S;
% %     end
% % end


% Вывод изображений на экран
h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

imshow(R,[]);
title({'Корреляционная функция'});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/1_3.jpg');
print(h, '-dpng', '-r150', fname);   


%% Теорема о свертке. Преобразование Фурье


Sa    = fft2(A);
Sb    = fft2(B,q_a,w_a);
Sb_sh = conj(Sb);
Sr    = Sa.*Sb_sh;
Sr    = Sr./abs(Sr); % Нормировка R
R     = ifft2(Sr);

% Вывод изображений на экран
h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

imshow(R,[]);
title({'Корреляционная функция. Преобразование Фурье'});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/1_4.jpg');
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
title({'Максимум корреляционной функции. Найденное положение'});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/1_5.jpg');
print(h, '-dpng', '-r150', fname);   
























