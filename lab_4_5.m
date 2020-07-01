clear variables; 
close all;
clc;

set(0, 'DefaultFigureWindowStyle', 'docked');
%%
    
if (~exist('./imgs/', 'dir'))
    mkdir('./imgs/')
end
%% ������������ ������ �4 �� �������� ������������� �������. ����� 5

name1 = 'ConcordOrthoPhoto.png';

A = imread(name1);

% ����� ����������� �� �����
h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

imshow(A);
title({'����������� �����';name1});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/5_1.jpg');
print(h, '-dpng', '-r150', fname);


name2 = 'WestConcordOrthoPhoto.png';

B = imread(name2);

% ����� ����������� �� �����
h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

imshow(B);
title({'����������� �����';name2});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/5_2.jpg');
print(h, '-dpng', '-r150', fname);




%% ������� � �������. �������������� ����� � ������� ���������

[q_a, w_a]  = size(A);
[q_b, w_b]  = size(B);

Ca = edge(A,'Sobel'); % ������ ������� ���������� imgradient
Cb = edge(B,'Sobel'); % ������ ������� ���������� imgradient

R = zeros(q_a,w_a);


Sa    = fft2(Ca);
Sb    = fft2(Cb,q_a,w_a);
Sb_sh = conj(Sb);
Sr    = Sa.*Sb_sh;
R     = ifft2(Sr);

% ����� ����������� �� �����
h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

imshow(R,[]);
title({'�������������� �������. �������������� ����� � �������������� Edge'});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/5_3.jpg');
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


% ����� ����������� �� �����
h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

imshow(A);
title({'�������� �������������� �������. ��������� ��������� � Edge ���������'});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/5_4.jpg');
print(h, '-dpng', '-r150', fname);   





%% �������� ����������� �����


A = imread(name1);
B = imread(name2);
B = imrotate(B,5); % ������� �����������

% ����� ����������� �� �����
h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

imshow(B);
title({'����������� ����� ��� �������� �����������';name2});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/5_5.jpg');
print(h, '-dpng', '-r150', fname);



% ������� � �������. �������������� ����� � ������� ���������

[q_a, w_a]  = size(A);
[q_b, w_b]  = size(B);

Ca = edge(A,'Sobel'); % ������ ������� ���������� imgradient
Cb = edge(B,'Sobel'); % ������ ������� ���������� imgradient

R = zeros(q_a,w_a);


Sa    = fft2(Ca);
Sb    = fft2(Cb,q_a,w_a);
Sb_sh = conj(Sb);
Sr    = Sa.*Sb_sh;
R     = ifft2(Sr);

% ����� ����������� �� �����
h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

imshow(R,[]);
title({'�������������� �������. �������������� ����� � �������������� Edge ��� �������� �����������'});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/5_6.jpg');
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


% ����� ����������� �� �����
h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

imshow(A);
title({'�������� �������������� �������. ��������� ��������� � �������������� Edge ��� �������� �����������'});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/5_7.jpg');
print(h, '-dpng', '-r150', fname);   



%% ������� ���


A = imread(name1);
B = imread(name2);
B = imnoise(B,'salt & pepper');% ��������� ��� ����-�����

% ����� ����������� �� �����
h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

imshow(B);
title({'����������� ����� ��� ����';name2});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/5_8.jpg');
print(h, '-dpng', '-r150', fname);



% ������� � �������. �������������� ����� � ������� ���������

[q_a, w_a]  = size(A);
[q_b, w_b]  = size(B);

Ca = edge(A,'Sobel'); % ������ ������� ���������� imgradient
Cb = edge(B,'Sobel'); % ������ ������� ���������� imgradient

R = zeros(q_a,w_a);


Sa    = fft2(Ca);
Sb    = fft2(Cb,q_a,w_a);
Sb_sh = conj(Sb);
Sr    = Sa.*Sb_sh;
R     = ifft2(Sr);

% ����� ����������� �� �����
h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

imshow(R,[]);
title({'�������������� �������. �������������� ����� � �������������� Edge ��� ����'});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/5_9.jpg');
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


% ����� ����������� �� �����
h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

imshow(A);
title({'�������� �������������� �������. ��������� ��������� � �������������� Edge ��� ����'});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/5_10.jpg');
print(h, '-dpng', '-r150', fname);  






%% ������� ������


A = imread(name1);
B = imread(name2);
B = imresize(B, 0.8);% ��������� ��� ����-�����

% ����� ����������� �� �����
h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

imshow(B);
title({'����������� ����� ��� ���������������';name2});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/5_11.jpg');
print(h, '-dpng', '-r150', fname);



% ������� � �������. �������������� ����� � ������� ���������

[q_a, w_a]  = size(A);
[q_b, w_b]  = size(B);

Ca = edge(A,'Sobel'); % ������ ������� ���������� imgradient
Cb = edge(B,'Sobel'); % ������ ������� ���������� imgradient


R = zeros(q_a,w_a);


Sa    = fft2(Ca);
Sb    = fft2(Cb,q_a,w_a);
Sb_sh = conj(Sb);
Sr    = Sa.*Sb_sh;
R     = ifft2(Sr);

% ����� ����������� �� �����
h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

imshow(R,[]);
title({'�������������� �������. �������������� ����� � �������������� Edge ��� ���������������'});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/5_12.jpg');
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


% ����� ����������� �� �����
h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

imshow(A);
title({'�������� �������������� �������. ��������� ��������� � �������������� Edge ��� ���������������'});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/5_13.jpg');
print(h, '-dpng', '-r150', fname);  






















