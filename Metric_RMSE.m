% Ezgi KO� taraf�ndan olu�turuldu.
% Root Mean Square Error
% Referans de�eri 0
% Her bir band�n pikselleri aras�ndaki fark�n karesinin ortalamas�n�n
% karek�k�

function [hata,araToplamBant] = Metric_RMSE(MSImage,Pansharp)

MSImageD = double(MSImage);
bantNum=size(MSImage,3);
PansharpD=double(Pansharp);
toplam=0;
araToplamBant = zeros(2,4); %araToplamBant her bant i�in RMSE de�erini vermektedir.

for bant=1:bantNum;
    kare = (MSImageD(:,:,bant) - PansharpD(:,:,bant)).^2;
    araToplam = mean2(kare (kare> 0));
    araToplamBant(bant) = sqrt(araToplam);
    toplam = toplam + araToplam;
end

hata=sqrt(toplam/bantNum);
araToplamBant();
end



