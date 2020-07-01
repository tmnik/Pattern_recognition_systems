clear variables; 
close all;
clc;

set(0, 'DefaultFigureWindowStyle', 'docked');
%%
    
if (~exist('./imgs/', 'dir'))
    mkdir('./imgs/')
end
%% ������������ ������ �4 �� �������� ������������� �������. ����� 3

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
fname = sprintf('./imgs/3_1.jpg');
print(h, '-dpng', '-r150', fname);


name2 = 'WestConcordOrthoPhoto.png';

B = imread(name2);
B = imnoise(B,'salt & pepper');% ��������� ��� ����-�����

% ����� ����������� �� �����
h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

imshow(B);
title({'����������� ����� ��� ���� ����-�����';name2});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/3_2.jpg');
print(h, '-dpng', '-r150', fname);


%% ������� � �������. �������������� �����

[q_a, w_a]   = size(A);
[q_b, w_b] = size(B);

R = zeros(q_a,w_a);

Sa    = fft2(A);
Sb    = fft2(B,q_a,w_a);
Sb_sh = conj(Sb);
Sr    = Sa.*Sb_sh;
Sr    = Sr./abs(Sr); % ���������� R
R     = ifft2(Sr);

% ����� ����������� �� �����
h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

imshow(R,[]);
title({'�������������� �������. �������������� ����� ��� ���� ����-�����'});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/3_3.jpg');
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
title({'�������� �������������� �������. ��������� ��������� ��� ���� ����-�����'});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/3_4.jpg');
print(h, '-dpng', '-r150', fname);   
























