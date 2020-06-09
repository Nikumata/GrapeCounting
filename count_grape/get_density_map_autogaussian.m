%function:通过高斯核产生相应的密度矩阵
%parameter： im：输入图像，灰度图；  points：标注的点[X Y]，n*2的矩阵
function im_density = get_density_map_autogaussian(im,points)

im_density = zeros(size(im)); 
[h,w] = size(im_density);

if(isempty(points))
    return;
end

%points为1行
if(length(points(:,1))==1)
    x1 = max(1,min(w,round(points(1,1))));  %round：四舍五入，x1变成points(1,1)处的整数
    y1 = max(1,min(h,round(points(1,2))));
    im_density(y1,x1) = 255;
    return;
end

for j = 1:length(points)
    max_kernel = 65;    %最大高斯核尺寸
    normal_kernel = 35; %默认高斯核尺寸
    beta = 0.3;         %MCNN中给定的参数
    k = 6;              %近邻数
    maxpixel = 80;      %近邻的最大距离，像素
    
%    f_sz = normal_kernel;
%    sigma = beta * f_sz;

    x = min(w,max(1,abs(double(floor(points(j,1)))))); 
    y = min(h,max(1,abs(double(floor(points(j,2))))));
    if(x > w || y > h)
        continue;
    end   
    
%--------%auto adaptive 自适应高斯核--------
    atemp = [];
    for i = 1:length(points)
        if i == j
            continue;
        end
        xk = min(w,max(1,abs(double(floor(points(i,1)))))); 
        yk = min(w,max(1,abs(double(floor(points(i,2)))))); 
        if(xk > w || yk > h)
            continue;
        end 
        dis = sqrt( ((xk-x)^2  + (yk-y)^2) );
        atemp = [atemp dis];
    end
    btemp = sort(atemp);
   
    sum = 0;
    count = 0;
    if  k >= length(points)
        k = length(points) - 1;
    end
  
    for m = 1:k
        if btemp(m) > maxpixel 
            break;
        end
        sum = sum + btemp(m);
        count = count + 1;
    end       
 
    if count > 0
        temp = sum/count;  
    else
        temp = normal_kernel;
    end
    
    f_sz = double(floor(temp));
    if mod(f_sz, 2) == 0
        f_sz = double(f_sz + 1);
    end
    if f_sz > (max_kernel + 1) 
        f_sz = max_kernel;
    end

    sigma = beta * f_sz;
    
%    fprintf("x:%d,y:%d,f_sz:%d,sigma：%d\n",x,y,f_sz, sigma);

%--------auto adaptive 自适应高斯核定义结束--------   

    H = fspecial('Gaussian',[f_sz, f_sz],sigma);  
    
    %高斯核边界限定，x方向：→，y方向：↓
    x1 = x - double(floor(f_sz/2)); y1 = y - double(floor(f_sz/2));   %x1左边界，y1上边界
    x2 = x + double(floor(f_sz/2)); y2 = y + double(floor(f_sz/2));   %x2右边界，y2下边界
    dfx1 = 0; dfy1 = 0; dfx2 = 0; dfy2 = 0;
    change_H = false;
    if(x1 < 1)
        dfx1 = abs(x1)+1;
        x1 = 1;
        change_H = true;
    end
    if(y1 < 1)
        dfy1 = abs(y1)+1;
        y1 = 1;
        change_H = true;
    end
    if(x2 > w)
        dfx2 = x2 - w;
        x2 = w;
        change_H = true;
    end
    if(y2 > h)
        dfy2 = y2 - h;
        y2 = h;
        change_H = true;
    end
    x1h = 1+dfx1; y1h = 1+dfy1; x2h = f_sz - dfx2; y2h = f_sz - dfy2;
    if (change_H == true)
        H =  fspecial('Gaussian',[double(y2h-y1h+1), double(x2h-x1h+1)],sigma);
    end
    im_density(y1:y2,x1:x2) = im_density(y1:y2,x1:x2) +  H;
     
end

end