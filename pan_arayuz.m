%Sertac Arisoy
%20/06/2022
%Görüntü Çakistirma Arayuzu

function varargout = pan_arayuz(varargin)
% PAN_ARAYUZ MATLAB code for pan_arayuz.fig
%      PAN_ARAYUZ, by itself, creates a new PAN_ARAYUZ or raises the existing
%      singleton*.
%
%      H = PAN_ARAYUZ returns the handle to a new PAN_ARAYUZ or the handle to
%      the existing singleton*.
%
%      PAN_ARAYUZ('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PAN_ARAYUZ.M with the given input arguments.
%
%      PAN_ARAYUZ('Property','Value',...) creates a new PAN_ARAYUZ or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before pan_arayuz_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to pan_arayuz_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help pan_arayuz

% Last Modified by GUIDE v2.5 20-Jun-2022 14:49:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @pan_arayuz_OpeningFcn, ...
                   'gui_OutputFcn',  @pan_arayuz_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before pan_arayuz is made visible.
function pan_arayuz_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to pan_arayuz (see VARARGIN)

handles.I_HS_SON = 0;
handles.IH_R_SON = 0;
handles.method='0';


% Choose default command line output for pan_arayuz
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

set(handles.uitable1,'Data',cell(5,1));
set(handles.uitable1, 'RowName', {'RMSE', 'SAM', 'RASE', 'QAVE', 'ERGAS'}, 'ColumnName', {'Sonuclar'});



% UIWAIT makes pan_arayuz wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = pan_arayuz_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

ratio=2;
%Cakistirma Algoritmalari: Algoritmalar icin asagidaki calismalardan
%olusturulmus kutuphaneler kullanilmistir.
%A. Arienzo, G. Vivone, A. Garzelli, L. Alparone, and J. Chanussot, "Full Resolution Quality Assessment of Pansharpening: Theoretical and Hands-on Approaches", 
%IEEE Geoscience and Remote Sensing Magazine, 2022.
%RASAT Pansharpening Teke, M.; Seyfio?lu, M.S.; A?cal, A;Gürbüz,S.Z., "RASAT Uydu Görüntülerinin Optimal Pankeskinle?tirilmesi" 
%IEEE 22. Sinyal ??leme ve ?leti?im Uygulamalar? Kurultay?, vol., no., pp.1967-1970,23-25 Nisan 2014.


switch handles.method
    case 'BT'
        t2=tic;
        handles.Pansharp = PS_Brovey(handles.I_HS_SON,handles.I_PAN);
        time_MF = toc(t2);
        fprintf('Elaboration time MF: %.2f [sec]\n', time_MF);
    case 'PCA'
        t2=tic;
        handles.Pansharp = PS_PCA(handles.I_HS_SON,handles.I_PAN);
        time_MF = toc(t2);
        fprintf('Elaboration time MF: %.2f [sec]\n', time_MF);     
    case 'GS'    
        t2=tic;
        handles.Pansharp = PS_GS(handles.I_HS_SON,handles.I_PAN);
        time_MF = toc(t2);
        fprintf('Elaboration time MF: %.2f [sec]\n', time_MF);   
    case 'GSA'
        cd GS
        t2=tic;
        handles.Pansharp = GSA(handles.I_HS_SON, handles.I_PAN, handles.IH_S, ratio);
        time_MF = toc(t2);
        fprintf('Elaboration time MF: %.2f [sec]\n', time_MF);
        cd ..
    case 'PRACS'
        cd PRACS
        t2=tic;
        handles.Pansharp = PRACS(handles.I_HS_SON, handles.I_PAN, ratio);
        time_MF = toc(t2);
        fprintf('Elaboration time MF: %.2f [sec]\n', time_MF);
        cd ..
    case 'BT-H'
        cd BT-H
        t2=tic;
        handles.Pansharp = BroveyRegHazeMin(handles.I_HS_SON, handles.I_PAN, ratio);
        time_MF = toc(t2);
        fprintf('Elaboration time MF: %.2f [sec]\n', time_MF);
        cd ..
     case 'MF'
        cd MF
        t2=tic;
        handles.Pansharp= MF_HG_Pansharpen(handles.I_HS_SON, handles.I_PAN, ratio);
        time_MF = toc(t2);
        fprintf('Elaboration time MF: %.2f [sec]\n', time_MF);
        cd ..
end   


%PAN ile L1R 'yi Karsilastirma Sonuclari
handles.IH_R_SON=double(handles.IH_R_SON);

%RMSE
rmseSonuc = Metric_RMSE(handles.IH_R_SON,handles.Pansharp);

%SAM
sam_angle = Metric_SAM(handles.IH_R_SON,handles.Pansharp);
sam_angle = abs(sam_angle);

%RASE
sonucRase = Metric_RASE(handles.IH_R_SON,handles.Pansharp);

%QAVE
qaveSonuc = Metric_QAVE(handles.IH_R_SON,handles.Pansharp);

%ERGAS
ERGASsonuc = Metric_ERGAS(handles.IH_R_SON,handles.Pansharp);

%Tabloya sonuclari aktarma
tableData =[rmseSonuc; sam_angle; sonucRase;...
            qaveSonuc; ERGASsonuc];

%update the table
set(handles.uitable1,'data',tableData);


%Imgeleri arayüzde cizdirme

for i=1:3
handles.Pansharp(:,:,i)=handles.Pansharp(:,:,i)./max(handles.Pansharp(:,:,i));
end

for i=1:3
handles.IH_R_SON(:,:,i)=handles.IH_R_SON(:,:,i)./max(handles.IH_R_SON(:,:,i));
end

%PAN ile cakistirilmis imge
axes(handles.axespan)
imshow(handles.Pansharp);

%L1R imgesi
axes(handles.axesl1r)
imshow(handles.IH_R_SON);

guidata(hObject,handles);


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1
str = get(hObject,'String');
val = get(hObject,'Value');

handles.method = str{val};

guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2

str = get(hObject,'String');
val = get(hObject,'Value');
[rows, cols] = size(handles.I_PAN);

%Ara Degerleme
switch str{val}
    case 'Cubic'
        handles.I_HS_SON = imresize(handles.IH_S, [rows, cols], 'cubic');
        handles.IH_R_SON = imresize(handles.IH_R, [rows, cols], 'cubic');   
    case 'Nearest'
        handles.I_HS_SON = imresize(handles.IH_S, [rows, cols], 'nearest');
        handles.IH_R_SON = imresize(handles.IH_R, [rows, cols], 'nearest'); 
    case 'Bilinear'
        handles.I_HS_SON = imresize(handles.IH_S, [rows, cols], 'bilinear');
        handles.IH_R_SON = imresize(handles.IH_R, [rows, cols], 'bilinear'); 
end   
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when entered data in editable cell(s) in uitable1.
function uitable1_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to uitable1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Imgelerin bulundugu dizinin secimi
handles.pathname = string(uigetdir('C:\'));

%Imgelerin Okunmasi
IMB=imread(char(handles.pathname + '\RST_20200915_e74_2_L1\1\image.tif'));
IMG=imread(char(handles.pathname + '\RST_20200915_e74_2_L1\2\image.tif'));
IMR=imread(char(handles.pathname + '\RST_20200915_e74_2_L1\3\image.tif'));
    
IH_S = cat(3, IMR, IMG, IMB);
handles.IH_S = IH_S;

% L1R Multispectral
IMBR=imread(char(handles.pathname + '\RST_20200915_e74_2_L1R\1\image.tif'));    
IMGR=imread(char(handles.pathname + '\RST_20200915_e74_2_L1R\2\image.tif'));    
IMRR=imread(char(handles.pathname + '\RST_20200915_e74_2_L1R\3\image.tif')); 

IH_R = cat(3, IMRR, IMGR, IMBR);
handles.IH_R= IH_R;

%PAN
I_PAN=imread(char(handles.pathname + '\RST_20200915_e74_2_L1\0\image.tif'));
handles.I_PAN= I_PAN;

guidata(hObject,handles);
