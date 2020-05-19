Line=[1,-1];
Light=[1,0];
abs_Line=sqrt(Line*Line');
abs_Light=sqrt(Light*Light');

E_Line=Line./abs_Line;     %线的单位方向向量
V_Line=E_Line*[0 -1;1 0];  %将E_Line顺时针旋转pi/2

abs_L_Line=(Line*Light')/abs_Line;
abs_V_Line=sqrt(abs_Light*abs_Light-abs_L_Line*abs_L_Line);

r=abs_L_Line*E_Line+abs_V_Line*V_Line;
