% Pan Keskinle�tirme Demosu
% ��lem                              Yazar                   
% 4 Bant Destegi                    Ezgi Ko�                
% 12.05.2014
% Ezgi SAn taraf�ndan g�ncellendi.
% Relative average spectral error
% Referans de�eri 0

function sonucRase = Metric_RASE( MSImage,Pansharp )

toplam = 0;
numBands = size(MSImage,3);

for i=1:numBands % Her bir bant i�in RMSE de�erinin karesi hesaplan�r.
    kare = (MSImage(:,:,i) - Pansharp(:,:,i)).^2;
    araToplam = mean2(kare (kare> 0));
    toplam = toplam + araToplam;
end
toplam  = sqrt(toplam/numBands); %Her band�n RMSE'lerinin karesi toplam� bant say�s�na b�l�n�r
clear kare
clear numBands
clear araToplam
ortRGB  = mean(MSImage(:));
sonucRase   = toplam*100/ortRGB;
end

