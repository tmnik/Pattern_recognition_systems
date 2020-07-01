clear variables; 
close all;
clc;

set(0, 'DefaultFigureWindowStyle', 'docked');

%% 
% �������� �����������

name = 'moon.tif';

A = imread(name);
%%
% ��������� � ��������� ������� �������� A(������,�������); 
 
% ������ �����������
% imwrite(A,newname);

% ���������� � ����� � ������������
% imfinfo ��� �����
info = imfinfo(name);

h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

% ����� ����������� �� �����
imshow(A);
title({'�������� �����������';name});

h1 = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

% ����������� �������� �����������
imhist(A);
title({'����������� ��������� �����������';name});

%% ��������� �������
% B = imadjust(A,[�������� �������� �������],[�������� ��������])

B1 = imadjust(A,[75/255 175/255],[0 1]);

% ������������ �����������

B2 = histeq(A);
imshow(A,[]);


h2 = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

subplot(2,1,1);
imhist(B1);
title('��������� �������');

subplot(2,1,2);
imshow(B2);
title('������������ �����������');

%% ���������

C = imresize(A, 4);  % ���������������
B = imrotate(A, 15); % ������� �� ���� � ��������

C1 = imadjust(A,[75/255 175/255],[0 1],0.5);
C2 = imadjust(A,[75/255 175/255],[0 1],1.5);


h4 = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

subplot(2,2,1);
imshow(C);
title('��������� ��������');

subplot(2,2,2);
imshow(B);
title('������� �����������');

subplot(2,2,3);
imshow(C1);
title('\gamma = 0.5');

subplot(2,2,4);
imshow(C2);
title('\gamma = 1.5');

%% ������������

E1 = imresize(A,4,'bilinear');
E2 = imresize(A,4,'bicubic');
E3 = imresize(A,4,'nearest');

h4 = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

subplot(3,1,1);
imshow(E1);
title('���������� ������������');

subplot(3,1,2);
imshow(E2);
title('������������ ������������');

subplot(3,1,3);
imshow(E3);
title('������������ ������� ���������� ������');

%% ��������� ����� � �����


N = imnoise(A,'salt & pepper', 0.25); % ���

win = ones(5)/25;
W = imfilter(N,win);

win = fspecial('gaussian', 30);
G = imfilter(N,win);

med = medfilt2(A);
W_m = imfilter(N,med);


h5 = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

subplot(3,1,1);
imshow(W);
title('���������');

subplot(3,1,2);
imshow(G);
title('���������� ���������');

subplot(3,1,3);
imshow(W_m);
title('��������� ���������');


%% ������� ������������ ��� ������ ������

win = [0 -1 0; -1 4 -1; 0 -1 0]

I = imfilter(A,win);

h6 = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

subplot(2,1,1);
imshow(I);
title('������ �����������');

subplot(2,1,2);
imshow(imcomplement(I),[]); %�������������� �����
title('��������');


