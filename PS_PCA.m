% PCA Methodu
% ��lem                         Yazar              Tarih
% Kod olu�turuldu             MS. Seyfio�lu      05.01.2014
% G�ncelleme                  Ezgi San           23.05.2014
% Pan: Pan-kromatik G�r�nt�
% MSImage = Multispektral goruntu
% Pansharp: Pan keskinle�tirilmesi yap�lm�� g�r�nt�


function [Pansharp]=PS_PCA(MSImage,Pan)
tic

if( strcmp( class(MSImage),'double') == 0 )
    MSImage = double(MSImage);
end

if( strcmp( class(Pan),'double') == 0 )
    Pan = double(Pan);
end

[n,m,d] = size(MSImage);
MSImage = reshape( MSImage, [n*m,d]);

%�lk olarak RGB g�r�nt�n�n her band� i�in temel bile�enleri bulunur.
%Burada RGB image bir vekt�r haline getirilmi�tir.

[pcaData, pcaMap]= pca(MSImage,d);
pcaData = reshape(pcaData, [n,m,d]);
Pansharp = pcaData;
clear pcaData
%     histband = imhist(fusedimage(:,:,1));
%     Pan=histeq(Pan,histband);

%histband1=imhist(F(:,:,1));
%histP=histeq(P, histband1);

Pan = Pan * std(std(Pansharp(:,:,1))) / std(std(Pan));
Pan = Pan - (mean(mean(Pan))) - mean(mean(Pansharp(:,:,1)));

% pan band�n�n histogram modifikasyonu yap�l�r.(ortalamas� ve standart sapmas�
% ilk temel bile�en ile �ak��acak �ekilde.)
%     Pan=(Pan-mean(Pan(:)))*std(fusedimage(:))/std(Pan(:)) + mean(fusedimage(:));

%�lk temel bile�en en y�ksek varyansa sahip oldu�undan Pan image ile yer degistirir.

Pansharp(:,:,1) = Pan;
% Ters PCA ile Pan keskinle�tirmesi yap�lm�� g�r�nt� elde edilir.
Pansharp = inversepca(pcaMap.M, reshape(Pansharp,[n*m,d]), pcaMap.mean,Pansharp);
Pansharp = reshape(Pansharp, [n,m,d]);
disp('PCA=');

toc

end

