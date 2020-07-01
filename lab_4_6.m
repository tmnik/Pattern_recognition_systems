clear variables; 
close all;
clc;

set(0, 'DefaultFigureWindowStyle', 'docked');
%%
    
if (~exist('./imgs/', 'dir'))
    mkdir('./imgs/')
end
%% Лабораторная работа №4 по системам распознавания образов. Часть 6

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
fname = sprintf('./imgs/6_1.jpg');
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
fname = sprintf('./imgs/6_2.jpg');
print(h, '-dpng', '-r150', fname);





%% Метод Edge


A = imread(name1);


angle = (0:1:20);

X  = zeros(length(angle),1);
Y  = zeros(length(angle),1);
Bn = imread(name2);

 for i = 0:1:angle(end)
     
     B = imrotate(Bn,i); % поворот изображения
     
    % Теорема о свертке. Преобразование Фурье с помощью градиента

    [q_a, w_a]  = size(A);
    [q_b, w_b]  = size(B);

    Ca = edge(A,'Sobel'); % Внутри функции вызывается imgradient
    Cb = edge(B,'Sobel'); % Внутри функции вызывается imgradient

    R  = zeros(q_a,w_a);

    Sa    = fft2(Ca);
    Sb    = fft2(Cb,q_a,w_a);
    Sb_sh = conj(Sb);
    Sr    = Sa.*Sb_sh;
    R     = ifft2(Sr);


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
    
    X(i+1) = Xbest;
    Y(i+1) = Ybest;
 end



% % Вывод изображений на экран
% h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
% clf;
% 
% plot(angle,X,'LineWidth',2);
% title({'Метод X Edge'});
% 
% ylabel('Х');
% xlabel('Угол поворота, град');
% grid on;
% grid minor;
% 
% 
% set(gca,'fontsize',16);
% wdth = 35;
% hght = 19; 
% set(h, 'PaperUnits', 'centimeters'); 
% set(h, 'PaperSize', [wdth hght]); 
% set(h, 'PaperPositionMode', 'manual'); 
% set(h, 'PaperPosition', [0 0 wdth hght]); 
% fname = sprintf('./imgs/6_3.jpg');
% print(h, '-dpng', '-r150', fname);   
% 
% 
% 
% h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
% clf;
% 
% plot(angle,Y,'LineWidth',2);
% title({'Метод Y Edge'});
% 
% ylabel('Y');
% xlabel('Угол поворота, град');
% grid on;
% grid minor;
% 
% 
% set(gca,'fontsize',16);
% wdth = 35;
% hght = 19; 
% set(h, 'PaperUnits', 'centimeters'); 
% set(h, 'PaperSize', [wdth hght]); 
% set(h, 'PaperPositionMode', 'manual'); 
% set(h, 'PaperPosition', [0 0 wdth hght]); 
% fname = sprintf('./imgs/6_4.jpg');
% print(h, '-dpng', '-r150', fname);   



%% Метод Gradient


A = imread(name1);


angle = (0:1:20);
X  = zeros(length(angle),1);
Y  = zeros(length(angle),1);
Bn = imread(name2);

 for i = 0:angle(end)
     
     B = imrotate(Bn,i); % поворот изображения
     
     
    % Теорема о свертке. Преобразование Фурье с помощью градиента

    [q_a, w_a]  = size(A);
    [q_b, w_b]  = size(B);

    Ga = imgradient(A); % Градиент
    Gb = imgradient(B);

    R  = zeros(q_a,w_a);

    Sa    = fft2(Ga);
    Sb    = fft2(Gb,q_a,w_a);
    Sb_sh = conj(Sb);
    Sr    = Sa.*Sb_sh;
    R     = ifft2(Sr);


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
    
    X(i+1) = Xbest;
    Y(i+1) = Ybest;
 end



% Вывод изображений на экран
% h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
% clf;
% 
% plot(angle,X,'LineWidth',2);
% title({'Метод X Gradient'});
% 
% 
% ylabel('Х');
% xlabel('Угол поворота, град');
% grid on;
% grid minor;
% 
% set(gca,'fontsize',16);
% wdth = 35;
% hght = 19; 
% set(h, 'PaperUnits', 'centimeters'); 
% set(h, 'PaperSize', [wdth hght]); 
% set(h, 'PaperPositionMode', 'manual'); 
% set(h, 'PaperPosition', [0 0 wdth hght]); 
% fname = sprintf('./imgs/6_5.jpg');
% print(h, '-dpng', '-r150', fname);   
% 
% 
% 
% h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
% clf;
% 
% plot(angle,Y,'LineWidth',2);
% title({'Метод Y Gradient'});
% 
% ylabel('Y');
% xlabel('Угол поворота, град');
% grid on;
% grid minor;
% 
% 
% set(gca,'fontsize',16);
% wdth = 35;
% hght = 19; 
% set(h, 'PaperUnits', 'centimeters'); 
% set(h, 'PaperSize', [wdth hght]); 
% set(h, 'PaperPositionMode', 'manual'); 
% set(h, 'PaperPosition', [0 0 wdth hght]); 
% fname = sprintf('./imgs/6_6.jpg');
% print(h, '-dpng', '-r150', fname);   



%% Метод просто A и B


A = imread(name1);


angle = (0:1:20);
X  = zeros(length(angle),1);
Y  = zeros(length(angle),1);
Bn = imread(name2);

 for i = 0:angle(end)
     
     B = imrotate(Bn,i); % поворот изображения
     
     
    % Теорема о свертке. Преобразование Фурье с помощью градиента

    [q_a, w_a]  = size(A);
    [q_b, w_b]  = size(B);

    R  = zeros(q_a,w_a);


    Sa    = fft2(A);
    Sb    = fft2(B,q_a,w_a);
    Sb_sh = conj(Sb);
    Sr    = Sa.*Sb_sh;
%     Sr    = Sr./abs(Sr); % Нормировка R
    R     = ifft2(Sr);


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
    
    X(i+1) = Xbest;
    Y(i+1) = Ybest;
 end



% Вывод изображений на экран
h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

plot(angle,X,'LineWidth',2);
title({'Метод X просто A и B'});

ylabel('Х');
xlabel('Угол поворота, град');
grid on;
grid minor;


set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/6_7.jpg');
print(h, '-dpng', '-r150', fname);   



h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

plot(angle,Y,'LineWidth',2);
title({'Метод Y просто A и B'});

ylabel('Y');
xlabel('Угол поворота, град');
grid on;
grid minor;

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/6_8.jpg');
print(h, '-dpng', '-r150', fname);   
