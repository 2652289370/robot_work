clear;clc

xmlDoc = xmlread('params.xml');
% name_array = xmlDoc.getElementsByTagName('data');
% name = char(name_array.item(0).getFirstChild.getData);
M1xml=char(xmlDoc.getElementsByTagName('data').item(0).getFirstChild.getData);

M1=str2double(strsplit(strtrim(M1xml)));
LeftcameraMat=reshape(M1,3,3);

D1xml=char(xmlDoc.getElementsByTagName('data').item(1).getFirstChild.getData);
LeftcameraD=str2double(strsplit(strtrim(D1xml)));
LeftcameraD(LeftcameraD==0)=[];
CameraParameters1=cameraParameters("IntrinsicMatrix",LeftcameraMat,"RadialDistortion",LeftcameraD,...
    "NumRadialDistortionCoefficients",3);
