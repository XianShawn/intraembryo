%Volume is only 8 times of actual volume and the radius is the diameter ?
clear all;
IniImagei=421;
EndImagei=1379;
JpegImg=[];
JpegPath='D:\injection_volume_test\Pipette2\injection vlolume2\1500Pa_1s_pipette2\';
% select the potential area in which culture medium ball may present
JpegImg=imread([JpegPath,num2str(IniImagei),'.jpg']);
figure(1);
imshow(JpegImg);
[X1 Y1]=ginput(2);
Radius=[];
SubIniImg=JpegImg(Y1(1):Y1(2),X1(1):X1(2));
for image_i=IniImagei:EndImagei
    % substracting the present images to the initial image 
     BallPixNum=[];
     JpegImg=imread([JpegPath,num2str(image_i),'.jpg']);
     SubImg=JpegImg(Y1(1):Y1(2),X1(1):X1(2));
     SubImg=SubIniImg-SubImg;
     Imabw=im2bw(SubImg,0.15); 
     figure(1);
     imshow(Imabw);
     S=size(SubImg);
     % Initial the up position and down position array
     BallUpPos=zeros(1,S(2));
     BallDownPos=zeros(1,S(2));
     % Get the X position of the top position and bottom position of the
     % culture medium ball
     for j=1:S(2)
        for i=1:S(1)-2
            if(Imabw(i,j)>0&&Imabw(i+1,j)>0&&Imabw(i+2,j)>0)
                BallUpPos(j)=i;
                break;
            end
        end
        for i=S(1):-1:3
            if(Imabw(i,j)>0&&Imabw(i-1,j)>0&&Imabw(i-2,j)>0)
                BallDownPos(j)=i;
                break;
            end
        end
     end
     BallRadius=BallDownPos-BallUpPos;
     % save the radius(diameter actually)
     Ra=max(BallRadius);
     Radius=[Radius;Ra];
end
figure(1);
% convert the pixel to the um
Radius=Radius/6*10^-6;
% calculate the volume(eight time of volume)
V=4*pi*Radius.^3/3;
% save the volume and radius
fid1 = fopen([JpegPath,'R.txt'],'wt');
fprintf(fid1,'%g\n',Radius); 

fid2 = fopen([JpegPath,'V.txt'],'wt');
fprintf(fid2,'%g\n',V); 
plot(V);