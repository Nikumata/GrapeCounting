
function grape = readxml(name)
path = 'label\';                   % �������ݴ�ŵ��ļ���·��
File = dir(fullfile(path,strcat(name,'*.xml')));  % ��ʾ�ļ��������з��Ϻ�׺��Ϊ.txt�ļ���������Ϣ
FileNames = {File.name}';            % ��ȡ���Ϻ�׺��Ϊ.txt�������ļ����ļ�����ת��Ϊn��1��


xml = xmlread(strcat(path, FileNames{1}), 'r');
nodes = xml.getChildNodes;
rootNode = nodes.item(0);
childNodes = rootNode.getChildNodes;
nodeNum = childNodes.getLength;


count = 1;
grape = [];
for i = 0:nodeNum-1  %���������ڵ�
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
