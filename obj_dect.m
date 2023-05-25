function [obj_pos,angular_points] = obj_dect(rgb)
%  物体识别
%  obj_pos:物体中心坐标
%  angular_points：六边形角点
    obj_pos = [];
    angular_points = [];
    I = im2gray(rgb);
    [m,n] = size(I);
    thresh = graythresh(I);
    bw = im2bw(I, 0.1);
    bw = ~bw;
    bw=bwmorph(bw, 'erode');
    bw=bwmorph(bw, 'dilate');
%     figure(2);imshow(bw);hold on;
    img_reg = regionprops(bw,  'area', 'boundingbox', 'ConvexHull');
    for i = 1 : height(img_reg)
        areas = [img_reg(i, 1).Area];
        if areas < 2000 || areas > 8000
            continue;
        end
        %轮廓外接矩形
        rect = cat(1,  img_reg(i, 1).BoundingBox);
        %外接矩形中心
        center = [rect(1) + rect(3)/2, rect(2) + rect(4)/2];
        Jp = getJiaoDian(center, img_reg(i).ConvexHull);
        %判断是否有六个角点
        if height(Jp) ~= 6
            continue;
        end
%         for j = 1 : 6
%             plot(Jp(j, 1), Jp(j, 2), 'r*');
% 
%         end
%         plot(rect(1) + rect(3)/2, rect(2) + rect(4)/2, 'g*');
%         rectangle('position', rect, 'EdgeColor', 'r');
        angular_points = [angular_points;Jp];
        obj_pos = [obj_pos;center];
        
    end
%  六边形角点提取
    function Jpoints = getJiaoDian(center, points)
        dist = [];
        for j = 1: height(points)
            dist(j) = ((center(1) - points(j,1)) * (center(1) - points(j,1)) + (center(2) - points(j,2)) * (center(2) - points(j,2)));
        end
        maxD = max(dist);
        id = find(maxD == dist);
        angular_point = [];
        angular_num = 1;
        for k = 1 : 5
            [px,py] = P_dip(points(id(1),:) ,center,  k * 60 * pi/ 180 );
            %圆形区域
            angles = [0 : 0.1: 1 ] * 2 * pi;
            xx = px + sqrt(maxD) * 0.1 * cos( angles );
            yy = py + sqrt(maxD) * 0.1 * sin( angles );
            d_ = [];
            count = 1;
             for j = 1 : height(points)
                in = inpolygon(points(j, 1), points(j, 2), xx, yy);
                if in == true
                    d_(count,1) = dist(j);
                    d_(count,2) = j;
                    count = count + 1;
                end
             end
             if width(d_) ~= 0
                max_d = max(d_(:,1));
                res_p = find(d_(:,1) == max_d);
                angular_point(angular_num) = d_(res_p(1), 2);
                angular_num = angular_num + 1;
             end
        end
        Jpoints = [points(id(1),:);points(angular_point(:),:)] ;
    end

    function [x, y] = P_dip(p1, p2, angle)
        x= (p1(1) - p2(1))*cos(angle) - (p1(2) - p2(2))*sin(angle) + p2(1) ;
        y= (p1(1) - p2(1))*sin(angle) + (p1(2) - p2(2))*cos(angle) + p2(2) ;
    end




end