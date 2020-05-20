function r=Cal(Line,Light)

abs_Line=sqrt(Line*Line');
abs_Light=sqrt(Light*Light');

E_Line=Line./abs_Line;     %线的单位方向向量
V_Line=E_Line*[0 -1;1 0];  %将E_Line顺时针旋转pi/2

abs_L_Line=(Line*Light')/abs_Line;                          %计算平行分量
abs_V_Line=sqrt(abs_Light*abs_Light-abs_L_Line*abs_L_Line); %计算垂直分量

r=abs_L_Line*E_Line+abs_V_Line*V_Line;
