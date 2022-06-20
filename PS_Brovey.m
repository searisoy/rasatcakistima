% Brovey  metodu
% Pan: Pan-kromatik G�r�nt�
% MSImage = Multispektral goruntu
% Pansharp: Pan keskinle�tirilmesi yap�lm�� g�r�nt�
% ��lem                         Yazar              Tarih
% Kod olu�turuldu             MS. Seyfioglu      05.01.2014
% G�ncelleme                  Ezgi San           23.05.2014
% Perf. Improvement         Mustafa Teke    04.08.2014


function [Pansharp] = PS_Brovey(MSImage,Pan)
tic

if( strcmp( class(MSImage),'double') == 0 )
    MSImage = double(MSImage);
end

if( strcmp( class(Pan),'double') == 0 )
    Pan = double(Pan);
end

MSImageToplam = 0;
[rows, cols, bands] = size(MSImage);
Pansharp = zeros(rows, cols, bands);
%T�m bantlar�n toplam� elde edilir.

% for band = 1:bandnum
%     MSImageToplam = MSImageToplam + MSImage(:,:,band);
% end

MSImageToplam = sum(MSImage, 3);

%Band numaras� panla �arp�ld�ktan sonra MS g�r�nt�n�n her band�yla ...
%bant bant �arp�larak bantlar�n toplam�na b�l�nerek g�r�nt�
%keskinle�tirilir.
PanOverMSSum = bands*Pan./MSImageToplam;
parfor band = 1:bands
    Pansharp(:,:,band) = PanOverMSSum .* MSImage(:,:,band);
end

disp('Brovey=');
toc

end

