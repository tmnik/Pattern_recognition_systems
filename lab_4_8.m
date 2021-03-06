clear variables; 
close all;
clc;

set(0, 'DefaultFigureWindowStyle', 'docked');
%%
    
if (~exist('./imgs/', 'dir'))
    mkdir('./imgs/')
end
%% ������������ ������ �4 �� �������� ������������� �������. ����� 8

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
fname = sprintf('./imgs/8_1.jpg');
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
fname = sprintf('./imgs/8_2.jpg');
print(h, '-dpng', '-r150', fname);





%% ����� Edge


A = imread(name1);


noise = (0:0.1:1);

X  = zeros(length(noise),1);
Y  = zeros(length(noise),1);
Bn = imread(name2);

 for i = 1:1:length(noise)
     
    B = imnoise(Bn,'salt & pepper',noise(i));% ��������� ��� ����-�����
     
    % ������� � �������. �������������� ����� � ������� ���������

    [q_a, w_a]  = size(A);
    [q_b, w_b]  = size(B);

    Ca = edge(A,'Sobel'); % ������ ������� ���������� imgradient
    Cb = edge(B,'Sobel'); % ������ ������� ���������� imgradient

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
    
    X(i) = Xbest;
    Y(i) = Ybest;
 end


% ����� ����������� �� �����
h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

plot(noise,X,'LineWidth',2);
title({'����� X Edge'});

ylabel('�');
xlabel('������ ����');
grid on;
grid minor;


set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/8_3.jpg');
print(h, '-dpng', '-r150', fname);   



h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

plot(noise,Y,'LineWidth',2);
title({'����� Y Edge'});

ylabel('Y');
xlabel('������ ����');
grid on;
grid minor;


set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/8_4.jpg');
print(h, '-dpng', '-r150', fname);   



%% ����� Gradient


A = imread(name1);


noise = (0:0.1:1);

X  = zeros(length(noise),1);
Y  = zeros(length(noise),1);
Bn = imread(name2);

 for i = 1:length(noise)
     
     B = imnoise(Bn,'salt & pepper',noise(i));% ��������� ��� ����-�����
     
     
    % ������� � �������. �������������� ����� � ������� ���������

    [q_a, w_a]  = size(A);
    [q_b, w_b]  = size(B);

    Ga = imgradient(A); % ��������
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
    
    X(i) = Xbest;
    Y(i) = Ybest;
 end


% ����� ����������� �� �����
h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

plot(noise,X,'LineWidth',2);
title({'����� X Gradient'});


ylabel('�');
xlabel('������ ����');
grid on;
grid minor;

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/8_5.jpg');
print(h, '-dpng', '-r150', fname);   



h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

plot(noise,Y,'LineWidth',2);
title({'����� Y Gradient'});

ylabel('Y');
xlabel('������ ����');
grid on;
grid minor;


set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/8_6.jpg');
print(h, '-dpng', '-r150', fname);   


return
%% ����� ������ A � B


A = imread(name1);

noise = (0:0.1:1);

X  = zeros(length(noise),1);
Y  = zeros(length(noise),1);
Bn = imread(name2);

 for i = 1:length(noise)
     
     B = imnoise(Bn,'salt & pepper',noise(i));% ��������� ��� ����-�����
     
     
    % ������� � �������. �������������� ����� � ������� ���������

    [q_a, w_a]  = size(A);
    [q_b, w_b]  = size(B);

    R  = zeros(q_a,w_a);


    Sa    = fft2(A);
    Sb    = fft2(B,q_a,w_a);
    Sb_sh = conj(Sb);
    Sr    = Sa.*Sb_sh;
    Sr    = Sr./abs(Sr); % ���������� R
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
    
    X(i) = Xbest;
    Y(i) = Ybest;
 end


% ����� ����������� �� �����
h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

plot(noise,X,'LineWidth',2);
title({'����� X ������ A � B'});

ylabel('�');
xlabel('������ ����');
grid on;
grid minor;


set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/8_7.jpg');
print(h, '-dpng', '-r150', fname);   



h = figure('Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.88]); 
clf;

plot(noise,Y,'LineWidth',2);
title({'����� Y ������ A � B'});

ylabel('Y');
xlabel('������ ����');
grid on;
grid minor;

set(gca,'fontsize',16);
wdth = 35;
hght = 19; 
set(h, 'PaperUnits', 'centimeters'); 
set(h, 'PaperSize', [wdth hght]); 
set(h, 'PaperPositionMode', 'manual'); 
set(h, 'PaperPosition', [0 0 wdth hght]); 
fname = sprintf('./imgs/8_8.jpg');
print(h, '-dpng', '-r150', fname);   
