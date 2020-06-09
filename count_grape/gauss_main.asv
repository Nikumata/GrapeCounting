clc
clear
close all
%%

img_name = fullfile('.', 'part_B_final', 'train_data', 'images', 'IMG_2.jpg') ;
mat_name = fullfile('.', 'part_B_final', 'train_data', 'ground_truth', 'GT_IMG_2.mat') ;

%%

img = imread(img_name);
load(mat_name)

data = image_info{1} ;

figure(1)
RGB = insertMarker(img, data.location, 'size',10);
imshow(RGB)


img = rgb2gray(img);



annPoints =  data.location;
im_density = get_density_map_autogaussian(img,annPoints);
%sum(sum(im_density))
%im_density = get_density_map_gaussian(im,annPoints);
 
figure(3)
cmap = colormap(jet(210));
imagesc(im_density,[0 max(max(im_density))])
%imagesc(im_density,[0 0.038])
colorbar 