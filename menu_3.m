function varargout = menu_3(varargin)
%MENU_3 M-file for menu_3.fig
%      MENU_3, by itself, creates a new MENU_3 or raises the existing
%      singleton*.
%
%      H = MENU_3 returns the handle to a new MENU_3 or the handle to
%      the existing singleton*.
%
%      MENU_3('Property','Value',...) creates a new MENU_3 using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to menu_3_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      MENU_3('CALLBACK') and MENU_3('CALLBACK',hObject,...) call the
%      local function named CALLBACK in MENU_3.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help menu_3

% Last Modified by GUIDE v2.5 04-May-2020 17:53:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @menu_3_OpeningFcn, ...
                   'gui_OutputFcn',  @menu_3_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before menu_3 is made visible.
function menu_3_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)
global pic2 edit1 input text5 text6 flag1 edit19 edit20 edit24 edit25;
handles.output = hObject;
edit1=handles.edit1;
text5=handles.text5;
text6=handles.text6;
edit19=handles.edit19;
edit20=handles.edit20;
edit24=handles.edit24;
edit25=handles.edit25;
flag1=1;
pic2=handles.smith;
handles.current_d2=0.125;
handles.current_type = 'u';
input = 'z';
background
set(gcf,'WindowButtonMotionFcn',@draw)
set(gcf,'WindowButtonDownFcn',@button)

% Choose default command line output for menu_3
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes menu_3 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = menu_3_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function circle(x0,y0,r,color,linetype)
%画圆
t=0:0.01:2*pi;
x=x0+cos(t)*r;
y=y0+sin(t)*r;
plot(x,y,linetype,'LineWidth',1,'color',color);

function arch_x(x0,color)
%画弧
if x0>0
    if x0>=1
    theta=pi-asin(2*x0/(x0^2+1));
    else
        theta=asin(2*x0/(x0^2+1));
    end;
    t=0:0.01:theta;
    x=1-sin(t)*abs(1/x0);
        y=1/x0-cos(t)*abs(1/x0);
        plot(x,y,'-','LineWidth',1,'color',color);
elseif x0<0
    if x0<-1
    theta=pi+asin(2*x0/(x0^2+1));
    else
       theta=-asin(2*x0/(x0^2+1));
    end;
        t=0:0.01:theta;
        x=1-sin(t)*abs(1/x0);
        y=1/x0+cos(t)*abs(1/x0);
        plot(x,y,'-','LineWidth',1,'color',color);
end

function background 
%原图背景
global pic2;
subplot(pic2);
set(gca,'XLim',[-1.1,1.1],'YLim',[-1.1,1.1]);
% axis([-1,1,-1,1]);
axis off;
box off;

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
set(gca,'XLim',[-1.1,1.1],'YLim',[-1.1,1.1]);
hold on;
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
axis off;
%%%%%%%%%%%%%%%%%%%%%%%%%%%


function  aida_DeleteFcn(hObject, eventdata, handles)


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

function single_stub_match(r,x)
global pic2;
subplot(pic2);
background;
hold on;
gamma=abs((r+x*i-1)/(r+x*i+1));
circle(0,0,gamma,'b','-');
pause(0.5);
circle(0,0,gamma,'w','-');
pause(0.5);
circle(0,0,gamma,'b','-');
pause(0.5);
circle(0,0,gamma,'w','-');
pause(0.5);
circle(0,0,gamma,'b','-');

pause(1);
circle(0.5,0,0.5,'r','-');
pause(0.5);
circle(0.5,0,0.5,'w','-');
pause(0.5);
circle(0.5,0,0.5,'r','-');
pause(0.5);
circle(0.5,0,0.5,'w','-');
pause(0.5);
circle(0.5,0,0.5,'r','-');

plot(gamma^2,sqrt(gamma^2-gamma^4),'kx', 'MarkerSize',10,'LineWidth',2);
plot(gamma^2,-sqrt(gamma^2-gamma^4),'kx','MarkerSize',10,'LineWidth',2);

% --- Executes during object creation, after setting all properties.
function dis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes during object creation, after setting all properties.
function text5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function text6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



% --- Executes during object creation, after setting all properties.
function dis1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dis1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end




% --- Executes during object creation, after setting all properties.
function dis2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dis2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double
global input;
if input == 'z'
    zl = str2double(get(hObject,'String'));
    if isnan(zl)
        errordlg('You must input a number.');
        set(handles.edit1, 'string', '');
    elseif real(zl<0)
        errordlg('The real part cannot be negative.');
        set(handles.edit1, 'string', '');
    end
else
    zl = 1/str2double(get(hObject,'String'));
    if isnan(zl)
        errordlg('You must input a number.');
        set(handles.edit1, 'string', '');
    elseif real(zl<0)
        errordlg('The real part cannot be negative.');
        set(handles.edit1, 'string', '');
    end   
end


% 鼠标部分
function button(hObject, eventdata, handles)
global flag1;
if flag1 == 1
    flag1 = 0;
else
    flag1 = 1;
end;

function draw(hObject, eventdata, handles)
global pic2 edit1 input text5 text6 flag1 edit19 edit20 edit24 edit25;
if flag1 ==1
p = get(gca,'CurrentPoint');
x = p(1);
y = p(3);
if x^2+y^2 < 1
background;
hold on;
set(gca,'XLim',[-1.1,1.1],'YLim',[-1.1,1.1]);
aida = x+y*j;
angle_a = angle(aida);
if angle_a<0
    angle_a = angle_a+2*pi;
end;
zmax = angle_a/4/pi;
if angle_a<pi
    zmin = (angle_a+pi)/4/pi;
else
    zmin = (angle_a-pi)/4/pi;
end;
set(text5,'string',zmax);
set(text6,'string',zmin);
r1 = abs(aida);
zl = (1+aida)/(1-aida);
rou1 = (1+abs(aida))/(1-abs(aida));
% loadtimes = str2double(get(handles.edit21,'string'));
if(input == 'z')
    set(edit1,'string',num2str(zl));
    set(edit19,'string',num2str(real(zl)));
    set(edit20,'string',num2str(imag(zl)));
    set(edit24,'string',num2str(r1));
    set(edit25,'string',num2str(rou1));
else
    set(edit1,'string',num2str(1/zl));
    set(edit19,'string',num2str(real(1/zl)));
    set(edit20,'string',num2str(imag(1/zl)));
    set(edit24,'string',num2str(r1));
    set(edit25,'string',num2str(rou1));
end
r2 = 1/(1+real(zl));
plot(x,y,'x');
circle(0,0,r1,'r','-');
circle(real(zl)/(1+real(zl)),0,r2,'g','-');
arch_x(imag(zl),'b');
hold off;
end
end

% 
% d = str2double(get(handles.dis,'String'));
% zl = str2double(get(handles.edit1,'string'));
% z = (zl+j*tan(2*pi*d))/(1+j*zl*tan(2*pi*d));
% y = 1/z;
% set(handles.zin1,'string',num2str(z))
% set(handles.yin1,'string',num2str(y))



% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on button press in zz.
function zz_Callback(hObject, eventdata, handles)
% hObject    handle to zz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of zz


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
zl = str2double(get(handles.edit1,'string'));
aida = (zl-1)/(zl+1);
rou = (1+abs(aida))/(1-abs(aida));
angle_a = angle(aida);
if angle_a<0
    angle_a = angle_a+2*pi;
end;
zmax = angle_a/4/pi;
if angle_a<pi
    zmin = (angle_a+pi)/4/pi;
else
    zmin = (angle_a-pi)/4/pi;
end;
set(handles.text5,'string',zmax)
set(handles.text6,'string',zmin)
set(handles.aida,'string',abs(aida))
set(handles.rou,'string',rou)
background;
hold on;
plot(real(aida),imag(aida),'x');
circle(0,0,abs(aida),'r','-');
circle(real(zl)/(1+real(zl)),0,1/(1+real(zl)),'g','-');
arch_x(imag(zl),'b');
hold off;

% --- Executes during object creation, after setting all properties.
function smith_CreateFcn(hObject, eventdata, handles)
% hObject    handle to menu_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate menu_3


% --- Executes on mouse press over axes background.
function smith_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to menu_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function uipanel12_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to uipanel12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global input;
if hObject == handles.zz
    input = 'z';
else
    input = 'y';
end
guidata(hObject,handles)


% --- Executes on button press in yy.
function yy_Callback(hObject, eventdata, handles)
% hObject    handle to yy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of yy


% --- Executes during object creation, after setting all properties.
function uipanel2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uipanel2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function edit19_Callback(hObject, eventdata, handles)
% hObject    handle to edit19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% Hints: get(hObject,'String') returns contents of edit19 as text
%        str2double(get(hObject,'String')) returns contents of edit19 as a double


% --- Executes during object creation, after setting all properties.
function edit19_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit20_Callback(hObject, eventdata, handles)
% hObject    handle to edit20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit20 as text
%        str2double(get(hObject,'String')) returns contents of edit20 as a double


% --- Executes during object creation, after setting all properties.
function edit20_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit21_Callback(hObject, eventdata, handles)
% hObject    handle to edit21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit21 as text
%        str2double(get(hObject,'String')) returns contents of edit21 as a double


% --- Executes during object creation, after setting all properties.
function edit21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit22_Callback(hObject, eventdata, handles)
% hObject    handle to edit22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit22 as text
%        str2double(get(hObject,'String')) returns contents of edit22 as a double


% --- Executes during object creation, after setting all properties.
function edit22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit22 (see GCBO)
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



function edit16_Callback(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit16 as text
%        str2double(get(hObject,'String')) returns contents of edit16 as a double


% --- Executes during object creation, after setting all properties.
function edit16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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

% --------------------------------------------------------------------
function menu_1_Callback(hObject, eventdata, handles)
% hObject    handle to menu_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h=gcf; menu_1; close(h);

% --------------------------------------------------------------------
function menu_2_Callback(hObject, eventdata, handles)
% hObject    handle to menu_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h=gcf; menu_2; close(h);


% --- Executes during object creation, after setting all properties.
function aida_CreateFcn(hObject, eventdata, handles)
% hObject    handle to aida (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function edit24_Callback(hObject, eventdata, handles)
% hObject    handle to edit24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit24 as text
%        str2double(get(hObject,'String')) returns contents of edit24 as a double


% --- Executes during object creation, after setting all properties.
function edit24_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit25_Callback(hObject, eventdata, handles)
% hObject    handle to edit25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit25 as text
%        str2double(get(hObject,'String')) returns contents of edit25 as a double


% --- Executes during object creation, after setting all properties.
function edit25_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
