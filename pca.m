% PCA  metodu
% ��lem                         Yazar              Tarih
% Kod olu�turuldu             MS. Seyfioglu      05.01.2014
% imageRGB= renkli 3 bant g�r�nt�
% no_dims, number of dimensions. RGB i�in 3 dimension oldu�undan 3
% girilecek
% mapping i�erisinde eigenvectorleri, eigenvalueleri ve her bir bant i�in
% ortalama RGB de�erlerini tutan bir struct matris
% mappedX: Map edilmi� RGB de�erleri.

function [mappedX, mapping] = pca(imageRGB, no_dims)


    if ~exist('no_dims', 'var')
        no_dims = 2;
    end

	%RGB g�r�nt�y� zero mean olacak �ekilde ayarla. Gaussian.
	
    %Burada her bant i�in t�m piksel de�erlerinin ortalamas� al�nmakta
    mapping.mean = mean(imageRGB, 1);
    %Burada her piksel de�erinden ortalama de�er ��kart�l�p yeni bir matris
    %elde edilmekte
	imageRGB = imageRGB - repmat(mapping.mean, [size(imageRGB, 1) 1]);
    
	% kovaryans matrisini hesapla
    if size(imageRGB, 2) < size(imageRGB, 1)
    %sonuc olarak 3x3'l�k bir kovaryans matrisi elde ediyoruz.
        C = cov(imageRGB);
    else
        C = (1 / size(imageRGB, 1)) * (imageRGB * imageRGB');        % if N>D, eigendecomposition i�in bunu kullan
    end
	
	% C i�in eigendecomposition i�lemi yap
	C(isnan(C)) = 0;
	C(isinf(C)) = 0;
    [M, lambda] = eig(C);
    %lambda �zde�erleri, M ise �zvekt�rleri ifade etmekte
    clear C;
    
    % Eigenvectorleri azalan s�raya g�re diz
    [lambda, ind] = sort(diag(lambda), 'descend');
    if no_dims > size(M, 2)
        no_dims = size(M, 2);
        warning(['Target dimensionality reduced to ' num2str(no_dims) '.']);
    end
	M = M(:,ind(1:no_dims));
    lambda = lambda(1:no_dims);
	
	% Elde edilen veriye mapping yap�l�r.
    if ~(size(imageRGB, 2) < size(imageRGB, 1))
        M = (imageRGB' * M) .* repmat((1 ./ sqrt(size(imageRGB, 1) .* lambda))', [size(imageRGB, 2) 1]);     
    end
    mappedX = imageRGB * M;
    
    % out-of-sample extension i�in veriyi store et.
    mapping.M = M;
	mapping.lambda = lambda;
    