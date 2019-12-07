clear, clc;

%1, 2)
gray_image = imnoise2('uniform', 800, 800);
imagesc(gray_image);
colormap(gray);

imshow(gray_image);

%3)
h1 = figure('Name', 'gist 1');
hold on
[h, cx] = imhist(gray_image);
plot(cx, h);
hold off;

saveas(h1, 'gist1.jpg');

%4)
obj1_image = zeros(400, 400);
obj1_image(170:230,50:350) = 1;
obj1_image(50:350,170:230) = 1;

imagesc(obj1_image);
imwrite(obj1_image, 'obj1.bmp','bmp');

%5)
obj1_img_bilinear_s = imresize(obj1_image, 0.5, 'bilinear');
obj1_img_bilinear_b = imresize(obj1_image, 2, 'bilinear');
obj1_img_nearest_s = imresize(obj1_image, 0.5, 'nearest');
obj1_img_nearest_b = imresize(obj1_image, 2, 'nearest');

imwrite(obj1_img_bilinear_s, 'obj1_bilinear_05.bmp', 'bmp');
imwrite(obj1_img_bilinear_b, 'obj1_bilinear_2.bmp', 'bmp');
imwrite(obj1_img_nearest_s, 'obj1_nearest_05.bmp', 'bmp');
imwrite(obj1_img_nearest_b, 'obj1_nearest_2.bmp', 'bmp');

%6)
obj2_3_img = imnoise2('uniform', 600, 600);
orig_obj2_3_img = obj2_3_img;

disk_m = strel('disk', 101, 8);
obj2_3_img(50:250, 50:250) = 1.*(disk_m.Neighborhood > 0) +...
    orig_obj2_3_img(50:250, 50:250).*(disk_m.Neighborhood == 0);

disk_m = strel('disk', 91, 8);
obj2_3_img(60:240, 60:240) = orig_obj2_3_img(60:240, 60:240).*(disk_m.Neighborhood > 0) +...
    obj2_3_img(60:240, 60:240).*(disk_m.Neighborhood == 0);

disk_m = strel('disk', 51, 8);
obj2_3_img(100:200, 100:200) = 1.*(disk_m.Neighborhood > 0) +...
    orig_obj2_3_img(100:200, 100:200).*(disk_m.Neighborhood == 0);

disk_m = strel('disk', 41, 8);
obj2_3_img(110:190, 110:190) = orig_obj2_3_img(110:190, 110:190).*(disk_m.Neighborhood > 0) +...
    obj2_3_img(110:190, 110:190).*(disk_m.Neighborhood == 0);

dmd_m = strel('diamond', 100);
obj2_3_img(390:510, 350:550) = 1.*(dmd_m.Neighborhood(40:160, 1:201) > 0) +...
    orig_obj2_3_img(390:510, 350:550).*(dmd_m.Neighborhood(40:160, 1:201) == 0);

dmd_m = strel('diamond', 90);
obj2_3_img(400:500, 360:540) = orig_obj2_3_img(400:500, 360:540).*(dmd_m.Neighborhood(40:140, 1:181) > 0) +...
    obj2_3_img(400:500, 360:540).*(dmd_m.Neighborhood(40:140, 1:181) == 0);

%7)
obj2_3_img_h = obj2_3_img(1:end, end:-1:1);

imwrite(obj2_3_img_h, 'obj2_3_hor.bmp', 'bmp');

%8)
obj2_3_img_v = obj2_3_img(end:-1:1, 1:end);
imwrite(obj2_3_img_v, 'obj2_3_vert.bmp', 'bmp');

%9)
rt_angle = 45*pi/180;
T = [cos(rt_angle) sin(rt_angle) 0; -sin(rt_angle) cos(rt_angle) 0; 0 0 1];
obj2_3_img_rot = imtransform(obj2_3_img , maketform('affine', T));
imwrite(obj2_3_img_rot, 'obj2_3_rot45.bmp', 'bmp');

%10)
rt_angle = -45*pi/180;
T = [cos(rt_angle) sin(rt_angle) 0; -sin(rt_angle) cos(rt_angle) 0; 0 0 1];
obj2_3_img_rot = imtransform(obj2_3_img , maketform('affine', T));
imwrite(obj2_3_img_rot, 'obj2_3_rot-45.bmp', 'bmp');

imshow(obj2_3_img_rot);

function R = imnoise2(type,M,N,a,b)
% set default values.
if nargin == 1
    a = 0; b = 1;
    M = 1; N = 1;
elseif nargin == 3
    a = 0; b = 1;
end
%as we need only small letters as the type so...
switch lower(type)
    case 'uniform'
        R = a + (b-a)*rand(M,N);
    case 'gaussian'
        R = a + b*randn(M,N);
    case 'salt & pepper'
        if nargin <= 3
        a = 0.05; b = 0.05;
        end
% check to make sure that Pa + Pb is not > 1.        
        if (a + b) > 1
            error('The sum of the Pa and Pb cannot exeed 1.')
        end
        R(1:M,1:N) = 0.5;
% Generate an M by N array of uniformly distributed random numbers in the 
% range (0,1). Then, Pa*(M*N) of them will have values <= a. The 
% coordinates of these points we call 0 (pepper noise). Similarly, Pb*(M*N)
% points will have values in the range > a & <= (a+b). These we call 
% (salt noise).
        X = rand(M,N);
        c = find(X<=a);
        R(c) = 1;
        u = a + b;
        c = find(X > a & X <= u);
        R(c) = 1;
    case 'lognormal'
        if nargin<=3
            a = 1; b = 0.25;
        end
        R = a*esp(b*randn(M,N));
    case 'Rayleigh'
        R = a + (-b*log(1-rand(M,N)))^0.5;
    case 'exponential'
        if nargin <= 3
            a = 1;
        end
        if a <= 0
            error('the value of a must b positive for exponential operation')
        end
        k = -1/a
        R = k*log(1 - rand(M,N));
    case 'erlang'
        if nargin <= 3
            a = 2; b = 5;
        end
        if (b ~= round(b)| b <= 0)
            error('Parameter b should b a negative value for erlang')
        end
        k = -1/a;
        R = zeros(M,N);
        for j = 1:b
            R = R + k*log(1 - rand(M,N));
        end
    otherwise 
        error('Unknown distribution type.')
end
end