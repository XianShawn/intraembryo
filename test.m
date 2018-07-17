% read image
strengthImage = 0;
rootPath = 'C:\Users\Xian_Wang\Desktop\embryo action_processed\';
cellPath = ['MAX_well1_embryo2_DAPI_actin x402',
    'MAX_well2_embryo1_DAPI_actin x402',
    'MAX_well2_embryo2_DAPI_actin x402',
    'MAX_well3_embryo1_DAPI_actin x402',
    'MAX_well3_embryo2_DAPI_actin x402',
    'MAX_well4_embryo1_DAPI_actin x402',
    'MAX_well5_embryo1_DAPI_actin x402',
    'MAX_well5_embryo2_DAPI_actin x402',
    'MAX_well6_embryo1_DAPI_actin x402',
    'MAX_well6_embryo2_DAPI_actin x402'];

strengthCell = zeros(10,1);
for cellIndex = 1:10
strengthImage = 0;
for image = 10
I = imread(strcat(rootPath,cellPath(cellIndex,:),'\',cellPath(cellIndex,:),'_', int2str(image),'.jpg') );
%I=imread('MAX_well1_embryo2_DAPI_actin x402_1.jpg');
%imshow(I)

% convert image into 1,0
% 1: connection; 0: white
%I(I~=255) = 1;
%I(I==255) = 0;

% find the coordinate of connections
[rowsCon, colsCon] = find(I~=255);
numCon = length(rowsCon);

% create the straight baseline (going throught the first and last pixels of the connection)
line = createLine([rowsCon(1), colsCon(1)], [rowsCon(end), colsCon(end)]);

% find projections
projections = projPointOnLine([rowsCon, colsCon], line);

% calculate MSE (distance)
sumDist = 0;

for i = 1:numCon
    sumDist = sumDist + sqrt(pdist([[rowsCon(i), colsCon(i)]; projections(i,:)]));
end

strength = sumDist/numCon;
strengthImage = strengthImage + strength;
end

strengthCell(cellIndex) = strengthImage/1;
end




