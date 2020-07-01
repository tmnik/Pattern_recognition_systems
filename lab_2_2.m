clear variables; 
close all;
clc;

set(0, 'DefaultFigureWindowStyle', 'docked');
%%
    
if (~exist('./imgs/', 'dir'))
    mkdir('./imgs/')
end
%% ������������ ������ �2 �� �������� ������������� �������. ����� 2

name = 'rice.png';

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
fname = sprintf('./imgs/2_1.jpg');
print(h, '-dpng', '-r150', fname);



L = graythresh(A) % ������������� �����
L*255             % �����

B = im2bw(A,L);

h1 = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

imshow(B);
title({'�������������� ����������� L �� ������ ���';name});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h1, 'PaperUnits', 'centimeters'); 
set(h1, 'PaperSize', [wdth hght]); 
set(h1, 'PaperPositionMode', 'manual'); 
set(h1, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/2_2.jpg');
print(h1, '-dpng', '-r150', fname);


%%

L1 = 100/255 % ������������� �����
L1*255             % �����

B1 = im2bw(A,L1);

h2 = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

imshow(B1);
title({'�������������� ����������� L = 100';name});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h2, 'PaperUnits', 'centimeters'); 
set(h2, 'PaperSize', [wdth hght]); 
set(h2, 'PaperPositionMode', 'manual'); 
set(h2, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/2_3.jpg');
print(h2, '-dpng', '-r150', fname);


%% ������ �����������. ��������� �����


A1 = A(1:128,:);
A2 = A(129:end,:);


L1 = graythresh(A1) % ������������� �����
L1*255             % �����

B1 = im2bw(A1,L1);

L2 = graythresh(A2) % ������������� �����
L2*255             % �����

B2 = im2bw(A2,L2);

B = zeros(size(A));
B = [B1' B2']';


% ����� ����������� �� �����
h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

subplot(2,2,1);
imshow(A1);
title({'�������� �����������: ����� 1';name});
set(gca,'fontsize',16);

subplot(2,2,2);
imshow(A2);
title({'�������� �����������: ����� 2';name});
set(gca,'fontsize',16);

subplot(2,2,3);
imshow(B1);
title({'�������������� �����������: ����� 1';name});
set(gca,'fontsize',16);

subplot(2,2,4);
imshow(B2);
title({'�������������� �����������: ����� 2';name});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/2_4.jpg');
print(h, '-dpng', '-r150', fname);



h2 = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

imshow(B);
title({'�������������� ����������� ����� �������';name});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h2, 'PaperUnits', 'centimeters'); 
set(h2, 'PaperSize', [wdth hght]); 
set(h2, 'PaperPositionMode', 'manual'); 
set(h2, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/2_5.jpg');
print(h2, '-dpng', '-r150', fname);

