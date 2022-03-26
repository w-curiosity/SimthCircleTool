function varargout = menu_1(varargin)
% MENU_1 MATLAB code for menu_1.fig
%      MENU_1, by itself, creates a new MENU_1 or raises the existing
%      singleton*.
%
%      H = MENU_1 returns the handle to a new MENU_1 or the handle to
%      the existing singleton*.
%
%      MENU_1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MENU_1.M with the given input arguments.
%
%      MENU_1('Property','Value',...) creates a new MENU_1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before menu_1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to menu_1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help menu_1

% Last Modified by GUIDE v2.5 03-May-2020 21:08:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @menu_1_OpeningFcn, ...
                   'gui_OutputFcn',  @menu_1_OutputFcn, ...
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


% --- Executes just before menu_1 is made visible.
function menu_1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to menu_1 (see VARARGIN)

% Choose default command line output for menu_1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes menu_1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = menu_1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --------------------------------------------------------------------
function menu_1_Callback(hObject, eventdata, handles)
% hObject    handle to menu_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h=gcf; menu_1;close(h);

% --------------------------------------------------------------------
function menu_2_Callback(hObject, eventdata, handles)
% hObject    handle to menu_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h=gcf; menu_2; close(h);


% --------------------------------------------------------------------
function menu_3_Callback(hObject, eventdata, handles)
% hObject    handle to menu_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h=gcf; menu_3; close(h);
