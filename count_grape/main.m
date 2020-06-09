clear;

minRad = 5;
maxRad = 30;
sensitivity = 0.92;
hsv = 1;

path = 'raw_images\';                   % 设置数据存放的文件夹路径
File = dir(fullfile(path,'*.jpg'));  % 显示文件夹下所有符合后缀名为.jpg文件的完整信息
FileNames = {File.name}';            % 提取符合后缀名为.jpg的所有文件的文件名，转换为n行1列

Length_Names = size(FileNames,1);    % 获取所提取数据文件的个数
error = zeros(Length_Names, 1);
detect_num = 0;
label_num = 0;

count_class = zeros(6, 2);
count_class(1,:) = [0 0];
count_class(2,:) = [0 0];
count_class(3,:) = [0 0];
count_class(4,:) = [0 0];
count_class(5,:) = [0 0];
count_class(6,:) = [0 0];

error_class = cell(6, 1);
error_class{1} = {[]};
error_class{2} = {[]};
error_class{3} = {[]};
error_class{4} = {[]};
error_class{5} = {[]};
error_class{6} = {[]};

for k = 1 : Length_Names
    filename = strcat(path, FileNames{k});
    img = imread(filename) ;
    prefix = strsplit(FileNames{k}, '.');
    data_box = importdata(strcat('detect_result/', prefix{1}, '.txt')) ;
    class = data_box.textdata{1};
    newimg = getMask(img, data_box.data);
    % RGB image to hsv image
    if hsv == 1
        newimg = rgb2hsv(newimg);
    end
    [centers, radiis] = segmentImage(newimg, minRad, maxRad, sensitivity);
    label = readxml(prefix{1});
    error_class{6} = [error_class{6}; size(label ,1) - size(centers ,1)];
    count_class(6,1) = count_class(6,1) + size(label ,1);
    count_class(6,2) = count_class(6,2) + size(centers ,1);
    if strcmp(class, 'CDY')
        count_class(1,1) = count_class(1,1) + size(label ,1);
        count_class(1,2) = count_class(1,2) + size(centers ,1);
        error_class{1} = [error_class{1}; size(label ,1) - size(centers ,1)];
    elseif strcmp(class, 'CFR')
        count_class(2,1) = count_class(2,1) + size(label ,1);
        count_class(2,2) = count_class(2,2) + size(centers ,1);
        error_class{2} = [error_class{2}; size(label ,1) - size(centers ,1)];
    elseif strcmp(class, 'CSV')
        count_class(3,1) = count_class(3,1) + size(label ,1);
        count_class(3,2) = count_class(3,2) + size(centers ,1);
        error_class{3} = [error_class{3}; size(label ,1) - size(centers ,1)];
    elseif strcmp(class, 'SVB')
        count_class(4,1) = count_class(4,1) + size(label ,1);
        count_class(4,2) = count_class(4,2) + size(centers ,1);
        error_class{4} = [error_class{4}; size(label ,1) - size(centers ,1)];
    elseif strcmp(class, 'SYH')
        count_class(5,1) = count_class(5,1) + size(label ,1);
        count_class(5,2) = count_class(5,2) + size(centers ,1);
        error_class{5} = [error_class{5}; size(label ,1) - size(centers ,1)];
    else
        error_have = 0
    end
        
end
maes = zeros(6, 1);
maes(6, 1) = mae(abs(cell2mat(error_class{6}(2:end))));
maes(1, 1) = mae(abs(cell2mat(error_class{1}(2:end))));
maes(2, 1) = mae(abs(cell2mat(error_class{2}(2:end))));
maes(3, 1) = mae(abs(cell2mat(error_class{3}(2:end))));
maes(4, 1) = mae(abs(cell2mat(error_class{4}(2:end))));
maes(5, 1) = mae(abs(cell2mat(error_class{5}(2:end))));
mses = zeros(6, 1);
mses(6, 1) = mse(abs(cell2mat(error_class{6}(2:end))));
mses(1, 1) = mse(abs(cell2mat(error_class{1}(2:end))));
mses(2, 1) = mse(abs(cell2mat(error_class{2}(2:end))));
mses(3, 1) = mse(abs(cell2mat(error_class{3}(2:end))));
mses(4, 1) = mse(abs(cell2mat(error_class{4}(2:end))));
mses(5, 1) = mse(abs(cell2mat(error_class{5}(2:end))));
omaes = zeros(6, 1);
omaes(6, 1) = abs(count_class(6,1) - count_class(6,2));
omaes(1, 1) = abs(count_class(1,1) - count_class(1,2));
omaes(2, 1) = abs(count_class(2,1) - count_class(2,2));
omaes(3, 1) = abs(count_class(3,1) - count_class(3,2));
omaes(4, 1) = abs(count_class(4,1) -l count_class(4,2));
omaes(5, 1) = abs(count_class(5,1) - count_class(5,2));
ans = count_class(6,2) - count_class(6,1);
if hsv == 1
    save(strcat('result/', num2str(minRad), '_', num2str(maxRad), '_', num2str(sensitivity), '_hsv.mat'), 'maes', 'mses', 'omaes', 'count_class', 'ans');
else
    save(strcat('result/', num2str(minRad), '_', num2str(maxRad), '_', num2str(sensitivity), '.mat'), 'maes', 'mses', 'omaes', 'count_class', 'ans');
end

