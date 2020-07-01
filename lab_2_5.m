clear variables; 
close all;
clc;

set(0, 'DefaultFigureWindowStyle', 'docked');
%%
    
if (~exist('./imgs/', 'dir'))
    mkdir('./imgs/')
end
%% ������������ ������ �2 �� �������� ������������� �������. ����� 3

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
fname = sprintf('./imgs/5_1.jpg');
print(h, '-dpng', '-r150', fname);


L = graythresh(A) % ������������� �����
L*255             % �����

B = im2bw(A,L);

h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

imshow(imcomplement(B));
title({'�������������� ����������� L �� ������ ���';name});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/5_2.jpg');
print(h, '-dpng', '-r150', fname);



%%

% ����� ����
[y,x] = find(B == 1);
xc = round(mean(x))
yc = round(mean(y))

% �������
E = bwperim(B);


[y,x] = find(E == 1);

n = length(x);
R = zeros(360,1);

for i = 1:n
    dx = x(i) - xc;
    dy = y(i) - yc;
    ro = sqrt(dx^2 + dy^2);
    fi = round(atan2d(dy,dx) + 180 + 1);
    R(fi) = ro;
end

R = R/mean(R); % ����������, �������, ������ ��� max ��� ���, � ������� ��������� � ����



h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

stem(R);
title({'���������� �� ������ ���� �� ������ (������������� ������������� �������)';name});

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/5_3.jpg');
print(h, '-dpng', '-r150', fname);







%% ������� � ���������������



C = imresize(B, 1/5);  % ���������������
D = imrotate(B, 15); % ������� �� ���� � ��������



h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

subplot(1,3,1);
imshow(imcomplement(B));
title({'�������� �����������';name});
set(gca,'fontsize',16);

subplot(1,3,2);
imshow(imcomplement(C));
title({'���������������';name});
set(gca,'fontsize',16);

subplot(1,3,3);
imshow(imcomplement(D));
title({'�������';name});
set(gca,'fontsize',16);

wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/5_4.jpg');
print(h, '-dpng', '-r150', fname);



