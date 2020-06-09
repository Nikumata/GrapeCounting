
function grape = readxml(name)
path = 'label\';                   % 设置数据存放的文件夹路径
File = dir(fullfile(path,strcat(name,'*.xml')));  % 显示文件夹下所有符合后缀名为.txt文件的完整信息
FileNames = {File.name}';            % 提取符合后缀名为.txt的所有文件的文件名，转换为n行1列


xml = xmlread(strcat(path, FileNames{1}), 'r');
nodes = xml.getChildNodes;
rootNode = nodes.item(0);
childNodes = rootNode.getChildNodes;
nodeNum = childNodes.getLength;


count = 1;
grape = [];
for i = 0:nodeNum-1  %遍历各个节点
   str=char(childNodes.item(i).getNodeName);
    if(strcmp(str,'object'))
        object = childNodes.item(i).getChildNodes;
        point = object.item(11).getChildNodes;
        str1=char(object.item(11).getNodeName);
        grape(count, 1) = str2double(point.item(1).getTextContent);
        grape(count, 2) = str2double(point.item(3).getTextContent);
        count = count + 1;
    end
end


% %%marker
% img = imread('1962\\SVB_1962_1590717822741.jpg');
% figure(1)
% RGB = insertMarker(img, grape);
% imshow(RGB)
% img = rgb2gray(img);
% 
% %% heatmap
% annPoints =  grape;
% im_density = get_density_map_autogaussian(img,annPoints);
% figure(3)
% cmap = colormap(jet(210));
% imagesc(im_density,[0 max(max(im_density))])

end
