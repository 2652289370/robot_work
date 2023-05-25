

L1 = Link('alpha',    0,    'a',0,      'offset',0,    'd',0,'modified');
L2 = Link('alpha', pi/2,    'a',0,      'offset',0,    'd',-0.0,'modified');
L3 = Link('alpha',    0,    'a',0.0224, 'offset',0,    'd',0.0,'modified');
L4 = Link('alpha',    0,    'a',0.0224, 'offset',pi/2, 'd',-0.00524,'modified');
L5 = Link('alpha', pi/2,    'a',0.0   , 'offset',0,    'd', 0.0164,'modified');
L6 = Link('alpha',-pi/2,    'a',0.0,    'offset',0,    'd',0.00805,'modified');

robot5 = SerialLink( [L1 L2 L3 L4 L5 L6], 'name', 'AR 5-Axis' );
robot5.teach
q0 =  [0 30*pi/180 0 0 0 0];
TT = robot5.fkine( q0 );
qGo = q0;
pose0 = TT.double(); %% 转换成 4*4 矩阵 
% 当前位置对应的 x 坐标
pose0( 1, 4 ) = pose0( 1, 4 ) - 0.004;
pose0( 3, 4 ) = pose0( 3, 4 ) + 0.004;
% R = eul2rotm([pi/2, 36.4 * pi/ 180, pi/2]);
% pose0(1:3, 1:3) = R;
% pose0( 1, 4 ) = 0.061;
% pose0( 2, 4 ) = -0.003;
% pose0( 3, 4 ) = 0;
qq = robot5.ikine( pose0, 'q0', qGo, 'mask', [ 1 1 1 1 1 1] );