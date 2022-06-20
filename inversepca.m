% PCA  metodu (inverse PCA )
% ��lem                         Yazar              Tarih
% Kod olu�turuldu             MS. Seyfioglu      05.01.2014

%E=kovaryans matrisi.
%meanV= RGB image'�n her bir bant i�in ortalama de�eri
%P=fusedimage (yani pca i�lemi sonras� en y�ksek varyansl� de�er yerine pan
%g�r�nt�n�n al�nd��� image.)

function [inversematrix]= inversepca(E,P,meanV,PS)
[m,n]=size(P);
 [rows,cols,bantnum]=size(PS);
 for bant=1:bantnum
 c(1:m,bant)=meanV(bant);
 end
inversematrix =(P*transpose(E))+ c;
end