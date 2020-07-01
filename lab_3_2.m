clear variables; 
close all;
clc;

set(0, 'DefaultFigureWindowStyle', 'docked');
%%
    
if (~exist('./imgs/', 'dir'))
    mkdir('./imgs/')
end
%% Лабораторная работа №3 по системам распознавания образов. Часть 1

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
fname = sprintf('./imgs/3_21.jpg');
print(h, '-dpng', '-r150', fname);

%% Определение границ с помощью фильтра Собела

S = [-1 0 1; -2 0 2; -1 0 1];

B = rgb2gray(A);
B = double(B);

%% Подавление градиента - границы помечены 0 и 1

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
fname = sprintf('./imgs/3_22.jpg');
print(h, '-dpng', '-r150', fname);



%% 

[he,we] = size(Edge);
FImax = 360;
Rmax  = round(sqrt(we^2 + he^2) + 1);

H    = zeros(Rmax, FImax);

% Расширенное пространство
Xmin = zeros(Rmax, FImax);
Xmax = zeros(Rmax, FImax);
Ymin = zeros(Rmax, FImax);
Ymax = zeros(Rmax, FImax);

Pic = zeros(he,we,3); 
Pic(:,:,3) = B;
B = zeros(size(B));

for x = 1:we
    for y = 1:he
        if Edge(y,x) ==1
            for FI = 1:360
                R = x*cosd(FI) + y *sind(FI);
                R = round(R) + 1;
                if (R > 0) && (R<Rmax)
                    H(R,FI) = H(R,FI) + 1;
                    if (Xmax(R,FI)==0 || (x > Xmax(R,FI)))
                        Xmax(R,FI) = x;
                    end
                    if (Xmin(R,FI)==0 || (x < Xmin(R,FI)))
                        Xmin(R,FI) = x;
                    end    
                    if (Ymax(R,FI)==0 || (y > Ymax(R,FI)))
                        Ymax(R,FI) = y;
                    end   
                    if (Ymin(R,FI)==0 || (y < Ymin(R,FI)))
                        Ymin(R,FI) = y;
                    end  
                end
            end
        end
    end
end

hmax = max(H(:));



                
h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

imshow(imcomplement(H/hmax*4));
title({'Дуальное пространство'});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/3_23.jpg');
print(h, '-dpng', '-r150', fname);




%% Найдем максимум в дуальном пространстве

for pass = 1:5
    
    FIbest = 0;
    Rbest  = 0;
    Hbest  = 0;



     for R = 1:Rmax
       for FI  = 1:FImax
            if H(R,FI) > Hbest
                Hbest  = H(R,FI);
                FIbest = FI;
                Rbest  = R;
            end
        end
     end
     

    x1 = Xmin(Rbest,FIbest);
    x2 = Xmax(Rbest,FIbest);
    y1 = Ymin(Rbest,FIbest);
    y2 = Ymax(Rbest,FIbest);
    
    Rbest = Rbest - 1;
     
    % по Х
    for x = x1:x2
        y = (Rbest - x*cosd(FIbest))/sind(FIbest);
        y = round(y);
        if (y > 0)&&(y <= he)
            B(y,x) = 128;
            Pic(y,x,1) = 255;
        end 
    end
    
    % по Y
    for y = y1:y2
        x = (Rbest - y*sind(FIbest))/cosd(FIbest);
        x = round(x);
        if (x > 0)&&(x <= we)
            B(y,x)     = 128;
            Pic(y,x,1) = 255;
        end 
    end
    



    % Удаляем найденный максимум
    for FI = FIbest - 10 : FIbest + 10
        for R = Rbest - 10 : Rbest + 10

            H(R,FI) = 10;

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
    fname = sprintf('./imgs/3_24.jpg');
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
    fname = sprintf('./imgs/3_25.jpg');
    print(h, '-dpng', '-r150', fname);

    
    h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
    clf;

    imshow(Pic);
    title({'Pic'});

    set(gca,'fontsize',16);
    wdth = 35;
    hght = 19; 
    set(h, 'PaperUnits', 'centimeters'); 
    set(h, 'PaperSize', [wdth hght]); 
    set(h, 'PaperPositionMode', 'manual'); 
    set(h, 'PaperPosition', [0 0 wdth hght]); 
    fname = sprintf('./imgs/3_26.jpg');
    print(h, '-dpng', '-r150', fname);