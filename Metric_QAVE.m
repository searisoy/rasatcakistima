% Pan Keskinle�tirme Demosu
% ��lem                              Yazar                   Tarih
% 4 Bant Destegi                    Ezgi Ko�                20.12.2013
% 12.05.2014
% Ezgi KO� taraf�ndan g�ncellendi.
% Referans de�eri 1

function [ qaveSonuc ] = Metric_QAVE( MSImage,pansharpImage )

numBands=size(MSImage,3);
DataDimension = 3;
rgbBantOrt=mean(MSImage,DataDimension); %RGB bant ortalamas�
pansharpBantOrt=mean(pansharpImage,DataDimension); %Pansharp bant ortalamas�
MSImageD = double(MSImage);
SigmaX=0;
SigmaY=0;
SigmaXY=0;

for band= 1:numBands
    %Her RGB band�n�n bant ortalamas�yla fark�n�n karesi
    SigmaX=SigmaX+((MSImageD(:,:,band)-rgbBantOrt).^2);
    
    %Her Pansharp band�n�n bant ortalamas�yla fark�n�n karesi
    SigmaY=SigmaY+((pansharpImage(:,:,band)-pansharpBantOrt).^2);
    
    SigmaXY=SigmaXY+(MSImageD(:,:,band)-rgbBantOrt).*...
        (pansharpImage(:,:,band)-pansharpBantOrt);
end

SigmaX=SigmaX /(numBands-1);
SigmaY=SigmaY /(numBands-1);
SigmaXY=SigmaXY /(numBands-1);
Q=(4*(SigmaXY.*rgbBantOrt.*pansharpBantOrt))./...
    ((SigmaX+SigmaY).*(rgbBantOrt.^2+pansharpBantOrt.^2));
Q(isnan(Q))=1;
qaveSonuc=mean(Q(:));
end