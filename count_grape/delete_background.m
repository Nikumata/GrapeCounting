clc
clear
close all

%%


img = imread('SVB_1962.jpg') ;
% imshow(img)


%%

data_box = importdata('SVB_1962.txt') ;

load('point_groundtruth.mat')

annotatedImage = insertShape(img,'Rectangle',[data_box(:, 1), data_box(:, 2), data_box(:,3)-data_box(:,1), data_box(:,4)-data_box(:,2)], 'LineWidth',5);

RGB = insertMarker(img, grape,'size',10) ;


img2gray = rgb2gray(img) ;


figure
imshow(img2gray)
% for ii = 1: size(data_box, 1)
%     h = images.roi.Rectangle(gca,'Position',[data_box(ii, 1), data_box(ii, 2), data_box(ii,3)-data_box(ii,1), data_box(ii,4)-data_box(ii,2)],'StripeColor','r');
%     hold on
% end





roi = cell([size(data_box, 1), 1]);
for ii = 1: size(data_box, 1)
    h = drawrectangle('Position',[data_box(ii, 1), data_box(ii, 2), data_box(ii,3)-data_box(ii,1), data_box(ii,4)-data_box(ii,2)],'StripeColor','r');
    roi{ii} = h;
end


mask = zeros(size(img2gray)) ;
for kk = 1: size(data_box, 1)
    newmask = createMask(roi{kk});
    mask = or(mask,newmask);
end
close


newimg = img;

for ii = 1: size(img2gray, 1)
    for jj = 1: size(img2gray, 2)
        for kk = 1: 3
        if not(mask(ii, jj))
            newimg(ii, jj, kk) = 0 ;
        end
        end
    end
end


HSV = rgb2hsv(newimg) ;

figure
imshow(newimg)

figure
imshow(HSV)

