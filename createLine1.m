function [ direction,intercept ] = createLine1( point1, point2 )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
direction = (point1(:,2) - point2(:,2))/(point1(:,1) - point2(:,1));
intercept = point1(:,2) - point1(:,1)*direction;


end

