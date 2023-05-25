function [R,T] = CaulDepth(camParams,WorldPoint, ImagePoint)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    [worldOrientation,worldLocation,~] = estimateWorldCameraPose(ImagePoint,WorldPoint,camParams);
    %转换相机坐标系相对世界坐标系的旋转和平移矩阵
    [rotationMatrix,translationVector] = cameraPoseToExtrinsics(worldOrientation,worldLocation);
    R=rotationMatrix';
    T=translationVector';
end