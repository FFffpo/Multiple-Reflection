syms px py;

Line=[1,-0.3];    %直线方向向量
Light=[1,0.01];   %光线入射方向向量
h=0;              %直线与y轴交点纵坐标
L=-1;             %直线右端横坐标
x0=-15;           %直线左端横坐标
px=-15;           %(px,py)光线入射点
py=0.5;

py0=py;
px0=px;
Line_Ex=Line*[1;0];
Line_Ey=Line*[0;1];
Light_Ex=Light*[1;0];
Light_Ey=Light*[0;1];
Light_Ex0=Light*[1;0];
Light_Ey0=Light*[0;1];

syms x y;
vars=[x,y];

%N为最大反射次数，如果不够可进行调整
N=70;
Xrr=zeros(N+1,1);
Yrr=zeros(N+1,1);
i_out_range=N;
if_out_rangeR=0;
if_out_rangeL=0;

for i=1:N
    eqns1=[Light_Ex*(y-py)==Light_Ey*(x-px),Line_Ex*(y-h)==Line_Ey*(x-0)];
    Xrr(i)=px;
    Yrr(i)=py;
    if mod(i,2)==1
        [px,py]=solve(eqns1,vars);
        Light=Cal(Line,Light);
    else
        px=-Light_Ex*py/Light_Ey+px;
        py=0;
        Light=Cal2([1 0],Light);
    end
    Light_Ex=Light*[1;0];
    Light_Ey=Light*[0;1];
    
    %判断出界
    if i==1
        if px>L
            i_out_range=i;
            if_out_rangeR=1;
            Xrr(i+1)=px;
            Yrr(i+1)=py;
            break;
        end           
    else
        if Light_Ex>0 && (px>L||px < Xrr(i-1))
            i_out_range=i;
            if_out_rangeR=1;
            Xrr(i+1)=px;
            Yrr(i+1)=py;
            break;
        end
        if  Light_Ex<0 
            if py<0
                i_out_range=i;
                if_out_rangeL=1;
                Xrr(i+1)=x0;
                Yrr(i+1)=Yrr(i)-Light_Ey/Light_Ex*(Xrr(i)-x0);
                break;
            end
            if px<x0
                i_out_range=i;
                if_out_rangeL=1;
                Xrr(i+1)=px;
                Yrr(i+1)=py;
                break;
            end
        end
    end
 
end

%删去多余的数组
if if_out_rangeR==1||if_out_rangeL==1
    Xrr(i_out_range+2:N+1)=[];
    Yrr(i_out_range+2:N+1)=[];
else
    Xrr(N+1)=[];
    Yrr(N+1)=[];
end

%绘图-实际反射
subplot(121)
plot(Xrr,Yrr,'LineWidth',2);
axis equal;
grid on;
box on;
if if_out_rangeR==1
    title('右出界')
end
if if_out_rangeL==1
    title('左出界')
end
hold on
fplot(@(x) 0*x,[x0,L],'r','LineWidth',2.5);
k=Line_Ey/Line_Ex;
plot([x0 L],k*[x0 L]+h,'r','LineWidth',2.5)

%绘图-平面镜对称
subplot(122)
abs_Line=sqrt(Line*Line');
theta=acos(Line*[1 0]'/abs_Line);
coss=cos(theta);
sinn=sin(theta);
r=[coss -sinn;sinn coss];
count=1;

plot([L x0],[0 0],'r','LineWidth',2.5);
axis equal;
grid on;
hold on
while count<=floor(pi/theta)+1
    Line_Ex=Line*[1;0];
    Line_Ey=Line*[0;1];
    k=Line_Ey/Line_Ex;
    Lx=L*cos(count*theta);
    x=x0*cos(count*theta);
    if Lx<0
        plot([x Lx],k*[x Lx],'r','LineWidth',2.5);
    end
    if Lx==0
        plot([0 0],[0 -L],'r','LineWidth',2.5);
    end
    if Lx>0
        plot([Lx x],k*[Lx x],'r','LineWidth',2.5);
    end
    Line=Line*r;
    count=count+1;
end
k=Light_Ey0/Light_Ex0;
plot([x0 -x0],k*[x0-x0 -x0-x0]+py0,'LineWidth',2)
