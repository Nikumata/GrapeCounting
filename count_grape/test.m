clear;
path = 'raw_images\'; 

filename = strcat(path, 'SVB_1962.jpg');
img = imread(filename) ;
data_box = importdata('SVB_1962.txt') ;
mask_img = getMask(img, data_box);
% imshow(mask_img)
newimg = rgb2hsv(mask_img);
% imshow(newimg);
[centers, radiis] = segmentImage(newimg, 5, 30, 0.92);
prefix = strsplit('SVB_1962.jpg', '.');
label = readxml( prefix{1});


% path = 'raw_images\';
% 
% filename = strcat(path, 'SVB_1962.jpg');
% img = imread(filename);
% imgGray = rgb2gray(img);
% prefix = strsplit('SVB_1962.jpg', '.');
% label = readxml( prefix{1});
% % disp(label)
% im_density = get_density_map_autogaussian(imgGray, label);
% imshow(im_density);
