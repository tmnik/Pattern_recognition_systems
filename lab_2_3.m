clear variables; 
close all;
clc;

set(0, 'DefaultFigureWindowStyle', 'docked');
%%
    
if (~exist('./imgs/', 'dir'))
    mkdir('./imgs/')
end
%% ������������ ������ �2 �� �������� ������������� �������. ����� 3

name = 'detali.bmp';

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


L = graythresh(A) % ������������� �����
L*255             % �����

B = im2bw(A,L);

h1 = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

imshow(imcomplement(B));
title({'�������������� ����������� L �� ������ ���';name});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h1, 'PaperUnits', 'centimeters'); 
set(h1, 'PaperSize', [wdth hght]); 
set(h1, 'PaperPositionMode', 'manual'); 
set(h1, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/3_2.jpg');
print(h1, '-dpng', '-r150', fname);



%% ������

se = ones(3);      % ������� ������������ ��������
C  = imerode(B,se);



h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

imshow(imcomplement(C));
title({'������';name});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/3_3.jpg');
print(h, '-dpng', '-r150', fname);



%% ���������

se = ones(3);      % ������� ������������ ��������
D  = imdilate(B,se);



h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

imshow(imcomplement(D));
title({'���������';name});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/3_4.jpg');
print(h, '-dpng', '-r150', fname);


%% ������� + ��������� = ����������

se = ones(3);      % ������� ������������ ��������
E  = imdilate(imerode(B,se), se); %E = imopen(B,se);



h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

imshow(imcomplement(E));
title({'������ + ��������� = ����������';name});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/3_5.jpg');
print(h, '-dpng', '-r150', fname);



%% ��������� + ������ = ���������

se = ones(3);      % ������� ������������ ��������
E1  = imerode(imdilate(B,se), se); %E = imclose(B,se);


h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

imshow(imcomplement(E1));
title({'��������� + ������ = ���������';name});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/3_6.jpg');
print(h, '-dpng', '-r150', fname);




%% ���������� + ���������

se_1 = ones(2);      % ������� ������������ ��������
se_2 = ones(9);      % ������� ������������ ��������

E1 = imopen(B,se_1);
E2 = imclose(E1,se_2);

E3 = imclose(B,se_1);
E4 = imopen(E3,se_2);

h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

subplot(1,2,1);
imshow(imcomplement(E2));
title({'���������� + ���������';name});
set(gca,'fontsize',16);

subplot(1,2,2);
imshow(imcomplement(E4));
title({' ��������� + ����������';name});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/3_7.jpg');
print(h, '-dpng', '-r150', fname);


%% �������� ��������

C = bwareaopen(imcomplement(E4),1000); % ������� ������� ������ ��� �����


h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;


subplot(1,2,1);
imshow(imcomplement(E4));
title({' ��������� + ���������� - ��������';name});
set(gca,'fontsize',16);

subplot(1,2,2);
imshow(C);
title({' ��������� + ���������� - ����� �������� ��������';name});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/3_8.jpg');
print(h, '-dpng', '-r150', fname);



%% ��������� ����� 

S  = bwmorph(C,'skel',Inf);
S1 = bwmorph(S, 'spur', 50);% �������� ��������� 
S2 = bwmorph(C, 'thin', Inf);% �������� ����c���� 
           

h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

subplot(1,3,1);
imshow(S);
title({'��������� �����';name});
set(gca,'fontsize',16);

subplot(1,3,2);
imshow(S1);
title({'��������� ����� ��� ����';name});
set(gca,'fontsize',16);

subplot(1,3,3);
imshow(S2);
title({'��������� ����� THIN';name});
set(gca,'fontsize',16);

wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/3_9.jpg');
print(h, '-dpng', '-r150', fname);



%% �������� �������

Edge = bwperim(C);

h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;


imshow(Edge);
title({'�������� ��������';name});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/3_10.jpg');
print(h, '-dpng', '-r150', fname);


%% �������� �������

M = bwlabel(C);

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
fname = sprintf('./imgs/3_11.jpg');
print(h, '-dpng', '-r150', fname);

%%

F1 = zeros(size(M));
F1(find(M == 1)) = 1;

F2 = zeros(size(M));
F2(find(M == 2)) = 1;

F3 = zeros(size(M));
F3(find(M == 3)) = 1;

h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

subplot(1,3,1);
imshow(F1);
title({'������ ������';name});
set(gca,'fontsize',16);

subplot(1,3,2);
imshow(F2);
title({'������ ������';name});
set(gca,'fontsize',16);

subplot(1,3,3);
imshow(F3);
title({'������ ������';name});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/3_12.jpg');
print(h, '-dpng', '-r150', fname);
