function varargout = menu_2(varargin)
% MENU_2 MATLAB code for menu_2.fig
%      MENU_2, by itself, creates a new MENU_2 or raises the existing
%      singleton*.
%
%      H = MENU_2 returns the handle to a new MENU_2 or the handle to
%      the existing singleton*.
%
%      MENU_2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MENU_2.M with the given input arguments.
%
%      MENU_2('Property','Value',...) creates a new MENU_2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before menu_2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to menu_2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help menu_2

% Last Modified by GUIDE v2.5 04-May-2020 20:02:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @menu_2_OpeningFcn, ...
                   'gui_OutputFcn',  @menu_2_OutputFcn, ...
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


% --- Executes just before menu_2 is made visible.
function menu_2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to menu_2 (see VARARGIN)

% Choose default command line output for menu_2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% 初始化图像
global flag0;
flag0 = 1;
axis square;
wavelengths = 0:.01:.5;
phaseAngle = linspace(pi,-pi,length(wavelengths));
wave_circle = 1.05*exp(1i*phaseAngle);
plot(real(wave_circle),imag(wave_circle),'b');
hold on;
% 标注虚轴刻度
for i=1:length(wavelengths)-1
    x=real(1.025*exp(1i*phaseAngle(i)));
    y=imag(1.025*exp(1i*phaseAngle(i)));
    if(x>0)
        rot_angle=atan(y/x)*180/pi-90;
    else
        rot_angle=atan(y/x)*180/pi+90;
    end
    if(wavelengths(i)==0)
        word = '0.00';
    elseif(mod(wavelengths(i),.1)==0)
        word =[num2str(wavelengths(i)) '0'];
    else
        word = num2str(wavelengths(i));
    end
    set(text(x,y,word),'Rotation',rot_angle,'VerticalAlignment','middle','HorizontalAlignment','center')
end
% 坐标轴范围
set(handles.axes1,'XLim',[-1.1,1.1],'YLim',[-1.1,1.1]);
interval = [.01:.01:.2,.22:.02:.5,.55:.05:1,1.1:.1:2 , 2.2:.2:5 , 6:10 , 12:2:20 , 30:10:50];
% interval2 = [.01:.01:.5 , .55:.05:1 , 1.1:.1:2 , 2.2:.2:5 , 6:10 , 12:2:20 , 30:10:50];
% 画电阻圆族
U = @(R,X)(R^2+X^2-1)/(R^2+2*R+1+X^2);
% V = @(R,X)(2*X)/(R^2+2*R+1+X^2);
MAX = 2019;
min_bound1 = 0;
min_bound2 = 0;
max_bound2 = 0;
Gr = linspace(-1,1,MAX);
axis square
plot(Gr, zeros(1,length(Gr)),'k');
hold on
for R = interval
    min_bound1 = (R-1)/(R+1);
    if (R<0.2)
        if (mod(R,0.1) == 0)
            max_bound = U(R,2);
        elseif (mod(R,0.02) == 0)
            max_bound = U(R,0.5);
        else
            max_bound = U(R,0.2);
        end
        if(R == 0.05 || (R<0.151 && R>0.149)) 
            min_bound2 = U(R,0.5);
            max_bound2 = U(R,1);
        end
    elseif (R<0.5)
        if (mod(R,0.2) == 0)
            max_bound = U(R,5);
        elseif (mod(R,0.1) == 0)
            max_bound = U(R,2);
        elseif (R == 0.55 || R == 0.65 || R == 0.75)
            temp = U(R,0.5);
            min_bound2 = max(min_bound1,temp);
            max_bound = U(R,1);
        else
            max_bound = U(R,0.5);
        end
    elseif (R<1)
        if (mod(R,0.2) == 0)
            max_bound = U(R,5);
        elseif (mod(R,0.1) == 0)
            max_bound = U(R,2);
        elseif (R == 0.25 || R == 0.35 || R == 0.45)
            temp = U(R,0.5);
            min_bound2 = max(min_bound1,temp);
            max_bound = U(R,1);
        elseif (R<0.5)
            max_bound = U(R,0.5);
        else
            max_bound = U(R,1);
        end
    elseif (R<5)
        if (mode(R,2) == 0)
            max_bound = U(R,20);
        elseif (mod(R,1) == 0)
            max_bound = U(R,10);
        elseif (R>2)
            max_bound = U(R,5);
        else
            if (mod(R,0.2) == 0)
                max_bound = U(R,5);
            else
                max_bound = U(R,2);
            end
        end
    elseif (R<10)
        if (mod(R,2) == 0)
            max_bound = U(R,20);
        else
            max_bound = U(R,10);
        end
    else
        if (R == 10 || R == 20)
            max_bound = U(R,50);
        elseif (R == 50)
            max_bound = 1;
        elseif (R<20)
            max_bound = U(R,20);
        else
            max_bound = U(R,50);
        end
    end
    index = ceil((min_bound1 + 1)*(MAX - 1)/2 + 1);
    actual_value = Gr(index);
    if (actual_value<min_bound1)
        index = index + 1; 
    end
    MIN=index;
    index = ceil((max_bound + 1)*(MAX - 1)/2 + 1);
    actual_value = Gr(index);
    if (actual_value>max_bound)
        index = index - 1;
    end
    MIN2 = ceil((min_bound2 + 1)*(MAX - 1)/2 + 1);
    actual_value = Gr(MIN2);
    if (actual_value<min_bound2)
        MIN2 = MIN2 + 1;
    end
    MAX2 = ceil((max_bound2+1)*(MAX-1)/ 2+1);
    actual_value = Gr(MAX2);
    if(actual_value<max_bound2)
        MAX2 = MAX2 + 1;
    end
    r_L_a=1/(R+1)*(-(R+1)*(R-2*R.*Gr(MIN:index)+ R.*Gr(MIN:index).^2-1+Gr(MIN:index).^2)).^(1/ 2 );
    r_L_b=-1/(R+1)*(-(R+1)*(R-2*R.*Gr(MIN:index)+ R.*Gr(MIN:index).^2-1+Gr(MIN:index).^2)).^(1/ 2 );
    r_L_b(1)=0;
    r_L_a(1)=0;
    r_L_a2=1/(R+1)*(-(R+1)*(R-2*R.*Gr(MIN2:MAX2 )+R.*Gr(MIN2:MAX2).^2-1+Gr(MIN2:MAX2).^2)).^(1/2);
    r_L_b2=-1/(R+1)*(-(R+1)*(R-2*R.*Gr(MIN2:MAX2)+R.*Gr(MIN2:MAX2).^2-1+Gr(MIN2:MAX2).^2 )).^(1/2);
    r_L_a3=1/(R+1)*(-(R+1)*(R-2*R.*Gr(MIN2:index) +R.*Gr(MIN2:index).^2-1+Gr(MIN2:index).^2)).^(1/2);
    r_L_b3=-1/(R+1)*(-(R+1)*(R-2*R.*Gr(MIN2:index)+R.*Gr(MIN2:index).^2-1+Gr(MIN2:index).^2)).^(1/2);
    if(~(R>.2 && R<.5 && ~(mod(R,.02)==0)))
        if(R==1)
            color = 'r';
        else
            color ='b';
        end
    end
    plot(Gr(MIN:index),r_L_a(1:index-MIN+1),color,Gr(MIN:index), r_L_b(1:index-MIN+1),color);
    if(R<=1)
        if(mod(R,1)==0)
            word = [num2str(R) '.0'];
        else
            word = num2str(R);
        end
        if(mod(R,.1)==0)
            set(text(Gr(MIN),0,word),'Rotation',90,'HorizontalAlignment','left','VerticalAlignment','bott om');
        end
    elseif(R<=2)
        if(mod(R,.2)==0)
            if(mod(R,1)==0)
                word = [num2str(R) '.0'];
            else
                word = num2str(R);
            end
            set(text(Gr(MIN),0,word),'Rotation',90,'HorizontalAlignment','left','VerticalAlignment','bott om');
        end
    elseif(R<=5)
        if(mod(R,1)==0)
            set(text(Gr(MIN),0,[num2str(R) '.0']),'Rotation',90,'HorizontalAlignment','left','VerticalAlignment','bottom');
        elseif(mod(R,10)==0) 
            set(text(Gr(MIN),0,num2str(R)),'Rotation',90,'HorizontalAlignment','left','VerticalAlignment' ,'bottom'); 
        end
    elseif(R == 0.25 || R == 0.35 || R==0.45)
        plot(Gr(MIN2:index),r_L_a3,'b');
        plot(Gr(MIN2:index),r_L_b3,'b');
    elseif(R==.05 || (R>.149 && R<.151)) 
        plot(Gr(MIN2:MAX2),r_L_a2(length(Gr(MIN2:MAX2))-length(r_L_a2)+1:length(r_L_a2)),'b'); 
        plot(Gr(MIN2:MAX2),r_L_b2(length(Gr(MIN2:MAX2))-length(r_L_b2)+1:length(r_L_b2)),'b');
    end
end
% 画电抗圆族
for X = interval
    inter_bound = (-1+X^2)/(X^2+1);
    imag_bound = (-1+X)/X;
    angle_point = 0;
    if(inter_bound ~= 0)
        angle_point = sqrt(1-inter_bound^2)/inter_bound;
    end
    imag_bound_y = 1/2/X*(-2+2*(1-X^2+2*X^2.*inter_bound-X^2.*inter_bound.^2).^(1/2));
    imag_rad = (imag_bound^2 + imag_bound_y^2)^(1/2);
    condition = imag_rad < 1;
    if(inter_bound > 1)
        inter_bound = 1;
    elseif(inter_bound < -1)
        imag_bound=-1;
    end
    if(imag_bound > 1)
        imag_bound = 1;
    elseif(imag_bound < -1)
        imag_bound=-1;
    end
    if(X<0.2)
        if(mod(X,.1)==0)
            max_bound = U(2,X);
        elseif(mod(X,.02)==0)
            max_bound = U(0.5,X);
        else
            max_bound = U(0.2,X);
        end
    elseif(X<1)
        if(mod(X,0.2) == 0)
            max_bound = U(5,X);
        elseif(mod(X,0.1) == 0)
            max_bound = U(2,X);
        elseif(x<0.5)
            max_bound = U(0.5,X);
        else
            max_bound = U(1,X);
        end
    elseif(X<5)
        if(mod(X,2) == 0)
            max_bound = U(20,X);
        elseif(mod(X,1) == 0)
            max_bound = U(10,X);
        elseif(x>2)
            max_bound = U(5,X);
        else
            if(mod(X,0.2) == 0)
                max_bound = U(5,X);
            else
                max_bound = U(2,X);
            end
        end
    elseif(X<10)
        if(mod(X,2) == 0)
            max_bound = U(20,X);
        else
            max_bound = U(10,X);
        end
    else
        if(X == 10 || X == 20)
            max_bound = U(50,X);
        elseif(X == 50)
            max_bound = 1;
        elseif(X<20)
            max_bound = U(20,X);
        else
            max_bound = U(50,X);
        end
    end
    inter_index = ceil((inter_bound+1)*(MAX-1)/ 2+1);
    imag_index = ceil((imag_bound+1)*(MAX-1)/ 2+1);
    index4 = ceil((max_bound+1)*(MAX-1)/ 2+1);
    index1 = max(inter_index,imag_index);
    index2 = min(imag_index,inter_index);
    if(condition)
        index3=imag_index;
    else
        index3=inter_index;
    end 
    actual_value1 = Gr(index1);
    actual_value2 = Gr(index2);
    actual_value3 = Gr(index3);
    actual_value4 = Gr(index4);
    if((actual_value1 > inter_bound && index1 == inter_index)||(actual_value1 > imag_bound && index1 == imag_index))
        index1 = index1 - 1;
    end
    if((actual_value2 < inter_bound && index2 == inter_index)||(actual_value2 < imag_bound && index2 == imag_index))
        index2 = index2 + 1;
    end
    if((actual_value3 < inter_bound && index3 == inter_index)||(actual_value3 < imag_bound && index3 == imag_index))
        index3 = index3 + 1; 
    end
    if(actual_value4 > max_bound)
        index4 = index4 - 1;
    end
    MIN = index2;
    MAX2 = index1;
    MAX3 = index4;
    MIN2 = index3;
    x_L_a = real(1/2/X*(-2+2*(1-X^2+2*X^2.*Gr(MIN2:MAX3 )-X^2.*Gr(MIN2:MAX3).^2).^(1/ 2)));
    x_L_b = real(1/2/X*(2-2*(1-X^2+2*X^2.*Gr(MIN2:MAX3)-X^2.*Gr(MIN2:MAX3).^2).^(1 /2)));
    x_L_c= real(1/2/X*(2+2*(1-X^2+2*X^2.*Gr(MIN:MAX2)-X^2.*Gr(MIN:MAX2).^2).^(1/ 2)));
    x_L_d= real(1/2/X*(-2-2*(1-X^2+2*X^2.*Gr(MIN:MAX2)-X^2.*Gr(MIN:MAX2).^2).^(1/ 2)));
    if(MIN2<MAX3)
        x_L_c(1)=x_L_b(1);
        x_L_d(1)=x_L_a(1);
    end
    check1 = abs(round(10000*1 /2/X*(-2-2*(1-X^2+2*X^2*inter_bound-X^2*inter_bound^2)^(1/2))));
    check2 = abs(round(10000*(1-inter_bound^2)^(1 /2))); 
    if(imag_bound > -1 && check1 == check2)
        plot(Gr(MIN:MAX2),x_L_c,'g')
        plot(Gr(MIN:MAX2),x_L_d,'g')
    end
    plot(Gr(MIN2:MAX3),x_L_a,'g')
    plot(Gr(MIN2:MAX3),x_L_b,'g') 
    condition = Gr(MIN2)^2 + x_L_d(1)^2 > .985;
    if(X<=1)
        if(mod(X,.1)==0)
            if(mod(X,1)==0)
                word = [num2str(X) '.0'];
            else
                word = num2str(X);
            end
            if(X==1)
                angle = 90;
            else
                angle = -atan(angle_point)*180/pi;
                set(text(Gr(MIN2),x_L_d(1),word),'Rotation',angle,'VerticalAlignment','bottom','HorizontalAlignment','left'); 
                set(text(Gr(MIN2),-x_L_d(1),word),'Rotation',-angle+180,'HorizontalAlignment','right','VerticalAlignment','bottom');
            end
            if(mod(X,.2)==0)
            xval = X^2/(X^2+4);
            yval = 1/2/X*(-2+2*(1-X^2+2*X^2*xval-X^2*xval^2)^(1/2));
            angle = -atan(yval/(.5-xval))*180/pi;
            set(text(xval,yval,word),'Rotation',angle,'HorizontalAlignment','left','VerticalAlignment','bottom');
            set(text(xval,-yval,word),'Rotation',-angle+180,'HorizontalAlignment','right','VerticalAlignment','bottom')
            end
        end
    elseif(X<=2)
        if(mod(X,.2)==0)
            if(mod(X,1)==0)
                word = [num2str(X) '.0'];
            else
                word = num2str(X);
            end
            if(condition)
                angle = -atan(angle_point)*180/pi+180;
                set(text(Gr(MIN2),x_L_a(1),word),'Rotation',angle,'VerticalAlignment','bottom','HorizontalAlignm ent','left'); 
                set(text(Gr(MIN2),-x_L_a(1),word),'Rotation',-angle+180,'HorizontalAlignment','right','VerticalAli gnment','bottom');
            else
                angle = -atan(angle_point)*180/pi+180; 
                set(text(Gr(MAX2),x_L_d(length(x_L_d)),word),'Rotation',angle,'VerticalAlignment','botto m','HorizontalAlignment','left'); 
                set(text(Gr(MAX2),-x_L_d(length(x_L_d)),word),'Rotation',-angle+180,'HorizontalAlignment' ,'right','VerticalAlignment','bottom');
            end
        end
    elseif(X<=5)
        if(mod(X,1)==0)
            if(condition)
                angle = -atan(angle_point)*180/pi+180;
                set(text(Gr(MIN2),x_L_a(1),[num2str(X) '.0']),'Rotation',angle,'VerticalAlignment','botto m','HorizontalAlignment','left');
            set(text(Gr(MIN2),-x_L_a(1),[num2str(X) '.0']),'Rotation',-angle+180,'HorizontalAlignment ','right','VerticalAlignment','bottom');
            else
                angle = -atan(angle_point)*180/pi+180;
                set(text(Gr(MAX2),x_L_d(length(x_L_d)),[num2str(X) '.0']),'Rotation',angle,'VerticalAlignment','bottom','HorizontalAlignment','left'); 
                set(text(Gr(MAX2),-x_L_d(length(x_L_d)),[num2str(X) '.0']),'Rotation',-angle+180,'HorizontalAlignment','right','VerticalAlignment','bottom');
            end
        end
    else
        if(mod(X,10)==0)
            if(condition)
                angle = -atan(angle_point)*180/pi+180;
                set(text(Gr(MIN2),x_L_a(1),num2str(X)),'Rotation',angle,'VerticalAlignment','bottom','HorizontalAlignment','left'); 
                set(text(Gr(MIN2),-x_L_a(1),num2str(X)),'Rotation',-angle+180,'HorizontalAlignment','right','VerticalAlignment','bottom');
            else
                angle = -atan(angle_point)*180/pi+180; 
                set(text(Gr(MAX2),x_L_d(length(x_L_d)),num2str(X)),'Rotation',angle,'VerticalAlignment','bottom','HorizontalAlignment','left'); 
                set(text(Gr(MAX2),-x_L_d(length(x_L_d)),num2str(X)),'Rotation',-angle+180,'HorizontalAlignment','right','VerticalAlignment','bottom'); 
            end
        end
    end
end
%plot imaginary axis 
plot(zeros(1,length(Gr)),Gr,'k'); 
wavelengths = 0:.01:.5;
angle = linspace(pi,-pi,length(wavelengths));
wave_circle = 1.05*exp(1i*phaseAngle);
plot(real(wave_circle),imag(wave_circle),'r');
for i=1:length(wavelengths)-1
    x=real(1.025*exp(1i*angle(i)));
    y=imag(1.025*exp(1i*angle(i)));
    if(x>0)
        rot_angle=atan(y/x)*180/pi-90;
    else
        rot_angle=atan(y/x)*180/pi+90; 
    end
    if(wavelengths(i)==0)
        word = '0.00';
    elseif(mod(wavelengths(i),.1)==0)
        word = [num2str(wavelengths(i)) '0'];
    else
        word = num2str(wavelengths(i));
    end
    set(text(x,y,word),'Rotation',rot_angle,'VerticalAlignment','middle','HorizontalAlignment','center')
end




% UIWAIT makes menu_2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = menu_2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in calculate_button.
function calculate_button_Callback(hObject, eventdata, handles)
% hObject    handle to calculate_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = get(gca,'children'); % 获取坐标轴的children属性
delete(h(1));
delete(h(2));
delete(h(3));
delete(h(4));
Z_L_r = str2double(get(handles.edit1,'string'));
Z_L_i = str2double(get(handles.edit2,'string'));
lambda = str2double(get(handles.edit15,'string'));
Z_0 = str2double(get(handles.edit3,'string'));
Z_L = Z_L_r + 1i*Z_L_i;
z_L = Z_L/Z_0;
R = Z_L_r/Z_0;
X = Z_L_i/Z_0;
U = (1-R^2-X^2)/(R^2+2*R+1+X^2);
V = (2*X)/(R^2+2*R+1+X^2);
gama = sqrt((R^2-2*R+1+X^2)/(R^2+2*R+1+X^2));
tr = 2*pi*(0:0.01:1);
plot(gama*cos(tr),gama*sin(tr),'k')
axis([-1.1,1.1,-1.1,1.1]);
% 等归一化电阻圆
for rr = 1/(1+R)
    cr = 1-rr;
    plot(cr+rr*cos(tr),rr*sin(tr),'m')
end
for x=X
    rx= 1/x;
    cx= rx;
    tx=2* atan(x) * (0:0.01:1);
    if tx<pi
        plot(1-rx*sin(tx),cx-rx*cos(tx),'m')
    else 
        plot(1-rx*sin(tx),-cx+rx*cos(tx),'m') 
    end
end
U = @(R,X)(R^2+X^2-1)/(R^2+2*R+1+X^2);
V = @(R,X)(2*X)/(R^2+2*R+1+X^2);
theta=0:pi/100:2*pi;
r = 0.02;
x = U(Z_L_r/Z_0,Z_L_i/Z_0) + r*cos(theta);
y = V(Z_L_r/Z_0,Z_L_i/Z_0) + r*sin(theta);
plot(x,y,'m')
x_line = linspace(0,1/gama*U(Z_L_r/Z_0,Z_L_i/Z_0),100);
y_line = linspace(0,1/gama*V(Z_L_r/Z_0,Z_L_i/Z_0),100);
plot(x_line,y_line,'b')
%反射系数圆
gama1 = (z_L - 1)/(z_L + 1);
SWR = (1 + abs(gama1))/(1 - abs(gama1));
set(handles.edit4,'String',SWR)
%计算SWR
gama2 = abs((z_L - 1)/(z_L + 1));
set(handles.edit5,'String',gama2)
y_line = linspace(-1.1,0,10);
x_line = linspace(gama2,gama2,10);
plot(x_line,y_line,'r');
theta=0:pi/100:2*pi;
r = 0.02;
x_circle = gama2 + r*cos(theta);
y_1_circle = r*sin(theta);
y_2_circle = -1.1 + r*sin(theta);
plot(x_circle,y_1_circle,x_circle,y_2_circle,'b')
%计算反射系数
gama3 = (z_L - 1)/(z_L + 1);
k = (1 - abs(gama3))/(1 + abs(gama3));
set(handles.edit13,'String',k)
%计算行波系数
Z_in_r = real(Z_0*(Z_L+1i*Z_0*tan(lambda*2*pi))/(Z_0+1i*Z_L*tan(lambda*2*pi)));
Z_in_i = imag(Z_0*(Z_L+1i*Z_0*tan(lambda*2*pi))/(Z_0+1i*Z_L*tan(lambda*2*pi)));
gama4 = abs((z_L - 1)/(z_L + 1));
set(handles.edit8,'String',Z_in_r)
set(handles.edit9,'String',Z_in_i)
U = @(R,X)(R^2+X^2-1)/(R^2+2*R+1+X^2);
V = @(R,X)(2*X)/(R^2+2*R+1+X^2);
theta=0:pi/100:2*pi;
r = 0.02;
x_circle = U(Z_in_r/Z_0,Z_in_i/Z_0) + r*cos(theta);
y_circle = V(Z_in_r/Z_0,Z_in_i/Z_0) + r*sin(theta);
plot(x_circle,y_circle,'r')
x_line = linspace(0,1/gama4*U(Z_in_r/Z_0,Z_in_i/Z_0),100);
y_line = linspace(0,1/gama4*V(Z_in_r/Z_0,Z_in_i/Z_0),100);
plot(x_line,y_line,'b')
%计算输入阻抗
Z_in = Z_in_r + 1i*Z_in_i;
Y_in = 1/Z_in;
Y_in_r = real(Y_in);
Y_in_i = imag(Y_in);
set(handles.edit10,'String',Y_in_r);
set(handles.edit12,'String',Y_in_i);
z_L = Z_L/Z_0;
gama5 = abs((z_L - 1)/(z_L + 1));
U = @(R,X)(R^2+X^2-1)/(R^2+2*R+1+X^2);
V = @(R,X)(2*X)/(R^2+2*R+1+X^2);
theta=0:pi/100:2*pi;
r = 0.02;
x_circle = -U(Z_in_r/Z_0,Z_in_i/Z_0) + r*cos(theta);
y_circle = -V(Z_in_r/Z_0,Z_in_i/Z_0) + r*sin(theta);
plot(x_circle,y_circle,'y')
x_line = linspace(0,-1/gama5*U(Z_in_r/Z_0,Z_in_i/Z_0),100);
y_line = linspace(0,-1/gama5*V(Z_in_r/Z_0,Z_in_i/Z_0),100);
plot(x_line,y_line,'b')
%计算输入导纳

% --- Executes on button press in clear_button.
function clear_button_Callback(hObject, eventdata, handles)
% hObject    handle to clear_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.axes1;
cla reset;
global flag0;
flag0 = 0;
% zoom reset;
set(handles.edit1,'String','');
set(handles.edit2,'String','');
set(handles.edit3,'String','');
set(handles.edit4,'String','');
set(handles.edit5,'String','');
set(handles.edit8,'String','');
set(handles.edit9,'String','');
set(handles.edit10,'String','');
set(handles.edit12,'String','');
set(handles.edit13,'String','');
set(handles.edit15,'String','');
set(handles.edit31,'String','');
set(handles.edit32,'String','');
set(handles.edit33,'String','');
set(handles.edit34,'String','');
set(handles.axes1,'XLim',[-1.1,1.1],'YLim',[-1.1,1.1]);

% 初始化图像
global flag0;
flag0 = 1;
axis square;
wavelengths = 0:.01:.5;
phaseAngle = linspace(pi,-pi,length(wavelengths));
wave_circle = 1.05*exp(1i*phaseAngle);
plot(real(wave_circle),imag(wave_circle),'b');
hold on;
% 标注虚轴刻度
for i=1:length(wavelengths)-1
    x=real(1.025*exp(1i*phaseAngle(i)));
    y=imag(1.025*exp(1i*phaseAngle(i)));
    if(x>0)
        rot_angle=atan(y/x)*180/pi-90;
    else
        rot_angle=atan(y/x)*180/pi+90;
    end
    if(wavelengths(i)==0)
        word = '0.00';
    elseif(mod(wavelengths(i),.1)==0)
        word =[num2str(wavelengths(i)) '0'];
    else
        word = num2str(wavelengths(i));
    end
    set(text(x,y,word),'Rotation',rot_angle,'VerticalAlignment','middle','HorizontalAlignment','center')
end
% 坐标轴范围
set(handles.axes1,'XLim',[-1.1,1.1],'YLim',[-1.1,1.1]);
interval = [.01:.01:.2,.22:.02:.5,.55:.05:1,1.1:.1:2 , 2.2:.2:5 , 6:10 , 12:2:20 , 30:10:50];
% interval2 = [.01:.01:.5 , .55:.05:1 , 1.1:.1:2 , 2.2:.2:5 , 6:10 , 12:2:20 , 30:10:50];
% 画电阻圆族
U = @(R,X)(R^2+X^2-1)/(R^2+2*R+1+X^2);
% V = @(R,X)(2*X)/(R^2+2*R+1+X^2);
MAX = 2019;
min_bound1 = 0;
min_bound2 = 0;
max_bound2 = 0;
Gr = linspace(-1,1,MAX);
axis square
plot(Gr, zeros(1,length(Gr)),'k');
hold on
for R = interval
    min_bound1 = (R-1)/(R+1);
    if (R<0.2)
        if (mod(R,0.1) == 0)
            max_bound = U(R,2);
        elseif (mod(R,0.02) == 0)
            max_bound = U(R,0.5);
        else
            max_bound = U(R,0.2);
        end
        if(R == 0.05 || (R<0.151 && R>0.149)) 
            min_bound2 = U(R,0.5);
            max_bound2 = U(R,1);
        end
    elseif (R<0.5)
        if (mod(R,0.2) == 0)
            max_bound = U(R,5);
        elseif (mod(R,0.1) == 0)
            max_bound = U(R,2);
        elseif (R == 0.55 || R == 0.65 || R == 0.75)
            temp = U(R,0.5);
            min_bound2 = max(min_bound1,temp);
            max_bound = U(R,1);
        else
            max_bound = U(R,0.5);
        end
    elseif (R<1)
        if (mod(R,0.2) == 0)
            max_bound = U(R,5);
        elseif (mod(R,0.1) == 0)
            max_bound = U(R,2);
        elseif (R == 0.25 || R == 0.35 || R == 0.45)
            temp = U(R,0.5);
            min_bound2 = max(min_bound1,temp);
            max_bound = U(R,1);
        elseif (R<0.5)
            max_bound = U(R,0.5);
        else
            max_bound = U(R,1);
        end
    elseif (R<5)
        if (mode(R,2) == 0)
            max_bound = U(R,20);
        elseif (mod(R,1) == 0)
            max_bound = U(R,10);
        elseif (R>2)
            max_bound = U(R,5);
        else
            if (mod(R,0.2) == 0)
                max_bound = U(R,5);
            else
                max_bound = U(R,2);
            end
        end
    elseif (R<10)
        if (mod(R,2) == 0)
            max_bound = U(R,20);
        else
            max_bound = U(R,10);
        end
    else
        if (R == 10 || R == 20)
            max_bound = U(R,50);
        elseif (R == 50)
            max_bound = 1;
        elseif (R<20)
            max_bound = U(R,20);
        else
            max_bound = U(R,50);
        end
    end
    index = ceil((min_bound1 + 1)*(MAX - 1)/2 + 1);
    actual_value = Gr(index);
    if (actual_value<min_bound1)
        index = index + 1; 
    end
    MIN=index;
    index = ceil((max_bound + 1)*(MAX - 1)/2 + 1);
    actual_value = Gr(index);
    if (actual_value>max_bound)
        index = index - 1;
    end
    MIN2 = ceil((min_bound2 + 1)*(MAX - 1)/2 + 1);
    actual_value = Gr(MIN2);
    if (actual_value<min_bound2)
        MIN2 = MIN2 + 1;
    end
    MAX2 = ceil((max_bound2+1)*(MAX-1)/ 2+1);
    actual_value = Gr(MAX2);
    if(actual_value<max_bound2)
        MAX2 = MAX2 + 1;
    end
    r_L_a=1/(R+1)*(-(R+1)*(R-2*R.*Gr(MIN:index)+ R.*Gr(MIN:index).^2-1+Gr(MIN:index).^2)).^(1/ 2 );
    r_L_b=-1/(R+1)*(-(R+1)*(R-2*R.*Gr(MIN:index)+ R.*Gr(MIN:index).^2-1+Gr(MIN:index).^2)).^(1/ 2 );
    r_L_b(1)=0;
    r_L_a(1)=0;
    r_L_a2=1/(R+1)*(-(R+1)*(R-2*R.*Gr(MIN2:MAX2 )+R.*Gr(MIN2:MAX2).^2-1+Gr(MIN2:MAX2).^2)).^(1/2);
    r_L_b2=-1/(R+1)*(-(R+1)*(R-2*R.*Gr(MIN2:MAX2)+R.*Gr(MIN2:MAX2).^2-1+Gr(MIN2:MAX2).^2 )).^(1/2);
    r_L_a3=1/(R+1)*(-(R+1)*(R-2*R.*Gr(MIN2:index) +R.*Gr(MIN2:index).^2-1+Gr(MIN2:index).^2)).^(1/2);
    r_L_b3=-1/(R+1)*(-(R+1)*(R-2*R.*Gr(MIN2:index)+R.*Gr(MIN2:index).^2-1+Gr(MIN2:index).^2)).^(1/2);
    if(~(R>.2 && R<.5 && ~(mod(R,.02)==0)))
        if(R==1)
            color = 'r';
        else
            color ='b';
        end
    end
    plot(Gr(MIN:index),r_L_a(1:index-MIN+1),color,Gr(MIN:index), r_L_b(1:index-MIN+1),color);
    if(R<=1)
        if(mod(R,1)==0)
            word = [num2str(R) '.0'];
        else
            word = num2str(R);
        end
        if(mod(R,.1)==0)
            set(text(Gr(MIN),0,word),'Rotation',90,'HorizontalAlignment','left','VerticalAlignment','bott om');
        end
    elseif(R<=2)
        if(mod(R,.2)==0)
            if(mod(R,1)==0)
                word = [num2str(R) '.0'];
            else
                word = num2str(R);
            end
            set(text(Gr(MIN),0,word),'Rotation',90,'HorizontalAlignment','left','VerticalAlignment','bott om');
        end
    elseif(R<=5)
        if(mod(R,1)==0)
            set(text(Gr(MIN),0,[num2str(R) '.0']),'Rotation',90,'HorizontalAlignment','left','VerticalAlignment','bottom');
        elseif(mod(R,10)==0) 
            set(text(Gr(MIN),0,num2str(R)),'Rotation',90,'HorizontalAlignment','left','VerticalAlignment' ,'bottom'); 
        end
    elseif(R == 0.25 || R == 0.35 || R==0.45)
        plot(Gr(MIN2:index),r_L_a3,'b');
        plot(Gr(MIN2:index),r_L_b3,'b');
    elseif(R==.05 || (R>.149 && R<.151)) 
        plot(Gr(MIN2:MAX2),r_L_a2(length(Gr(MIN2:MAX2))-length(r_L_a2)+1:length(r_L_a2)),'b'); 
        plot(Gr(MIN2:MAX2),r_L_b2(length(Gr(MIN2:MAX2))-length(r_L_b2)+1:length(r_L_b2)),'b');
    end
end
% 画电抗圆族
for X = interval
    inter_bound = (-1+X^2)/(X^2+1);
    imag_bound = (-1+X)/X;
    angle_point = 0;
    if(inter_bound ~= 0)
        angle_point = sqrt(1-inter_bound^2)/inter_bound;
    end
    imag_bound_y = 1/2/X*(-2+2*(1-X^2+2*X^2.*inter_bound-X^2.*inter_bound.^2).^(1/2));
    imag_rad = (imag_bound^2 + imag_bound_y^2)^(1/2);
    condition = imag_rad < 1;
    if(inter_bound > 1)
        inter_bound = 1;
    elseif(inter_bound < -1)
        imag_bound=-1;
    end
    if(imag_bound > 1)
        imag_bound = 1;
    elseif(imag_bound < -1)
        imag_bound=-1;
    end
    if(X<0.2)
        if(mod(X,.1)==0)
            max_bound = U(2,X);
        elseif(mod(X,.02)==0)
            max_bound = U(0.5,X);
        else
            max_bound = U(0.2,X);
        end
    elseif(X<1)
        if(mod(X,0.2) == 0)
            max_bound = U(5,X);
        elseif(mod(X,0.1) == 0)
            max_bound = U(2,X);
        elseif(x<0.5)
            max_bound = U(0.5,X);
        else
            max_bound = U(1,X);
        end
    elseif(X<5)
        if(mod(X,2) == 0)
            max_bound = U(20,X);
        elseif(mod(X,1) == 0)
            max_bound = U(10,X);
        elseif(x>2)
            max_bound = U(5,X);
        else
            if(mod(X,0.2) == 0)
                max_bound = U(5,X);
            else
                max_bound = U(2,X);
            end
        end
    elseif(X<10)
        if(mod(X,2) == 0)
            max_bound = U(20,X);
        else
            max_bound = U(10,X);
        end
    else
        if(X == 10 || X == 20)
            max_bound = U(50,X);
        elseif(X == 50)
            max_bound = 1;
        elseif(X<20)
            max_bound = U(20,X);
        else
            max_bound = U(50,X);
        end
    end
    inter_index = ceil((inter_bound+1)*(MAX-1)/ 2+1);
    imag_index = ceil((imag_bound+1)*(MAX-1)/ 2+1);
    index4 = ceil((max_bound+1)*(MAX-1)/ 2+1);
    index1 = max(inter_index,imag_index);
    index2 = min(imag_index,inter_index);
    if(condition)
        index3=imag_index;
    else
        index3=inter_index;
    end 
    actual_value1 = Gr(index1);
    actual_value2 = Gr(index2);
    actual_value3 = Gr(index3);
    actual_value4 = Gr(index4);
    if((actual_value1 > inter_bound && index1 == inter_index)||(actual_value1 > imag_bound && index1 == imag_index))
        index1 = index1 - 1;
    end
    if((actual_value2 < inter_bound && index2 == inter_index)||(actual_value2 < imag_bound && index2 == imag_index))
        index2 = index2 + 1;
    end
    if((actual_value3 < inter_bound && index3 == inter_index)||(actual_value3 < imag_bound && index3 == imag_index))
        index3 = index3 + 1; 
    end
    if(actual_value4 > max_bound)
        index4 = index4 - 1;
    end
    MIN = index2;
    MAX2 = index1;
    MAX3 = index4;
    MIN2 = index3;
    x_L_a = real(1/2/X*(-2+2*(1-X^2+2*X^2.*Gr(MIN2:MAX3 )-X^2.*Gr(MIN2:MAX3).^2).^(1/ 2)));
    x_L_b = real(1/2/X*(2-2*(1-X^2+2*X^2.*Gr(MIN2:MAX3)-X^2.*Gr(MIN2:MAX3).^2).^(1 /2)));
    x_L_c= real(1/2/X*(2+2*(1-X^2+2*X^2.*Gr(MIN:MAX2)-X^2.*Gr(MIN:MAX2).^2).^(1/ 2)));
    x_L_d= real(1/2/X*(-2-2*(1-X^2+2*X^2.*Gr(MIN:MAX2)-X^2.*Gr(MIN:MAX2).^2).^(1/ 2)));
    if(MIN2<MAX3)
        x_L_c(1)=x_L_b(1);
        x_L_d(1)=x_L_a(1);
    end
    check1 = abs(round(10000*1 /2/X*(-2-2*(1-X^2+2*X^2*inter_bound-X^2*inter_bound^2)^(1/2))));
    check2 = abs(round(10000*(1-inter_bound^2)^(1 /2))); 
    if(imag_bound > -1 && check1 == check2)
        plot(Gr(MIN:MAX2),x_L_c,'g')
        plot(Gr(MIN:MAX2),x_L_d,'g')
    end
    plot(Gr(MIN2:MAX3),x_L_a,'g')
    plot(Gr(MIN2:MAX3),x_L_b,'g') 
    condition = Gr(MIN2)^2 + x_L_d(1)^2 > .985;
    if(X<=1)
        if(mod(X,.1)==0)
            if(mod(X,1)==0)
                word = [num2str(X) '.0'];
            else
                word = num2str(X);
            end
            if(X==1)
                angle = 90;
            else
                angle = -atan(angle_point)*180/pi;
                set(text(Gr(MIN2),x_L_d(1),word),'Rotation',angle,'VerticalAlignment','bottom','HorizontalAlignment','left'); 
                set(text(Gr(MIN2),-x_L_d(1),word),'Rotation',-angle+180,'HorizontalAlignment','right','VerticalAlignment','bottom');
            end
            if(mod(X,.2)==0)
            xval = X^2/(X^2+4);
            yval = 1/2/X*(-2+2*(1-X^2+2*X^2*xval-X^2*xval^2)^(1/2));
            angle = -atan(yval/(.5-xval))*180/pi;
            set(text(xval,yval,word),'Rotation',angle,'HorizontalAlignment','left','VerticalAlignment','bottom');
            set(text(xval,-yval,word),'Rotation',-angle+180,'HorizontalAlignment','right','VerticalAlignment','bottom')
            end
        end
    elseif(X<=2)
        if(mod(X,.2)==0)
            if(mod(X,1)==0)
                word = [num2str(X) '.0'];
            else
                word = num2str(X);
            end
            if(condition)
                angle = -atan(angle_point)*180/pi+180;
                set(text(Gr(MIN2),x_L_a(1),word),'Rotation',angle,'VerticalAlignment','bottom','HorizontalAlignm ent','left'); 
                set(text(Gr(MIN2),-x_L_a(1),word),'Rotation',-angle+180,'HorizontalAlignment','right','VerticalAli gnment','bottom');
            else
                angle = -atan(angle_point)*180/pi+180; 
                set(text(Gr(MAX2),x_L_d(length(x_L_d)),word),'Rotation',angle,'VerticalAlignment','botto m','HorizontalAlignment','left'); 
                set(text(Gr(MAX2),-x_L_d(length(x_L_d)),word),'Rotation',-angle+180,'HorizontalAlignment' ,'right','VerticalAlignment','bottom');
            end
        end
    elseif(X<=5)
        if(mod(X,1)==0)
            if(condition)
                angle = -atan(angle_point)*180/pi+180;
                set(text(Gr(MIN2),x_L_a(1),[num2str(X) '.0']),'Rotation',angle,'VerticalAlignment','botto m','HorizontalAlignment','left');
            set(text(Gr(MIN2),-x_L_a(1),[num2str(X) '.0']),'Rotation',-angle+180,'HorizontalAlignment ','right','VerticalAlignment','bottom');
            else
                angle = -atan(angle_point)*180/pi+180;
                set(text(Gr(MAX2),x_L_d(length(x_L_d)),[num2str(X) '.0']),'Rotation',angle,'VerticalAlignment','bottom','HorizontalAlignment','left'); 
                set(text(Gr(MAX2),-x_L_d(length(x_L_d)),[num2str(X) '.0']),'Rotation',-angle+180,'HorizontalAlignment','right','VerticalAlignment','bottom');
            end
        end
    else
        if(mod(X,10)==0)
            if(condition)
                angle = -atan(angle_point)*180/pi+180;
                set(text(Gr(MIN2),x_L_a(1),num2str(X)),'Rotation',angle,'VerticalAlignment','bottom','HorizontalAlignment','left'); 
                set(text(Gr(MIN2),-x_L_a(1),num2str(X)),'Rotation',-angle+180,'HorizontalAlignment','right','VerticalAlignment','bottom');
            else
                angle = -atan(angle_point)*180/pi+180; 
                set(text(Gr(MAX2),x_L_d(length(x_L_d)),num2str(X)),'Rotation',angle,'VerticalAlignment','bottom','HorizontalAlignment','left'); 
                set(text(Gr(MAX2),-x_L_d(length(x_L_d)),num2str(X)),'Rotation',-angle+180,'HorizontalAlignment','right','VerticalAlignment','bottom'); 
            end
        end
    end
end
%plot imaginary axis 
plot(zeros(1,length(Gr)),Gr,'k'); 
wavelengths = 0:.01:.5;
angle = linspace(pi,-pi,length(wavelengths));
wave_circle = 1.05*exp(1i*phaseAngle);
plot(real(wave_circle),imag(wave_circle),'r');
for i=1:length(wavelengths)-1
    x=real(1.025*exp(1i*angle(i)));
    y=imag(1.025*exp(1i*angle(i)));
    if(x>0)
        rot_angle=atan(y/x)*180/pi-90;
    else
        rot_angle=atan(y/x)*180/pi+90; 
    end
    if(wavelengths(i)==0)
        word = '0.00';
    elseif(mod(wavelengths(i),.1)==0)
        word = [num2str(wavelengths(i)) '0'];
    else
        word = num2str(wavelengths(i));
    end
    set(text(x,y,word),'Rotation',rot_angle,'VerticalAlignment','middle','HorizontalAlignment','center')
end

function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit13 as text
%        str2double(get(hObject,'String')) returns contents of edit13 as a double


% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit14_Callback(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit14 as text
%        str2double(get(hObject,'String')) returns contents of edit14 as a double


% --- Executes during object creation, after setting all properties.
function edit14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit15_Callback(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit15 as text
%        str2double(get(hObject,'String')) returns contents of edit15 as a double


% --- Executes during object creation, after setting all properties.
function edit15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: place code in OpeningFcn to populate axes1


% --------------------------------------------------------------------
function menu_1_Callback(hObject, eventdata, handles)
% hObject    handle to menu_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h=gcf; menu_1; close(h);

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


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2



function edit17_Callback(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit17 as text
%        str2double(get(hObject,'String')) returns contents of edit17 as a double


% --- Executes during object creation, after setting all properties.
function edit17_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit18_Callback(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit18 as text
%        str2double(get(hObject,'String')) returns contents of edit18 as a double


% --- Executes during object creation, after setting all properties.
function edit18_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit33_Callback(hObject, eventdata, handles)
% hObject    handle to edit33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit33 as text
%        str2double(get(hObject,'String')) returns contents of edit33 as a double


% --- Executes during object creation, after setting all properties.
function edit33_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit32_Callback(hObject, eventdata, handles)
% hObject    handle to edit32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit32 as text
%        str2double(get(hObject,'String')) returns contents of edit32 as a double


% --- Executes during object creation, after setting all properties.
function edit32_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit31_Callback(hObject, eventdata, handles)
% hObject    handle to edit31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit31 as text
%        str2double(get(hObject,'String')) returns contents of edit31 as a double


% --- Executes during object creation, after setting all properties.
function edit31_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% set(handles.pushbutton3,'Enable','off');
% set(handles.pushbutton10,'Enable','off');
Z_L_r = str2double(get(handles.edit1,'string'));
Z_L_i = str2double(get(handles.edit2,'string'));
lambda = str2double(get(handles.edit15,'string'));
Z_0 = str2double(get(handles.edit3,'string'));
zl = Z_L_r + 1i*Z_L_i;
%%%%%
aida = (zl-1)/(zl+1);
abs_a = abs(aida);
b = 2*abs_a/sqrt(1-abs_a^2);
L1 = distance(0,j*1/b);
L2 = distance(0,-j*1/b);
d1 = distance(zl,1/(1+j*b));
d2 = distance(zl,1/(1-j*b));
set(handles.edit31,'string',num2str(d1))
set(handles.edit32,'string',num2str(d2))
set(handles.edit33,'string',num2str(L1))
set(handles.edit34,'string',num2str(L2))

function d = distance(zl, z)
%函数distance返回输入阻抗为z的点距负载zl的距离
if(z==Inf)
    d=0.25;
else
d = real(atan((z - zl)/j/(1-z*zl))/2/pi);
end
if (d<0)
    d = d+0.5;
end


function edit34_Callback(hObject, eventdata, handles)
% hObject    handle to edit34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit34 as text
%        str2double(get(hObject,'String')) returns contents of edit34 as a double


% --- Executes during object creation, after setting all properties.
function edit34_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
