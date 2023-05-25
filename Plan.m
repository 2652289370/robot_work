function [bool] = Plan(obj_pos)
%   机械臂轨迹规划
%   obj_pos为输入物体的坐标信息

L1 = Link('alpha',    0,    'a',0,      'offset',0,    'd',0,'modified');
L2 = Link('alpha', pi/2,    'a',0,      'offset',0,    'd',-0.0,'modified');
L3 = Link('alpha',    0,    'a',0.0224, 'offset',0,    'd',0.0,'modified');
L4 = Link('alpha',    0,    'a',0.0224, 'offset',pi/2, 'd',-0.00524,'modified');
L5 = Link('alpha', pi/2,    'a',0.0   , 'offset',0,    'd', 0.0164,'modified');
L6 = Link('alpha',-pi/2,    'a',0.0,    'offset',0,    'd',0.00805,'modified');

robot5 = SerialLink( [L1 L2 L3 L4 L5 L6], 'name', 'AR 5-Axis' );

q0 = [0 0 0 0 0 0];

TT = robot5.fkine( q0 );


ArmLen = 0.16977 + 0.305 + 0.2263;

pose0 = TT.double(); %% 转换成 4*4 矩阵 
% 当前位置对应的 x 坐标
xcur = pose0( 1, 4 );
% 当前位置对应的 y 坐标
ycur = pose0( 2, 4 );
% 当前位置对应的 z 坐标
zcur = pose0( 3, 4 );

target_q = [];
for i = 1 : height(obj_pos)
    pose0( 1, 4 ) = pose0( 1, 4 ) + obj_pos(i, 1);
    pose0( 2, 4 ) = pose0( 2, 4 ) + obj_pos(i, 2);
    pose0( 3, 4 ) = pose0( 3, 4 ) + obj_pos(i, 3);
    qGo = q0;
    qq = robot5.ikine( pose0, 'q0', qGo, 'mask', [ 1 1 1 1 1 1] );
    target_q = [target_q;qq]
end

bool = true;

end