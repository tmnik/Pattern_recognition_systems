clear variables; 
close all;
clc;

set(0, 'DefaultFigureWindowStyle', 'docked');
%%
    
if (~exist('./imgs/', 'dir'))
    mkdir('./imgs/')
end
%% ������������ ������ �3 �� �������� ������������� �������. ����� 1\

name = 'pentagon.bmp';

A = imread(name);

% ����� ����������� �� �����
h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

imshow(A);
title({'�������� �����������';name});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/3_1.jpg');
print(h, '-dpng', '-r150', fname);


%% ����������� ������ � ������� ������� ������

S = [-1 0 1; -2 0 2; -1 0 1];

B = rgb2gray(A);
B = double(B);

Cx = imfilter(B,S);

h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

imshow(Cx);
title({'������������ �������'});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/3_2.jpg');
print(h, '-dpng', '-r150', fname);


Cy = imfilter(B,S'); % ������������� ������� ������

h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

imshow(Cy);
title({'�������������� �������'});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/3_3.jpg');
print(h, '-dpng', '-r150', fname);




%% ���������� ��������� �������


G = sqrt(Cx.^2 + Cy.^2);

h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

imshow(G, []);
title({'��������'});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/3_4.jpg');
print(h, '-dpng', '-r150', fname);

%% ���������� ���������

G1 = imgradient(B,'Sobel'); % ��������� ������ ������



h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

imshow(G1, []);
title({'�������� �������������'});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/3_5.jpg');
print(h, '-dpng', '-r150', fname);



%% ���������� ��������� - ������� �������� 0 � 1
% �������� � �����, ����� ������ ��� ������ �� �������, �� ������� ����� �
% �� ���� ��������, ������� � ��������� ����������, ��� ��� �������� ������
% �������


Edge = edge(B,'Sobel'); % ������ ������� ���������� imgradient



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


%% ������ ������ � ���� ������ ������

% ���������� ������������ � ���� ������� ��������� H
% ������ �� ���� �� ������, � ����� - �������������� ����

% �������������� ��� ������������ ����� �� ����� ���� �������, �. �.
% ������������ ����� �� ����������� ���������� y = kx + b

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
title({'�������� ������������'});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/3_7.jpg');
print(h, '-dpng', '-r150', fname);



%% ������ �������� � �������� ������������

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



    % ������� ��������� ��������


    for KI = KIbest - 10 : KIbest + 10
        for BI = BIbest - 10 : BIbest + 10

            H(KI,BI) = 10;

        end
    end
    
       
end
        
        

    h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
    clf;

    imshow(-H, []);
    title({'�������� ������������'});

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
    title({'��������� ������'});

    set(gca,'fontsize',16);
    wdth = 35;
    hght = 19; 
    set(h, 'PaperUnits', 'centimeters'); 
    set(h, 'PaperSize', [wdth hght]); 
    set(h, 'PaperPositionMode', 'manual'); 
    set(h, 'PaperPosition', [0 0 wdth hght]); 
    fname = sprintf('./imgs/3_9.jpg');
    print(h, '-dpng', '-r150', fname);



