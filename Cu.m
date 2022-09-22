function dydt=Cu(t,y)
% this is the function of single spring-damper system 
% m*d2(x) + c*d(x) + x =0
% transfer this function to
% y(1) equals x; y(2) equals x';
% d(y(1)) = y(2)
% d(y(2)) = -(c/m)*y(2) - (k/m)*y(1)

%m=1
c=1;
k=500;
dydt=[y(2);-c*y(2)-k*y(1)];
end