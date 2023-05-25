function Pos = CaulPos(obj_pos)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
    Pos = [];
    camParams = LoadParams('data/params.xml');
    for i = 1 : height(obj_pos) / 7
        center = obj_pos((i - 1) * 7 + 1,:);
        worldP = [[0, 0,0]];
        IamgeP = [center];
        for j = (i - 1) * 7 + 2: (i - 1) * 7 + 7
            jiaoDian = obj_pos(j,:);
            p = jiaoDian - center;
            thata = atan2(p(2),p(1));
            x = 25 * cos(thata);
            y = 25 * sin(thata);
            worldP = [worldP;x,y,0];
            IamgeP = [IamgeP;jiaoDian];
        end
        [R,T] = CaulDepth(camParams, worldP, IamgeP);
        Pos = [Pos;T'];
    end
end