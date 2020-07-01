clear variables; 
close all;
clc;

set(0, 'DefaultFigureWindowStyle', 'docked');
%%
    
if (~exist('./imgs/', 'dir'))
    mkdir('./imgs/')
end
%% ������������ ������ �2 �� �������� ������������� �������. ����� 4

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
fname = sprintf('./imgs/4_1.jpg');
print(h, '-dpng', '-r150', fname);


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

h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

imshow(B);
title({'�������������� ����������� L �� ������ ���';name});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/4_2.jpg');
print(h, '-dpng', '-r150', fname);





%% ���������� + ���������

se_1 = ones(5);      % ������� ������������ ��������
se_2 = ones(1);      % ������� ������������ ��������

E1 = imopen(B,se_1);
E2 = imclose(E1,se_2);

E3 = imclose(B,se_1);
E4 = imopen(E3,se_2);

h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

subplot(2,2,1);
imshow(E1);
title({'����������';name});
set(gca,'fontsize',16);

subplot(2,2,2);
imshow(E3);
title({'���������';name});
set(gca,'fontsize',16);


subplot(2,2,3);
imshow(E2);
title({'���������� + ���������';name});
set(gca,'fontsize',16);

subplot(2,2,4);
imshow(E4);
title({' ��������� + ����������';name});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/4_3.jpg');
print(h, '-dpng', '-r150', fname);



%% �������� �������

M = bwlabel(E1);

h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;


imshow(M,[]);
title({'�������� �������';name});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/4_4.jpg');
print(h, '-dpng', '-r150', fname);



%%

F1 = zeros(size(M));
F1(find(M == 6)) = 1;

F2 = zeros(size(M));
F2(find(M == 15)) = 1;


h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

subplot(1,3,1);
imshow(M,[]);
title({'�������� �������';name});
set(gca,'fontsize',16);


subplot(1,3,2);
imshow(F1);
title({'������ �� ������ �������� 6';name});
set(gca,'fontsize',16);

subplot(1,3,3);
imshow(F2);
title({'������ �� ������ �������� 15';name});
set(gca,'fontsize',16);


wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/4_5.jpg');
print(h, '-dpng', '-r150', fname);


%% ���������� �����

Size_rice = max(max(M))



%% ����� ������� ������


h_gist = imhist(uint8(M));
h_gist = h_gist(2:end);
[v, x] = max(h_gist)


F3 = zeros(size(M));
F3(find(M == x)) = 1;



h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

subplot(2,1,1);
plot(h_gist);
title({'����������� ��������';name});
set(gca,'fontsize',16);

subplot(2,1,2);
imshow(F3);
title({'����� ������� ������';name});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/4_6.jpg');
print(h, '-dpng', '-r150', fname);





